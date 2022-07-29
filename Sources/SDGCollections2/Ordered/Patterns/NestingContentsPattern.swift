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

  @inlinable internal init(opening: Opening, closing: Closing) {
    #warning("Not implemented yet.")
    fatalError()
  }

  // MARK: - Properties

  // MARK: - Pattern

  public typealias Match = NestingMatchContents<Opening.Match, Closing.Match>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [NestingMatchContents<Opening.Match, Closing.Match>] {
    #warning("Not implemented yet.")
    return []
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> NestingMatchContents<Opening.Match, Closing.Match>? {
    #warning("Not implemented yet.")
    return nil
  }

  @inlinable public func forSubSequence() -> _NestingContentsPattern<
    Opening.SubSequencePattern, Closing.SubSequencePattern
  > {
    #warning("Not implemented yet.")
    fatalError()
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: NestingMatchContents<
      Opening.SubSequencePattern.Match, Closing.SubSequencePattern.Match
    >,
    in collection: Searchable
  ) -> NestingMatchContents<Opening.Match, Closing.Match> {
    #warning("Not implemented yet.")
    fatalError()
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
