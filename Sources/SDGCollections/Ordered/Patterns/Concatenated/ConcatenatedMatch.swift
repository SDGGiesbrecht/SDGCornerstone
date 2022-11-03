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
  @inlinable public init(first: First, second: Second, in searched: Searched) {
    self.first = first
    self.second = second
    _contents = searched[first.range.lowerBound..<second.range.upperBound]
  }

  // MARK: - Properties

  /// The first match.
  public let first: First
  /// The second match.
  public let second: Second

  // MARK: - PatternMatch

  public typealias Searched = First.Searched
  // #workaround(workspace version 0.41.1, Indirection because “let” is not detected as protocol conformance during documentation.)
  @usableFromInline internal let _contents: First.Searched.SubSequence
  @inlinable public var contents: First.Searched.SubSequence {
    return _contents
  }
}

extension ConcatenatedMatch: Sendable
where First: Sendable, Second: Sendable, First.Searched.SubSequence: Sendable {}
