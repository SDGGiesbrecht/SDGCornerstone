/*
 CollationTailoringBuilder.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A builder for colletion tailoring.
@resultBuilder public struct CollationTailoringBuilder {

  // MARK: - Result Builder

  /// Builds a collation tailoring from a list of rules.
  ///
  /// - Parameters:
  ///   - components: The component rules.
  public static func buildBlock(_ components: CollationTailoring.Anchor...) -> CollationTailoring {
    return CollationTailoring(anchors: components)
  }
}
