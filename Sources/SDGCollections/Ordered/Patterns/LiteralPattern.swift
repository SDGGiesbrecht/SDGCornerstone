/*
 LiteralPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A pattern for using one collection as a literal pattern to search another.
public struct LiteralPattern<Literal, Searchable>: Pattern
where
  Literal: SearchableCollection,
  Searchable: SearchableCollection,
  Literal.Element == Searchable.Element,
  Searchable.SubSequence: SearchableCollection
{
  // #warning("“Searchable.SubSequence: SearchableCollection” might be problematic.")

  // MARK: - Initialization

  /// Creates a literal pattern.
  ///
  /// - Parameters:
  ///     - literal: The literal to search for.
  @inlinable public init(_ literal: Literal) {
    self.literal = literal
  }

  // MARK: - Properties

  @usableFromInline internal var literal: Literal

  // MARK: - Conversions

  /// Converts the pattern for use searching a different collection type containing the same elements.
  ///
  /// - Parameters:
  ///   - searchTarget: The type of collection to search.
  @inlinable public func converted<SearchTarget>(
    for searchTarget: SearchTarget.Type
  ) -> LiteralPattern<Literal, SearchTarget>
  where SearchTarget: SearchableCollection, SearchTarget.Element == Searchable.Element {
    return LiteralPattern<Literal, SearchTarget>(self.literal)
  }

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<Searchable>

  @inlinable public func matches(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> [AtomicPatternMatch<Searchable>] {
    if let match = primaryMatch(in: collection, at: location) {
      return [match]
    } else {
      return []
    }
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> AtomicPatternMatch<Searchable>? {
    var checkingIndex = literal.startIndex
    var collectionIndex = location
    while checkingIndex ≠ literal.endIndex {
      guard collectionIndex ≠ collection.endIndex else {
        // Ran out of space to check.
        return nil
      }

      if literal[checkingIndex] ≠ collection[collectionIndex] {
        // Mis‐match.
        return nil
      }

      checkingIndex = literal.index(after: checkingIndex)
      collectionIndex = collection.index(after: collectionIndex)
    }

    return AtomicPatternMatch(range: location..<collectionIndex, in: collection)
  }

  @inlinable public func forSubSequence() -> LiteralPattern<Literal, Searchable.SubSequence> {
    return converted(for: Searchable.SubSequence.self)
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<Searchable.SubSequence>,
    in collection: Searchable
  ) -> AtomicPatternMatch<Searchable> {
    // #workaround(Swift 5.6.1, Should be commented line instead, but for compiler bug.)
    return AtomicPatternMatch(range: subSequenceMatch.range, in: collection)
    // return subSequenceMatch.in(collection)
  }
}

extension LiteralPattern: BidirectionalPattern
where Literal: SearchableBidirectionalCollection, Searchable: SearchableBidirectionalCollection {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> LiteralPattern<
    ReversedCollection<Literal>, ReversedCollection<Searchable>
  > {
    let reversedLiteral: ReversedCollection<Literal> = literal.reversed()
    return LiteralPattern<ReversedCollection<Literal>, ReversedCollection<Searchable>>(
      reversedLiteral
    )
  }

  @inlinable public func forward(
    match reversedMatch: AtomicPatternMatch<ReversedCollection<Searchable>>,
    in forwardCollection: Searchable
  ) -> AtomicPatternMatch<Searchable> {
    let range = reversedMatch.range
    return AtomicPatternMatch(
      range: range.upperBound.base..<range.lowerBound.base,
      in: forwardCollection
    )
  }
}
