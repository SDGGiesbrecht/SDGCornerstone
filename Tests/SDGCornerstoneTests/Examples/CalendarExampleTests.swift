/*
 CalendarExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstone

class CalendarExampleTests : TestCase {

    func testGregorianYear() {
        // [_Define Example: Gregorian Year_]
        let adOne = GregorianYear(1)
        let oneBC = GregorianYear(−1)
        let oneYear = Int(1)

        XCTAssertEqual(adOne − oneYear, oneBC)
        XCTAssertEqual(adOne − oneBC, oneYear)
        // [_End_]
    }

    static var allTests: [(String, (CalendarExampleTests) -> () throws -> Void)] {
        return [
            ("testGregorianYear", testGregorianYear)
        ]
    }
}
