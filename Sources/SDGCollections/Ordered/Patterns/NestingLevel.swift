/*
 NestingLevel.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The result of a search for a nesting level.
///
/// - SeeAlso: `firstNestingLevel(startingWith:endingWith:in:)
public struct NestingLevel<Searched: SearchableCollection> {

  // MARK: - Initialization

  /// Creates a description of a nesting level.
  ///
  /// - Parameters:
  ///     - container: A match describing the nesting level, including its delimiting tokens.
  ///     - contents: A match describing the contents of the nesting level without its delimiting tokens.
  @inlinable public init(container: PatternMatch<Searched>, contents: PatternMatch<Searched>) {
    self.container = container
    self.contents = contents
  }

  // MARK: - Properties

  /// The match describing the nesting level, including its delimiting tokens.
  public let container: PatternMatch<Searched>
  /// The match describing the contents of the nesting level without its delimiting tokens.
  public let contents: PatternMatch<Searched>
}
