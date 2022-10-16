/*
 NewlinePattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

/// A pattern representing any newline variant.
public struct NewlinePattern<Searchable>: Pattern, Sendable
where Searchable: SearchableCollection, Searchable.Element == Unicode.Scalar {

  // MARK: - Initialization

  @usableFromInline internal init(carriageReturnLineFeed: (Unicode.Scalar, Unicode.Scalar)) {
    carriageReturn = carriageReturnLineFeed.0
    lineFeed = carriageReturnLineFeed.1
  }

  // MARK: - Properties

  @usableFromInline internal let carriageReturn: Unicode.Scalar
  @usableFromInline internal let lineFeed: Unicode.Scalar

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<Searchable>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [AtomicPatternMatch<Searchable>] {
    let scalar = collection[location]
    guard scalar ∈ Newline.characters else {
      return []
    }
    var result = [(location...location).relative(to: collection)]
    if scalar == carriageReturn {
      let nextIndex = collection.index(after: location)
      if nextIndex ≠ collection.endIndex,
        collection[nextIndex] == lineFeed
      {
        result.prepend(location..<collection.index(location, offsetBy: 2))
      }
    }
    return result.map { AtomicPatternMatch(range: $0, in: collection) }
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> AtomicPatternMatch<Searchable>? {
    let scalar = collection[location]
    guard scalar ∈ Newline.characters else {
      return nil
    }
    if scalar == carriageReturn {
      let nextIndex = collection.index(after: location)
      if nextIndex ≠ collection.endIndex,
        collection[nextIndex] == lineFeed
      {
        return AtomicPatternMatch(
          range: location..<collection.index(location, offsetBy: 2),
          in: collection
        )
      }
    }
    return AtomicPatternMatch(
      range: (location...location).relative(to: collection),
      in: collection
    )
  }

  @inlinable public func forSubSequence() -> NewlinePattern<Searchable.SubSequence> {
    return NewlinePattern<Searchable.SubSequence>(
      carriageReturnLineFeed: (carriageReturn, lineFeed)
    )
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

extension NewlinePattern: BidirectionalPattern
where Searchable: SearchableBidirectionalCollection {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> NewlinePattern<ReversedCollection<Searchable>> {
    return NewlinePattern<ReversedCollection<Searchable>>(
      carriageReturnLineFeed: (lineFeed, carriageReturn)
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
