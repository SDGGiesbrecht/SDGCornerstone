/*
 Data.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation

  extension Data: BitField {

    // MARK: - BitField

    public mutating func formBitwiseNot() {
      for index in indices {
        self[index].formBitwiseNot()
      }
    }

    public mutating func formBitwiseAnd(with other: Data) {
      let end = Swift.min(endIndex, other.endIndex)

      for index in startIndex..<end {
        self[index].formBitwiseAnd(with: other[index])
      }
      removeSubrange(end...)
    }

    public mutating func formBitwiseOr(with other: Data) {
      let end = Swift.min(endIndex, other.endIndex)

      for index in startIndex..<end {
        self[index].formBitwiseOr(with: other[index])
      }
      append(contentsOf: other[end...])
    }

    public mutating func formBitwiseExclusiveOr(with other: Data) {
      let end = Swift.min(endIndex, other.endIndex)

      for index in startIndex..<end {
        self[index].formBitwiseExclusiveOr(with: other[index])
      }
      append(contentsOf: other[end...])
    }
  }
#endif
