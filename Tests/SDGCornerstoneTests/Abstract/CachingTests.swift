/*
 CachingTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
@testable import SDGCornerstone

class CachingTests : XCTestCase {

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

        XCTAssert(cached(in: &cache, compute) == true)
        XCTAssert(callCount == 1)
        XCTAssert(cached(in: &cache, compute) == true)
        XCTAssert(callCount == 1)

        callCount = 0

        XCTAssert(cached(in: &parameterizedCache[true], { compute(true) }) == true)
        XCTAssert(cached(in: &parameterizedCache[false], { compute(false) }) == false)
        XCTAssert(callCount == 2)
        XCTAssert(cached(in: &parameterizedCache[true], { compute(true) }) == true)
        XCTAssert(cached(in: &parameterizedCache[false], { compute(false) }) == false)
        XCTAssert(callCount == 2)
    }

    static var allTests: [(String, (CachingTests) -> () throws -> Void)] {
        return [
            ("testCaching", testCaching)
        ]
    }
}
