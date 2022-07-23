/*
 AlternativeMatches.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A match for alternative patterns.
public enum AlternativeMatch<Preferred, Fallback>: PatternMatch
where Preferred: PatternMatch, Fallback: PatternMatch, Preferred.Searched == Fallback.Searched {

  // MARK: - Cases

  /// A match for the preferred pattern.
  case preferred(Preferred)

  /// A match for the fallback pattern.
  case fallback(Fallback)

  // MARK: - PatternMatch

  public typealias Searched = Preferred.Searched
  public var contents: Preferred.Searched.SubSequence {
    switch self {
    case .preferred(let match):
      return match.contents
    case .fallback(let match):
      return match.contents
    }
  }
}
