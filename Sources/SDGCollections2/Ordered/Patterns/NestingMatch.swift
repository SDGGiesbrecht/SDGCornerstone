/*
 NestingMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A match for a nesting pattern.
public struct NestingMatch<Opening, Closing>: PatternMatch
where Opening: PatternMatch, Closing: PatternMatch, Closing.Searched == Opening.Searched {

  // MARK: - Initialization

  /// Creates a nesting match.
  ///
  /// - Parameters:
  ///     - openingToken: The match for the opening token.
  ///     - contents: The contents of the nesting level.
  ///     - closingToken: The match for the closing token.
  ///     - searched: The searched collection
  @inlinable public init(
    openingToken: Opening,
    contents: NestingMatchContents<Opening, Closing>,
    closingToken: Closing,
    in searched: Searched
  ) {
    self.openingToken = openingToken
    self.levelContents = contents
    self.closingToken = closingToken
    self.contents = searched[openingToken.range.lowerBound..<self.closingToken.range.upperBound]
  }

  // MARK: - Properties

  /// The opening token.
  public let openingToken: Opening

  /// The contents of the nesting level, excluding the opening and closing tokens.
  public let levelContents: NestingMatchContents<Opening, Closing>

  /// The closing token.
  public let closingToken: Closing

  // MARK: - PatternMatch

  public typealias Searched = Opening.Searched
  public let contents: Opening.Searched.SubSequence
}
