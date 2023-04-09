/*
 NaryAlternativePatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against several alternative patterns.
///
/// The order of the alternatives is significant. If multiple alternatives match, preference will be given to one higher in the list.
public struct NaryAlternativePatterns<Option>: Pattern, CustomStringConvertible,
  TextualPlaygroundDisplay
where Option: Pattern {

  // MARK: - Initialization

  /// Creates a set of alternative patterns.
  ///
  /// - Parameters:
  ///   - alternatives: The alternative patterns.
  @inlinable public init(_ alternatives: [Option]) {
    self.alternatives = alternatives
  }

  // MARK: - Properties

  @usableFromInline internal var alternatives: [Option]

  // MARK: - Pattern

  public typealias Match = NaryAlternativeMatch<Option.Match>

  @inlinable public func matches(
    in collection: Option.Searchable,
    at location: Option.Searchable.Index
  ) -> [NaryAlternativeMatch<Option.Match>] {
    return alternatives.indices
      .flatMap { (index: Int) -> [NaryAlternativeMatch<Option.Match>] in
        let option = alternatives[index]
        return option.matches(in: collection, at: location).map { hit in
          return NaryAlternativeMatch(hit, optionIndex: index)
        }
      }
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> NaryAlternativeMatch<Option.Match>? {
    for index in alternatives.indices {
      let alternative = alternatives[index]
      if let match = alternative.primaryMatch(in: collection, at: location) {
        return NaryAlternativeMatch(match, optionIndex: index)
      }
    }
    return nil
  }

  @inlinable public func forSubSequence() -> NaryAlternativePatterns<
    Option.SubSequencePattern
  > {
    return NaryAlternativePatterns<Option.SubSequencePattern>(
      alternatives.map({ $0.forSubSequence() })
    )
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: NaryAlternativeMatch<Option.SubSequencePattern.Match>,
    in collection: Searchable
  ) -> NaryAlternativeMatch<Option.Match> {
    let index = subSequenceMatch.optionIndex
    return NaryAlternativeMatch<Option.Match>(
      alternatives[index]
        .convertMatch(from: subSequenceMatch.individual, in: collection),
      optionIndex: index
    )
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    let entries = alternatives.map { "(" + String(describing: $0) + ")" }
    return entries.joined(separator: " ∨ ")
  }
}

extension NaryAlternativePatterns: BidirectionalPattern where Option: BidirectionalPattern {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> NaryAlternativePatterns<Option.Reversed> {
    return NaryAlternativePatterns<Option.Reversed>(
      alternatives.map({ $0.reversed() })
    )
  }

  @inlinable public func forward(
    match reversedMatch: NaryAlternativeMatch<Option.Reversed.Match>,
    in forwardCollection: Searchable
  ) -> NaryAlternativeMatch<Option.Match> {
    let index = reversedMatch.optionIndex
    return NaryAlternativeMatch<Option.Match>(
      alternatives[index]
        .forward(match: reversedMatch.individual, in: forwardCollection),
      optionIndex: index
    )
  }
}

extension NaryAlternativePatterns: Sendable where Option: Sendable {}
