/*
 NestingContentsPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public struct _NestingContentsPattern<Opening, Closing>: Pattern
where Opening: Pattern, Closing: Pattern, Opening.Searchable == Closing.Searchable {

  // MARK: - Initialization

  @inlinable internal init(
    opening: Opening,
    closing: Closing,
    parentNestingPattern: @escaping () -> NestingPattern<Opening, Closing>
  ) {
    self.opening = opening
    self.closing = closing
    self.parentNestingPattern = parentNestingPattern
    self.segmentPattern = _NestingSegmentPattern(
      opening: opening,
      closing: closing,
      parentNestingPattern: parentNestingPattern
    )
  }

  // MARK: - Properties

  @usableFromInline internal var opening: Opening
  @usableFromInline internal var closing: Closing
  @usableFromInline internal var parentNestingPattern: () -> NestingPattern<Opening, Closing>
  @usableFromInline internal var segmentPattern: _NestingSegmentPattern<Opening, Closing>

  // MARK: - Pattern

  public typealias Match = NestingMatchContents<Opening.Match, Closing.Match>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [NestingMatchContents<Opening.Match, Closing.Match>] {
    return [guaranteedPrimaryMatch(in: collection, at: location)]
  }

  @inlinable public func guaranteedPrimaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> NestingMatchContents<Opening.Match, Closing.Match> {
    // ( (   ( ) ( ) )  ( ) )
    var segments: [NestingMatchSegment<Opening.Match, Closing.Match>] = []
    var cursor = location
    while let next = segmentPattern.primaryMatch(in: collection, at: cursor) {
      segments.append(next)
      cursor = next.range.upperBound
    }
    return NestingMatchContents(
      segments: segments,
      contents: collection[location..<cursor]
    )
  }
  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> NestingMatchContents<Opening.Match, Closing.Match>? {
    return guaranteedPrimaryMatch(in: collection, at: location)
  }

  @inlinable public func forSubSequence() -> _NestingContentsPattern<
    Opening.SubSequencePattern, Closing.SubSequencePattern
  > {
    return _NestingContentsPattern<
      Opening.SubSequencePattern, Closing.SubSequencePattern
    >(
      opening: opening.forSubSequence(),
      closing: closing.forSubSequence(),
      parentNestingPattern: { self.parentNestingPattern().forSubSequence() }
    )
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: NestingMatchContents<
      Opening.SubSequencePattern.Match, Closing.SubSequencePattern.Match
    >,
    in collection: Searchable
  ) -> NestingMatchContents<Opening.Match, Closing.Match> {
    return NestingMatchContents<Opening.Match, Closing.Match>(
      segments: subSequenceMatch.segments.lazy.reversed().map({ segment in
        return segmentPattern.convertMatch(from: segment, in: collection)
      }),
      contents: subSequenceMatch.contents
    )
  }
}

extension _NestingContentsPattern: BidirectionalPattern
where Opening: BidirectionalPattern, Closing: BidirectionalPattern {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> _NestingContentsPattern<Closing.Reversed, Opening.Reversed> {
    #warning("Not implemented yet.")
    fatalError()
  }

  @inlinable public func forward(
    match reversedMatch: NestingMatchContents<Closing.Reversed.Match, Opening.Reversed.Match>,
    in forwardCollection: Searchable
  ) -> NestingMatchContents<Opening.Match, Closing.Match> {
    #warning("Not implemented yet.")
    fatalError()
  }
}
