/*
 WholeNumberBinaryViewIndexDistance.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGBinaryData
import SDGLocalization

extension WholeNumber.BinaryView {

  internal struct IndexDistance: Addable, Comparable, Equatable, ExpressibleByIntegerLiteral,
    Hashable, Negatable, SignedNumeric, Subtractable
  {

    // MARK: - Initialization

    internal init(digitDistance: Int, bitDistance: Int) {
      self.digitDistance = digitDistance
      self.bitDistance = bitDistance
    }

    internal init(_ uInt: UIntMax) {
      let bitsPerDigit = BinaryView<WholeNumber.Digit>.count

      let digits = Int(uInt.dividedAccordingToEuclid(by: UIntMax(bitsPerDigit)))
      let bits = Int(uInt.mod(UIntMax(bitsPerDigit)))

      self = IndexDistance(digitDistance: digits, bitDistance: bits)
    }

    // MARK: - Properties

    internal var digitDistance: Int
    internal var bitDistance: Int

    // MARK: - Addable

    internal static func += (precedingValue: inout IndexDistance, followingValue: IndexDistance) {
      precedingValue.digitDistance += followingValue.digitDistance
      precedingValue.bitDistance += followingValue.bitDistance
      let base = BinaryView<WholeNumber.Digit>.count
      if precedingValue.bitDistance ≥ base {
        precedingValue.digitDistance += 1
        precedingValue.bitDistance −= base
      }
      if precedingValue.bitDistance < 0 {
        precedingValue.digitDistance −= 1
        precedingValue.bitDistance += base
      }
    }

    // MARK: - Comparable

    internal static func < (precedingValue: IndexDistance, followingValue: IndexDistance) -> Bool {
      return compare(precedingValue, followingValue, by: { $0.digitDistance }, { $0.bitDistance })
    }

    // MARK: - ExpressibleByIntegerLiteral

    internal init(integerLiteral: UIntMax) {
      self.init(integerLiteral)
    }

    // MARK: - Negatable

    internal mutating func negate() {
      digitDistance.negate()
      bitDistance.negate()
    }

    // MARK: - SignedNumeric

    internal init?<T>(exactly source: T) where T: BinaryInteger {
      unreachable()
      // This function is required to conform to Numeric in order to be a Stride for WholeNumber.BinaryView.Index, but it is neither meaningful nor ever used.
    }

    internal var magnitude: IndexDistance {
      unreachable()
      // This function is required to conform to Numeric in order to be a Stride for WholeNumber.BinaryView.Index, but it is neither meaningful nor ever used.
    }

    internal static func * (  // @exempt(from: unicode)
      precedingValue: IndexDistance,
      followingValue: IndexDistance
    ) -> IndexDistance {
      unreachable()
      // This function is required to conform to Numeric in order to be a Stride for WholeNumber.BinaryView.Index, but it is neither meaningful nor ever used.
    }

    internal static func *= (  // @exempt(from: unicode)
      precedingValue: inout IndexDistance,
      followingValue: IndexDistance
    ) {
      unreachable()
      // This function is required to conform to Numeric in order to be a Stride for WholeNumber.BinaryView.Index, but it is neither meaningful nor ever used.
    }

    // MARK: - Subtractable

    internal static func −= (precedingValue: inout IndexDistance, followingValue: IndexDistance) {
      precedingValue += −followingValue
    }
  }
}
