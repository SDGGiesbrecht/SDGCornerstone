/*
 ConcatenatedPatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against a pair of component patterns contiguously.
public struct ConcatenatedPatterns<First, Second>: Pattern, CustomStringConvertible,
  TextualPlaygroundDisplay
where First: Pattern, Second: Pattern, First.Searchable == Second.Searchable {

  // MARK: - Initialization

  /// Creates a pattern from a pair of component patterns.
  ///
  /// - Parameters:
  ///     - first: The first pattern.
  ///     - second: The second pattern.
  @inlinable public init(_ first: First, _ second: Second) {
    self.first = first
    self.second = second
  }

  // MARK: - Properties

  @usableFromInline internal var first: First
  @usableFromInline internal var second: Second

  // MARK: - Pattern

  public typealias Match = ConcatenatedMatch<First.Match, Second.Match>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [ConcatenatedMatch<First.Match, Second.Match>] {
    return first.matches(in: collection, at: location).flatMap { firstMatch in
      return second.matches(in: collection, at: firstMatch.range.upperBound).map { secondMatch in
        return ConcatenatedMatch(first: firstMatch, second: secondMatch, in: collection)
      }
    }
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> ConcatenatedMatch<First.Match, Second.Match>? {
    for firstMatch in first.matches(in: collection, at: location) {
      if let secondMatch = second.primaryMatch(in: collection, at: firstMatch.range.upperBound) {
        return ConcatenatedMatch(first: firstMatch, second: secondMatch, in: collection)
      }
    }
    return nil
  }

  @inlinable public func forSubSequence() -> ConcatenatedPatterns<
    First.SubSequencePattern, Second.SubSequencePattern
  > {
    return ConcatenatedPatterns<First.SubSequencePattern, Second.SubSequencePattern>(
      first.forSubSequence(),
      second.forSubSequence()
    )
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: ConcatenatedMatch<
      First.SubSequencePattern.Match, Second.SubSequencePattern.Match
    >,
    in collection: Searchable
  ) -> ConcatenatedMatch<First.Match, Second.Match> {
    return ConcatenatedMatch(
      first: first.convertMatch(from: subSequenceMatch.first, in: collection),
      second: second.convertMatch(from: subSequenceMatch.second, in: collection),
      in: collection
    )
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return "(\(String(describing: first))) + (\(String(describing: second)))"
  }
}

extension ConcatenatedPatterns: BidirectionalPattern
where First: BidirectionalPattern, Second: BidirectionalPattern {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> ConcatenatedPatterns<Second.Reversed, First.Reversed> {
    return ConcatenatedPatterns<Second.Reversed, First.Reversed>(
      second.reversed(),
      first.reversed()
    )
  }

  @inlinable public func forward(
    match reversedMatch: ConcatenatedMatch<Second.Reversed.Match, First.Reversed.Match>,
    in forwardCollection: Searchable
  ) -> ConcatenatedMatch<First.Match, Second.Match> {
    return ConcatenatedMatch(
      first: self.first.forward(match: reversedMatch.second, in: forwardCollection),
      second: self.second.forward(match: reversedMatch.first, in: forwardCollection),
      in: forwardCollection
    )
  }
}

extension ConcatenatedPatterns: Sendable where First: Sendable, Second: Sendable {}
