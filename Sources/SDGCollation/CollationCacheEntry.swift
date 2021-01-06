/*
 CollationCacheEntry.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@usableFromInline internal struct CollationCacheEntry<String> {

  // MARK: - Initialization

  @inlinable internal init(string: String, indices: [CollationIndex]) {
    self.string = string
    self.indices = indices
  }

  // MARK: - Properties

  @usableFromInline internal let string: String
  @usableFromInline internal let indices: [CollationIndex]
}
