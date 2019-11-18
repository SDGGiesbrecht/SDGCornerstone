/*
 WholeNumberBinaryViewIndex.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGBinaryData

extension WholeNumber.BinaryView {

  internal struct Index: Comparable, Equatable, FixedScaleOneDimensionalPoint {

    // MARK: - Properties

    internal typealias DigitIndex = Array<WholeNumber.Digit>.Index
    internal var digit: DigitIndex

    internal typealias BitIndex = BinaryView<WholeNumber.Digit>.Index
    internal var bit: BitIndex

    // MARK: - Comparable

    internal static func < (precedingValue: Index, followingValue: Index) -> Bool {  // @exempt(from: tests) Unreachable?
      return (precedingValue.digit, precedingValue.bit) < (followingValue.digit, followingValue.bit)
    }

    // MARK: - PointProtocol

    internal typealias Vector = WholeNumber.BinaryView.IndexDistance

    internal static func += (precedingValue: inout Index, followingValue: Vector) {
      precedingValue.digit += followingValue.digitDistance
      var bit = IntMax(precedingValue.bit)
      bit += followingValue.bitDistance

      let base = IntMax(BinaryView<WholeNumber.Digit>.count)
      if bit ≥ base {
        precedingValue.digit += 1
        bit −= base
      }
      if bit < 0 {
        precedingValue.digit −= 1
        bit += base
      }
      precedingValue.bit = BitIndex(bit)
    }

    internal static func − (precedingValue: Index, followingValue: Index) -> Vector {
      var digitDistance = precedingValue.digit − followingValue.digit

      let bitDistance: Int
      if precedingValue.bit < followingValue.bit {  // Would be negative (invalid for whole number type).
        bitDistance = BinaryView<WholeNumber.Digit>.count − (
          followingValue.bit − precedingValue.bit
        )
        digitDistance −= 1
      } else {
        bitDistance = precedingValue.bit − followingValue.bit
      }

      return IndexDistance(digitDistance: digitDistance, bitDistance: bitDistance)
    }
  }
}
