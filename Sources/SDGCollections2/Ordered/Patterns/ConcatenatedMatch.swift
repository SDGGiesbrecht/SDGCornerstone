/*
 ConcatenatedMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A match for concatenated patterns.
public struct ConcatenatedMatch<First, Second>: PatternMatch
where First: PatternMatch, Second: PatternMatch, First.Searched == Second.Searched {

  // MARK: - Initialization

  /// Creates a concatenated match.
  ///
  /// - Parameters:
  ///   - first: The first match.
  ///   - second: The second match.
  ///   - searched: The searched collection.
  public init(first: First, second: Second, in searched: Searched) {
    self.first = first
    self.second = second
    contents = searched[first.range.lowerBound..<second.range.upperBound]
  }

  // MARK: - Properties

  /// The first match.
  public let first: First
  /// The second match.
  public let second: Second

  // MARK: - PatternMatch

  public typealias Searched = First.Searched
  public let contents: First.Searched.SubSequence
}
