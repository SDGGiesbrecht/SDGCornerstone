/*
 NaryAlternativeMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A match for n‐ary alternative patterns.
public struct NaryAlternativeMatch<IndividualMatch>: PatternMatch
where IndividualMatch: PatternMatch {

  // MARK: - Initialization

  /// Creates an n‐ary alternative match.
  ///
  /// - Parameters:
  ///   - individual: The individual match for one of the options.
  ///   - optionIndex: The index of the matched option.
  @inlinable public init(_ individual: IndividualMatch, optionIndex: Int) {
    self.individual = individual
    self.optionIndex = optionIndex
  }

  // MARK: - Properties

  /// The individual match.
  public let individual: IndividualMatch

  /// The index of the matched option.
  public let optionIndex: Int

  // MARK: - PatternMatch

  public typealias Searched = IndividualMatch.Searched
  public var contents: IndividualMatch.Searched.SubSequence {
    return individual.contents
  }
}
