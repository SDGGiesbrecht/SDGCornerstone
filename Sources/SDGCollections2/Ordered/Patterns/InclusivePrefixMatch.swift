/*
 InclusivePrefixMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The prefix up to and including a pattern match.
public struct InclusivePrefixMatch<Match>: PatternMatch
where Match: PatternMatch {

  // MARK: - Initialization

  /// Creates an inclusive prefix match.
  ///
  /// - Parameters:
  ///   - match: The terminating pattern match.
  ///   - searched: The searched collection.
  @inlinable public init(match: Match, in searched: Match.Searched) {
    self.match = match
    let prefixMatch = AtomicPatternMatch(
      range: searched.startIndex..<match.range.lowerBound,
      in: searched
    )
    self.exclusivePrefix = prefixMatch
    self.contents = searched[searched.startIndex..<match.range.upperBound]
  }

  // MARK: - Properties

  /// The exclusive prefix.
  public let exclusivePrefix: AtomicPatternMatch<Match.Searched>
  /// The terminating pattern match.
  public let match: Match

  // MARK: - PatternMatch

  public typealias Searched = Match.Searched
  public let contents: Match.Searched.SubSequence
}
