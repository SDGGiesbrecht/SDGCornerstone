/*
 SeparatedComponentMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A match resulting from the separation of a collection at instances of a pattern.
public struct SeparatedMatch<Match>: PatternMatch
where Match: PatternMatch {

  // MARK: - Initialization

  /// Creates a separated match.
  ///
  /// - Parameters:
  ///   - start: The starting point of the separated component.
  ///   - match: The terminating pattern match.
  ///   - searched: The searched collection.
  @inlinable public init(start: Match.Searched.Index, match: Match?, in searched: Match.Searched) {
    self.match = match
    let componentMatch = AtomicPatternMatch(
      range: start..<(match?.range.lowerBound ?? searched.endIndex),
      in: searched
    )
    self.component = componentMatch
  }

  // MARK: - Properties

  /// The separated component.
  public let component: AtomicPatternMatch<Match.Searched>
  /// The terminating pattern match.
  public let match: Match?

  // MARK: - PatternMatch

  public typealias Searched = Match.Searched
  @inlinable public var contents: Match.Searched.SubSequence {
    return component.contents
  }
}

extension SeparatedMatch: Sendable where Match: Sendable, Match.Searched.SubSequence: Sendable {}
