/*
 CollectionStringFamily.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCollections

// #workaround(Swift 5.8.0, Should be “Element: StringFamily” but for web compiler crash.)

extension Collection where Element == StrictString {

  /// Returns the concatenated elements of this sequence of sequences, inserting the given separator between each element.
  ///
  /// - Parameters:
  ///   - separator: A sequence to insert between each of this sequence’s elements.
  @inlinable public func joined(separator: Element = "") -> Element {
    guard var result = self.first else {
      return ""
    }
    for line in self.dropFirst() {
      result += separator + line
    }
    return result
  }
}
