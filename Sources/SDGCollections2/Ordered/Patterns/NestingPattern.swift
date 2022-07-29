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
    #warning("Not implemented yet.")
    fatalError()
  }

  // MARK: - Properties

  @usableFromInline internal var opening: Opening
  @usableFromInline internal var contents: _NestingContentsPattern<Opening, Closing>
  @usableFromInline internal var closing: Closing

  // MARK: - Pattern

  public typealias Match = NestingMatch<Opening.Match, Closing.Match>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [NestingMatch<Opening.Match, Closing.Match>] {
    return opening.matches(in: collection, at: location).compactMap { opening in
      #warning("Not implemented yet.")
      return nil
    }
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> NestingMatch<Opening.Match, Closing.Match>? {
    #warning("Not implemented yet.")
    return nil
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
    #warning("Not implemented yet.")
    fatalError()
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
    #warning("Not implemented yet.")
    fatalError()
  }
}
