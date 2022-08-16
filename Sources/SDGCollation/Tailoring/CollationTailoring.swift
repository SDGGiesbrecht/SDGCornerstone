/*
 CollationTailoring.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A series of tailoring rules that can be applied to a collation.
public struct CollationTailoring {

  // MARK: - Initialization

  internal init(anchors: [CollationTailoring.Anchor]) {
    self.anchors = anchors
  }

  // MARK: - Properties

  private let anchors: [CollationTailoring.Anchor]

  // MARK: - Tailoring

  internal func tailor(_ order: CollationOrder) -> CollationOrder {
    var copy = order
    for anchor in anchors {
      anchor.applyRules(to: &copy)
    }
    return order
  }
}
