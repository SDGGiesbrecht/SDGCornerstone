/*
 NestingPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that matches nested pairs of other patterns.
public struct NestingPattern<Opening, Closing>: Pattern
where Opening: Pattern, Closing: Pattern, Opening.Searchable == Closing.Searchable {

  // MARK: - Initialization

  /// Creates a nesting pattern from opening and closing patterns.
  ///
  /// - Parameters:
  ///     - opening: The opening pattern.
  ///     - closing: The closing pattern.
  @inlinable public init(opening: Opening, closing: Closing) {
    self.opening = opening
    let contents = _NestingContentsPattern(opening: opening, closing: closing)
    self.contents = contents
    self.closing = closing
    self.concatenatedComponents = opening + contents + closing
  }

  // MARK: - Properties

  @usableFromInline internal var opening: Opening
  @usableFromInline internal var contents: _NestingContentsPattern<Opening, Closing>
  @usableFromInline internal var closing: Closing
  @usableFromInline internal var concatenatedComponents:
    ConcatenatedPatterns<
      ConcatenatedPatterns<Opening, _NestingContentsPattern<Opening, Closing>>,
      Closing
    >

  // MARK: - Pattern

  public typealias Match = NestingMatch<Opening.Match, Closing.Match>

  @inlinable static func unpack(
    concatenatedMatch match: ConcatenatedMatch<
      ConcatenatedMatch<
        Opening.Match, NestingMatchContents<Opening.Match, Closing.Match>
      >,
      Closing.Match
    >,
    in collection: Searchable
  ) -> NestingMatch<Opening.Match, Closing.Match> {
    return NestingMatch<Opening.Match, Closing.Match>(
      opening: match.first.first,
      contents: match.first.second,
      closing: match.second,
      in: collection
    )
  }
  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [NestingMatch<Opening.Match, Closing.Match>] {
    return concatenatedComponents.matches(in: collection, at: location)
      .map { Self.unpack(concatenatedMatch: $0, in: collection) }
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> NestingMatch<Opening.Match, Closing.Match>? {
    return concatenatedComponents.primaryMatch(in: collection, at: location)
      .map { Self.unpack(concatenatedMatch: $0, in: collection) }
  }

  @inlinable public func forSubSequence() -> NestingPattern<
    Opening.SubSequencePattern, Closing.SubSequencePattern
  > {
    return NestingPattern<Opening.SubSequencePattern, Closing.SubSequencePattern>(
      opening: opening.forSubSequence(),
      closing: closing.forSubSequence()
    )
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: NestingMatch<
      Opening.SubSequencePattern.Match, Closing.SubSequencePattern.Match
    >,
    in collection: Searchable
  ) -> NestingMatch<Opening.Match, Closing.Match> {
    return NestingMatch<Opening.Match, Closing.Match>(
      opening: opening.convertMatch(from: subSequenceMatch.opening, in: collection),
      contents: contents.convertMatch(from: subSequenceMatch.levelContents, in: collection),
      closing: closing.convertMatch(from: subSequenceMatch.closing, in: collection),
      in: collection
    )
  }
}

extension NestingPattern: BidirectionalPattern
where Opening: BidirectionalPattern, Closing: BidirectionalPattern {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> NestingPattern<Closing.Reversed, Opening.Reversed> {
    return NestingPattern<Closing.Reversed, Opening.Reversed>(
      opening: closing.reversed(),
      closing: opening.reversed()
    )
  }

  @inlinable public func forward(
    match reversedMatch: NestingMatch<Closing.Reversed.Match, Opening.Reversed.Match>,
    in forwardCollection: Searchable
  ) -> NestingMatch<Opening.Match, Closing.Match> {
    return NestingMatch<Opening.Match, Closing.Match>(
      opening: opening.forward(match: reversedMatch.closing, in: forwardCollection),
      contents: contents.forward(match: reversedMatch.levelContents, in: forwardCollection),
      closing: closing.forward(match: reversedMatch.opening, in: forwardCollection),
      in: forwardCollection
    )
  }
}
