/*
 NaryConcatenatedMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A match for n‐ary concatenated patterns.
public struct NaryConcatenatedMatch<Component>: PatternMatch
where Component: PatternMatch {

  // MARK: - Initialization

  /// Creates an n‐ary concatenated match.
  ///
  /// - Parameters:
  ///   - elements: The individual components.
  ///   - contents: The combined contents of all the components.
  @inlinable public init(components: [Component], contents: Searched.SubSequence) {
    self.components = components
    self.contents = contents
  }

  // MARK: - Properties

  /// The individual components.
  public let components: [Component]

  // MARK: - PatternMatch

  public typealias Searched = Component.Searched
  public let contents: Component.Searched.SubSequence
}
