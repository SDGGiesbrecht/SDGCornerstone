/*
 ConditionalPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A pattern that matches based on a condition.
public struct ConditionalPattern<Searchable>: Pattern
where Searchable: SearchableCollection {

  // MARK: - Initialization

  /// Creates an algorithmic pattern based on a condition.
  ///
  /// - Parameters:
  ///   - condition: The condition an element must meet in order to match.
  @inlinable public init(_ condition: @escaping @Sendable (_ element: Searchable.Element) -> Bool) {
    self.condition = condition
  }

  // MARK: - Properties

  @usableFromInline internal var condition: @Sendable (Searchable.Element) -> Bool

  // MARK: - Conversions

  /// Converts the pattern for use searching a different collection type containing the same elements.
  ///
  /// - Parameters:
  ///   - searchTarget: The type of collection to search.
  @inlinable public func converted<SearchTarget>(
    for searchTarget: SearchTarget.Type
  ) -> ConditionalPattern<SearchTarget>
  where SearchTarget: Collection, SearchTarget.Element == Searchable.Element {
    return ConditionalPattern<SearchTarget>(self.condition)
  }

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<Searchable>

  @inlinable public func matches(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> [AtomicPatternMatch<Searchable>] {
    return primaryMatch(in: collection, at: location).map({ [$0] }) ?? []
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> AtomicPatternMatch<Searchable>? {
    if location ≠ collection.endIndex,
      condition(collection[location])
    {
      return AtomicPatternMatch(
        range: (location...location).relative(to: collection),
        in: collection
      )
    } else {
      return nil
    }
  }

  @inlinable public func forSubSequence() -> ConditionalPattern<Searchable.SubSequence> {
    return converted(for: Searchable.SubSequence.self)
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<Searchable.SubSequence>,
    in collection: Searchable
  ) -> AtomicPatternMatch<Searchable> {
    return subSequenceMatch.in(collection)
  }
}

extension ConditionalPattern: BidirectionalPattern
where Searchable: SearchableBidirectionalCollection {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> ConditionalPattern<ReversedCollection<Searchable>> {
    return converted(for: ReversedCollection<Searchable>.self)
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

extension ConditionalPattern: Sendable {}
