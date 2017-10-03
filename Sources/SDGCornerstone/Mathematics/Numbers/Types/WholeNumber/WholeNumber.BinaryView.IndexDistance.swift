/*
 WholeNumber.BinaryView.IndexDistance.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension WholeNumber.BinaryView {

    internal struct IndexDistance : Addable, Comparable, Equatable, ExpressibleByIntegerLiteral, Hashable, Negatable, SignedNumeric, Subtractable {

        // MARK: - Initialization

        internal init(digitDistance: DigitDistance, bitDistance: BitDistance) {
            self.digitDistance = digitDistance
            self.bitDistance = bitDistance
        }

        internal init(_ uInt: UIntMax) {
            let bitsPerDigit = BinaryView<WholeNumber.Digit>.count

            let digits = DigitDistance(BitDistance(uInt).dividedAccordingToEuclid(by: bitsPerDigit))
            let bits = BitDistance(uInt).mod(bitsPerDigit)

            self = IndexDistance(digitDistance: digits, bitDistance: bits)
        }

        // MARK: - Properties

        internal typealias DigitDistance = Array<WholeNumber.Digit>.IndexDistance
        internal var digitDistance: DigitDistance

        internal typealias BitDistance = BinaryView<WholeNumber.Digit>.IndexDistance
        internal var bitDistance: BitDistance

        // MARK: - Addable

        internal static func += (lhs: inout IndexDistance, rhs: IndexDistance) {
            lhs.digitDistance += rhs.digitDistance
            lhs.bitDistance += rhs.bitDistance
            let base = BinaryView<WholeNumber.Digit>.count
            if lhs.bitDistance ≥ base {
                lhs.digitDistance += 1
                lhs.bitDistance −= base
            }
            if lhs.bitDistance < 0 {
                lhs.digitDistance −= 1
                lhs.bitDistance += base
            }
        }

        // MARK: - Comparable

        internal static func < (lhs: IndexDistance, rhs: IndexDistance) -> Bool {
            return (lhs.digitDistance, lhs.bitDistance) < (rhs.digitDistance, rhs.bitDistance)
        }

        // MARK: - Equatable

        internal static func == (lhs: IndexDistance, rhs: IndexDistance) -> Bool {
            return (lhs.digitDistance, lhs.bitDistance) == (rhs.digitDistance, rhs.bitDistance)
        }

        // MARK: - ExpressibleByIntegerLiteral

        internal init(integerLiteral: UIntMax) {
            self.init(integerLiteral)
        }

        // MARK: - Hashable

        internal var hashValue: Int {
            return bitDistance.hashValue
        }

        // MARK: - Negatable

        internal static postfix func −= (operand: inout IndexDistance) {
            operand.digitDistance−=
            operand.bitDistance−=
        }

        // MARK: - SignedNumeric

        internal init?<T>(exactly source: T) where T : BinaryInteger {
            guard let whole = UIntMax(exactly: source) else {
                return nil
            }
            self.init(whole)
        }

        internal var magnitude: IndexDistance {
            return IndexDistance(digitDistance: |digitDistance|, bitDistance: |bitDistance|)
        }

        internal static func *(lhs: IndexDistance, rhs: IndexDistance) -> IndexDistance {
            unreachable()
            // This function is required to conform to Numeric in order to be a Stride for WholeNumber.BinaryView.Index, but it is neither meaningful nor ever used.
        }

        internal static func *=(lhs: inout IndexDistance, rhs: IndexDistance) {
            unreachable()
            // This function is required to conform to Numeric in order to be a Stride for WholeNumber.BinaryView.Index, but it is neither meaningful nor ever used.
        }

        // MARK: - Subtractable

        internal static func −= (lhs: inout IndexDistance, rhs: IndexDistance) {
            lhs += −rhs
        }
    }
}
