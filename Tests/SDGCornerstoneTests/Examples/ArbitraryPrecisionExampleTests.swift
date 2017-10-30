/*
 ArbitraryPrecisionExamples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstone

class ArbitraryPrecisionExampleTests : TestCase {

    func testIntegerLiterals() {

        // [_Define Example: Integer Literals_]
        let negativeMillion: Integer = −1_000_000
        let negativeDecillion: Integer = "−1 000 000 000 000 000 000 000 000 000 000 000"
        let negativeYobiMultiplier = Integer(binary: "−1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000")
        // [_End_]

        XCTAssertEqual(−(1000 ↑ 2), negativeMillion)
        XCTAssertEqual(−(1000 ↑ 11), negativeDecillion)
        XCTAssertEqual(−(Integer(binary: "1 0000000000") ↑ 8), negativeYobiMultiplier)
    }

    func testRationalNumberLiterals() {

        // [_Define Example: RationalNumber Literals_]
        let third: RationalNumber = 1 ÷ 3
        let decillionth: RationalNumber = "0.000 000 000 000 000 000 000 000 000 000 001"
        let half = RationalNumber(binary: "0.1")
        // [_End_]

        XCTAssertEqual(third × 3, 1)
        XCTAssertEqual("0.001" as RationalNumber ↑ 11, decillionth)
        XCTAssertEqual(half × 2, 1)
    }

    func testWholeNumberLiterals() {

        // [_Define Example: WholeNumber Literals_]
        let million: WholeNumber = 1_000_000
        let decillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000"
        let yobiMultiplier = WholeNumber(binary: "1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000")
        // [_End_]

        XCTAssertEqual(1000 ↑ 2, million)
        XCTAssertEqual(1000 ↑ 11, decillion)
        XCTAssertEqual(WholeNumber(binary: "1 0000000000") ↑ 8, yobiMultiplier)
    }

    static var allTests: [(String, (ArbitraryPrecisionExampleTests) -> () throws -> Void)] {
        return [
            ("testIntegerLiterals", testIntegerLiterals),
            ("testRationalNumberLiterals", testRationalNumberLiterals),
            ("testWholeNumberLiterals", testWholeNumberLiterals)
        ]
    }
}
