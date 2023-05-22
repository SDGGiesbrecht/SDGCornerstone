/*
 InclusiveSuffixMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The suffix from the beginning of a pattern match.
public struct InclusiveSuffixMatch<Match>: PatternMatch
where Match: PatternMatch {

  // MARK: - Initialization

  /// Creates an inclusive suffix match.
  ///
  /// - Parameters:
  ///   - match: The starting pattern match.
  ///   - searched: The searched collection.
  @inlinable public init(match: Match, in searched: Match.Searched) {
    self.match = match
    let suffixMatch = AtomicPatternMatch(
      range: match.range.upperBound..<searched.endIndex,
      in: searched
    )
    self.exclusiveSuffix = suffixMatch
    self.contents = searched[match.range.lowerBound..<searched.endIndex]
  }

  // MARK: - Properties

  /// The exclusive suffix.
  public let exclusiveSuffix: AtomicPatternMatch<Match.Searched>
  /// The starting pattern match.
  public let match: Match

  // MARK: - PatternMatch

  public typealias Searched = Match.Searched
  public let contents: Match.Searched.SubSequence
}

extension InclusiveSuffixMatch: Sendable
where Match: Sendable, Match.Searched.SubSequence: Sendable {}
