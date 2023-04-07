/*
 AlternativePatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against a pair of alternative patterns.
///
/// The order of the alternatives is significant. If both alternatives match, preference will be given to the first one.
public struct AlternativePatterns<Preferred, Fallback>: CustomStringConvertible, Pattern,
  TextualPlaygroundDisplay
where Preferred: Pattern, Fallback: Pattern, Preferred.Searchable == Fallback.Searchable {

  // MARK: - Initialization

  /// Creates a pair of alternative patterns.
  ///
  /// - Parameters:
  ///     - preferred: The pattern to try first.
  ///     - fallback: The pattern to try second.
  @inlinable public init(_ preferred: Preferred, _ fallback: Fallback) {
    self.preferred = preferred
    self.fallback = fallback
  }

  // MARK: - Properties

  @usableFromInline internal var preferred: Preferred
  @usableFromInline internal var fallback: Fallback

  // MARK: - Pattern

  public typealias Match = AlternativeMatch<Preferred.Match, Fallback.Match>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [AlternativeMatch<Preferred.Match, Fallback.Match>] {
    var results: [AlternativeMatch<Preferred.Match, Fallback.Match>] = []
    results.append(
      contentsOf: preferred.matches(in: collection, at: location).lazy.map({ .preferred($0) })
    )
    results.append(
      contentsOf: fallback.matches(in: collection, at: location).lazy.map({ .fallback($0) })
    )
    return results
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> AlternativeMatch<Preferred.Match, Fallback.Match>? {
    return preferred.primaryMatch(in: collection, at: location).map({ .preferred($0) })
      ?? fallback.primaryMatch(in: collection, at: location).map({ .fallback($0) })
  }

  @inlinable public func forSubSequence() -> AlternativePatterns<
    Preferred.SubSequencePattern, Fallback.SubSequencePattern
  > {
    return AlternativePatterns<Preferred.SubSequencePattern, Fallback.SubSequencePattern>(
      preferred.forSubSequence(),
      fallback.forSubSequence()
    )
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: AlternativeMatch<
      Preferred.SubSequencePattern.Match, Fallback.SubSequencePattern.Match
    >,
    in collection: Searchable
  ) -> AlternativeMatch<Preferred.Match, Fallback.Match> {
    switch subSequenceMatch {
    case .preferred(let match):
      return .preferred(preferred.convertMatch(from: match, in: collection))
    case .fallback(let match):
      return .fallback(fallback.convertMatch(from: match, in: collection))
    }
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return "(\(String(describing: preferred))) ∨ (\(String(describing: fallback)))"
  }
}

extension AlternativePatterns: BidirectionalPattern
where Preferred: BidirectionalPattern, Fallback: BidirectionalPattern,
  // #workaround(Swift 5.8, The following constraint is redundant; see BidirectionalPattern.Reversed for the reason.)
  Preferred.Reversed.Match.Searched == Fallback.Reversed.Match.Searched {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> AlternativePatterns<Preferred.Reversed, Fallback.Reversed> {
    return AlternativePatterns<Preferred.Reversed, Fallback.Reversed>(
      preferred.reversed(),
      fallback.reversed()
    )
  }

  @inlinable public func forward(
    match reversedMatch: AlternativeMatch<Preferred.Reversed.Match, Fallback.Reversed.Match>,
    in forwardCollection: Searchable
  ) -> AlternativeMatch<Preferred.Match, Fallback.Match> {
    switch reversedMatch {
    case .preferred(let match):
      return .preferred(preferred.forward(match: match, in: forwardCollection))
    case .fallback(let match):
      return .fallback(fallback.forward(match: match, in: forwardCollection))
    }
  }
}

extension AlternativePatterns: Sendable where Preferred: Sendable, Fallback: Sendable {}
