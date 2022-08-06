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
  ///     - opening: The match for the opening pattern.
  ///     - contents: The contents of the nesting level.
  ///     - closing: The match for the closing pattern.
  ///     - searched: The searched collection
  @inlinable public init(
    opening: Opening,
    contents: NestingMatchContents<Opening, Closing>,
    closing: Closing,
    in searched: Searched
  ) {
    self.opening = opening
    self.levelContents = contents
    self.closing = closing
    self.contents = searched[opening.range.lowerBound..<self.closing.range.upperBound]
  }

  // MARK: - Properties

  /// The match for the opening pattern.
  public let opening: Opening

  /// The contents of the nesting level, excluding the opening and closing tokens.
  public let levelContents: NestingMatchContents<Opening, Closing>

  /// The match for closing pattern.
  public let closing: Closing

  // MARK: - PatternMatch

  public typealias Searched = Opening.Searched
  public let contents: Opening.Searched.SubSequence
}
