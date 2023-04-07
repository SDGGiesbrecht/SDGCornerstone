/*
 NestingSegmentPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public struct _NestingSegmentPattern<Opening, Closing>: Pattern
where Opening: Pattern, Closing: Pattern, Opening.Searchable == Closing.Searchable {

  // MARK: - Initialization

  @inlinable internal init(
    opening: Opening,
    closing: Closing,
    parentNestingPattern: @escaping @Sendable () -> NestingPattern<Opening, Closing>
  ) {
    self.opening = opening
    self.closing = closing
    self.parentNestingPattern = parentNestingPattern
  }

  // MARK: - Properties

  @usableFromInline internal var opening: Opening
  @usableFromInline internal var closing: Closing
  @usableFromInline internal var parentNestingPattern:
    @Sendable () -> NestingPattern<Opening, Closing>

  // MARK: - Pattern

  public typealias Match = NestingMatchSegment<Opening.Match, Closing.Match>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [NestingMatchSegment<Opening.Match, Closing.Match>] {
    return primaryMatch(in: collection, at: location).map({ [$0] }) ?? []
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> NestingMatchSegment<Opening.Match, Closing.Match>? {
    if closing.primaryMatch(in: collection, at: location) ≠ nil {
      return nil
    } else if let nested = parentNestingPattern().primaryMatch(in: collection, at: location) {
      return .nested(nested)
    } else {
      var cursor = location
      while cursor ≠ collection.endIndex,
        opening.primaryMatch(in: collection, at: cursor) == nil,
        closing.primaryMatch(in: collection, at: cursor) == nil
      {
        cursor = collection.index(after: cursor)
      }
      let range = location..<cursor
      if range.isEmpty {
        return nil
      } else {
        return .other(AtomicPatternMatch(range: range, in: collection))
      }
    }
  }

  @inlinable public func forSubSequence() -> _NestingSegmentPattern<
    Opening.SubSequencePattern, Closing.SubSequencePattern
  > {
    return _NestingSegmentPattern<Opening.SubSequencePattern, Closing.SubSequencePattern>(
      opening: opening.forSubSequence(),
      closing: closing.forSubSequence(),
      parentNestingPattern: { parentNestingPattern().forSubSequence() }
    )
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: NestingMatchSegment<
      Opening.SubSequencePattern.Match, Closing.SubSequencePattern.Match
    >,
    in collection: Searchable
  ) -> NestingMatchSegment<Opening.Match, Closing.Match> {
    switch subSequenceMatch {
    case .nested(let nested):
      return .nested(
        parentNestingPattern().convertMatch(
          from: nested,
          in: collection
        )
      )
    case .other(let other):
      return .other(AtomicPatternMatch(range: other.range, in: collection))
    }
  }
}

extension _NestingSegmentPattern: BidirectionalPattern
where Opening: BidirectionalPattern, Closing: BidirectionalPattern,
  // #workaround(Swift 5.8, The following constraint is redundant; see BidirectionalPattern.Reversed for the reason.)
  Closing.Reversed.Match.Searched == Opening.Reversed.Match.Searched {

  // MARK: - BidirectionalPattern

  public typealias Reversed = _NestingSegmentPattern<Closing.Reversed, Opening.Reversed>

  @inlinable public func reversed() -> _NestingSegmentPattern<Closing.Reversed, Opening.Reversed> {
    return _NestingSegmentPattern<Closing.Reversed, Opening.Reversed>(
      opening: closing.reversed(),
      closing: opening.reversed(),
      parentNestingPattern: { parentNestingPattern().reversed() }
    )
  }

  @inlinable public func forward(
    match reversedMatch: NestingMatchSegment<Closing.Reversed.Match, Opening.Reversed.Match>,
    in forwardCollection: Searchable
  ) -> NestingMatchSegment<Opening.Match, Closing.Match> {
    switch reversedMatch {
    case .nested(let nested):
      return .nested(
        parentNestingPattern().forward(
          match: nested,
          in: forwardCollection
        )
      )
    case .other(let other):
      let reversedMatchRange = other.range
      #warning("Not implemented yet.")
      fatalError()
      /*return .other(
        AtomicPatternMatch(
          range: reversedMatchRange.upperBound.base..<reversedMatchRange.lowerBound.base,
          in: forwardCollection
        )
      )*/
    }
  }
}

extension _NestingSegmentPattern: Sendable where Opening: Sendable, Closing: Sendable {}
