/*
 SDGBinaryDataTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGBinaryDataTestUtilities
import SDGXCTestUtilities

class SDGBinaryDataTests : TestCase {

    struct BitFieldExample : BitField, Equatable, ExpressibleByIntegerLiteral {
        var field: UInt8
        init(integerLiteral: UInt8) {
            field = integerLiteral
        }
        mutating func formBitwiseNot() {
            field.formBitwiseNot()
        }
        mutating func formBitwiseAnd(with other: BitFieldExample) {
            field.formBitwiseAnd(with: other.field)
        }
        mutating func formBitwiseOr(with other: BitFieldExample) {
            field.formBitwiseOr(with: other.field)
        }
        mutating func formBitwiseExclusiveOr(with other: BitFieldExample) {
            field.formBitwiseExclusiveOr(with: other.field)
        }
        static func ==(lhs: BitFieldExample, rhs: BitFieldExample) -> Bool {
            return lhs.field == rhs.field
        }
    }
    func testBitField() {
        testBitFieldConformance(start: 0b0101_0110 as BitFieldExample, not: 0b1010_1001, other: 0b1101_0010, and: 0b0101_0010, or: 0b1101_0110, exclusiveOr: 0b1000_0100)
    }

    func testUInt() {
        testBitFieldConformance(start: 0b0101_0110 as UInt8, not: 0b1010_1001, other: 0b1101_0010, and: 0b0101_0010, or: 0b1101_0110, exclusiveOr: 0b1000_0100)
    }

    static var allTests: [(String, (SDGBinaryDataTests) -> () throws -> Void)] {
        return [
            ("testBitField", testBitField),
            ("testUInt", testUInt)
        ]
    }
}
