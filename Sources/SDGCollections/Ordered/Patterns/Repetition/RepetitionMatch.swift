/*
 RepetitionMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A match for a repeteaded pattern.
public struct RepetitionMatch<Component>: PatternMatch
where Component: PatternMatch {

  // MARK: - Initialization

  /// Creates a repetition match.
  ///
  /// - Parameters:
  ///   - components: The individual components.
  ///   - contents: The combined contents of all the components.
  @inlinable public init(components: [Component], contents: Searched.SubSequence) {
    self.components = components
    self._contents = contents
  }

  // MARK: - Properties

  /// The individual components.
  public let components: [Component]

  // MARK: - PatternMatch

  public typealias Searched = Component.Searched
  // #workaround(workspace version 0.41.1, Indirection because “let” is not detected as protocol conformance during documentation.)
  @usableFromInline internal let _contents: Component.Searched.SubSequence
  @inlinable public var contents: Component.Searched.SubSequence {
    return _contents
  }
}

extension RepetitionMatch: Sendable
where Component: Sendable, Component.Searched.SubSequence: Sendable {}
