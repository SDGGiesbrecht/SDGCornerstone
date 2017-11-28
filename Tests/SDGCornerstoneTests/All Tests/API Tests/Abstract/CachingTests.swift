/*
 CachingTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import SDGCornerstone

class CachingTests : TestCase {

    func testCaching() {

        var callCount = 0
        func compute() -> Bool {
            callCount += 1
            return true
        }
        func compute(_ parameter: Bool) -> Bool {
            callCount += 1
            return parameter
        }

        var cache: Bool?
        var parameterizedCache: [Bool: Bool] = [:]

        XCTAssertEqual(cached(in: &cache, compute), true)
        XCTAssertEqual(callCount, 1)
        XCTAssertEqual(cached(in: &cache, compute), true)
        XCTAssertEqual(callCount, 1)

        callCount = 0

        XCTAssertEqual(cached(in: &parameterizedCache[true], { compute(true) }), true)
        XCTAssertEqual(cached(in: &parameterizedCache[false], { compute(false) }), false)
        XCTAssertEqual(callCount, 2)
        XCTAssertEqual(cached(in: &parameterizedCache[true], { compute(true) }), true)
        XCTAssertEqual(cached(in: &parameterizedCache[false], { compute(false) }), false)
        XCTAssertEqual(callCount, 2)
    }

    static var allTests: [(String, (CachingTests) -> () throws -> Void)] {
        return [
            ("testCaching", testCaching)
        ]
    }
}
