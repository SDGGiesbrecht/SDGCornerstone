/*
 AnyPatternMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type‐erased pattern match.
public struct AnyPatternMatch<Searched>: PatternMatch, TransparentWrapper
where Searched: SearchableCollection {

  // MARK: - Initialization

  /// Wraps a pattern match.
  ///
  /// - Parameters:
  ///   - match: The match.
  @inlinable public init<MatchType>(_ match: MatchType)
  where MatchType: PatternMatch, MatchType.Searched == Searched {
    self.underlyingMatch = match
    self.contents = match.contents
  }

  // MARK: - Properties

  /// The underlying match.
  public let underlyingMatch: Any

  // MARK: - PatternMatch

  public let contents: Searched.SubSequence

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return underlyingMatch
  }
}
