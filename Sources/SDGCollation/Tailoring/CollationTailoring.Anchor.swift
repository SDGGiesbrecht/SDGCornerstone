/*
 CollationTailoring.Anchor.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension CollationTailoring {

  /// An anchor for relative collation rules; the result of `*(_:)`.
  public struct Anchor: ExpressibleByStringLiteral {

    // MARK: - Initialization

    private init(
      _ cursor: @escaping (CollationOrder) -> [CollationElement],
      queuedMutations: [(inout CollationOrder) -> Void]
    ) {
      self.cursor = cursor
      self.queuedMutations = queuedMutations
    }

    // MARK: - Properties

    internal let cursor: (CollationOrder) -> [CollationElement]
    private var queuedMutations: [(inout CollationOrder) -> Void]

    // MARK: - Stacking

    internal func stacking(
      mutation: @escaping (inout CollationOrder) -> Void,
      cursor: @escaping (CollationOrder) -> [CollationElement]
    ) -> Anchor {
      return Anchor(cursor, queuedMutations: queuedMutations.appending(mutation))
    }

    internal func applyRules(to collation: inout CollationOrder) {
      for mutation in queuedMutations {
        mutation(&collation)
      }
    }

    // MARK: - ExpressiblyByStringLiteral

    public init(stringLiteral value: String) {
      self.cursor = { $0.contextualMapping.map(StrictString(value)) }
      self.queuedMutations = []
    }
  }
}
