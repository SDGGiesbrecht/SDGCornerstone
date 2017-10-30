/*
 BoolExamples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstone

class BoolExampleTests : TestCase {

    func testAlternatingBooleans() {
        // [_Define Example: Alternating Booleans_]
        let alternating = CyclicalNumberGenerator([
            Bool.falseRandomizerValue,
            Bool.trueRandomizerValue
            ])

        XCTAssertEqual(Bool(fromRandomizer: alternating), false)
        XCTAssertEqual(Bool(fromRandomizer: alternating), true)
        XCTAssertEqual(Bool(fromRandomizer: alternating), false)
        XCTAssertEqual(Bool(fromRandomizer: alternating), true)
        XCTAssertEqual(Bool(fromRandomizer: alternating), false)
        XCTAssertEqual(Bool(fromRandomizer: alternating), true)
        // ...
        // [_End_]
    }

    static var allTests: [(String, (BoolExampleTests) -> () throws -> Void)] {
        return [
            ("testAlternatingBooleans", testAlternatingBooleans)
        ]
    }
}
