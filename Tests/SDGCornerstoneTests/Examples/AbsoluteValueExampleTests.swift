/*
 AbsoluteValueExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstone

class AbsoluteValueExampleTests : TestCase {

    func testAbsoluteValue() {

        // [_Define Example: Absolute Value_]
        let x = −1
        let y = |x|
        XCTAssertEqual(y, 1)
        // [_End_]
    }

    static var allTests: [(String, (AbsoluteValueExampleTests) -> () throws -> Void)] {
        return [
            ("testAbsoluteValue", testAbsoluteValue)
        ]
    }
}
