/*
 CollationTailoringAnchor.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

/// An anchor for relative collation rules. The result of `*(_:)`.
///
/// - Warning: This type can only be used inside a `tailored(accordingTo:)` closure.
public struct CollationTailoringAnchor: ExpressibleByStringLiteral {

  // MARK: - Initialization

  internal init(_ elements: [CollationElement]) {
    self.elements = elements
  }

  // MARK: - Properties

  internal let elements: [CollationElement]

  // MARK: - ExpressiblyByStringLiteral

  public init(stringLiteral value: String) {
    self = CollationTailoringAnchor(tailoringRoot!.contextualMapping.map(StrictString(value)))
  }
}
