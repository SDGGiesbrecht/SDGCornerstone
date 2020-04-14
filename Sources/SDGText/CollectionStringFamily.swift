/*
 CollectionStringFamily.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

#if os(WASI)
  // #workaround(workspace version 0.32.0, Compiler crashes on generic version.)

  extension Collection where Element == StrictString {

    // #documentation(Array<StringFamily>.joined(separator:))
    /// Returns the concatenated elements of this sequence of sequences, inserting the given separator between each element.
    ///
    /// - Parameters:
    ///     - separator: A sequence to insert between each of this sequence’s elements.
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
#else
  extension Collection where Element: StringFamily {

    // @documentation(Array<StringFamily>.joined(separator:))
    /// Returns the concatenated elements of this sequence of sequences, inserting the given separator between each element.
    ///
    /// - Parameters:
    ///     - separator: A sequence to insert between each of this sequence’s elements.
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
#endif
