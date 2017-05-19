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

    internal struct IndexDistance : Addable, Comparable, Equatable, ExpressibleByIntegerLiteral, Negatable, SignedNumber, Subtractable {

        // MARK: - Initialization

        init(digitDistance: DigitDistance, bitDistance: BitDistance) {
            self.digitDistance = digitDistance
            self.bitDistance = bitDistance
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

        init(integerLiteral: UIntMax) {
            let bitsPerDigit = BinaryView<WholeNumber.Digit>.count

            let digits = DigitDistance(BitDistance(integerLiteral).dividedAccordingToEuclid(by: bitsPerDigit))
            let bits = BitDistance(integerLiteral).mod(bitsPerDigit)

            self = IndexDistance(digitDistance: digits, bitDistance: bits)
        }

        // MARK: - Negatable

        internal static postfix func −= (operand: inout IndexDistance) {
            operand.digitDistance−=
            operand.bitDistance−=
        }

        // MARK: - Subtractable

        internal static func −= (lhs: inout IndexDistance, rhs: IndexDistance) {
            lhs += −rhs
        }
    }
}
