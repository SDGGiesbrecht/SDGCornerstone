/*
 SDGControlFlowTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

import SDGTesting
import SDGXCTestUtilities

class SDGControlFlowTests : TestCase {

    func testBuildConfiguration() {
        if _isDebugAssertConfiguration() {
            test(variable: (BuildConfiguration.current, "BuildConfiguration.current"), is: .debug)
        }
    }

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

        XCTAssertEqual(cached(in: &cache, compute), true, "Cache contained incorrect value.")
        XCTAssertEqual(callCount, 1, "Cache value not computed.")
        XCTAssertEqual(cached(in: &cache, compute), true, "Cache contained incorrect value.")
        XCTAssertEqual(callCount, 1, "Cache value recomputed unnecessarily.")

        callCount = 0

        XCTAssertEqual(cached(in: &parameterizedCache[true], { compute(true) }), true, "Cache contained incorrect value.")
        XCTAssertEqual(cached(in: &parameterizedCache[false], { compute(false) }), false, "Cache contained incorrect value.")
        XCTAssertEqual(callCount, 2, "Cache values mixed up.")
        XCTAssertEqual(cached(in: &parameterizedCache[true], { compute(true) }), true, "Cache contained incorrect value.")
        XCTAssertEqual(cached(in: &parameterizedCache[false], { compute(false) }), false, "Cache contained incorrect value.")
        XCTAssertEqual(callCount, 2, "Cache value recomputed unnecessarily.")
    }

    func testNonmutatingVariants() {
        let sorted = nonmutatingVariant(of: Array.sort, on: [2, 3, 1])
        XCTAssert(sorted == [1, 2, 3], "Nonmutating variant returned an unexpected value: \(sorted)")
        let appended = nonmutatingVariant(of: Array.append, on: [1, 2], with: 3)
        XCTAssert(appended == [1, 2, 3], "Nonmutating variant returned an unexpected value: \(appended)")
        let start = "BCD"
        let inserted = nonmutatingVariant(of: String.insert, on: start, with: ("A", start.startIndex))
        XCTAssert(inserted == "ABCD", "Nonmutating variant returned an unexpected value: \(inserted)")
        let added = nonmutatingVariant(of: +=, on: [1, 2], with: [3])
        XCTAssert(added == [1, 2, 3], "Nonmutating variant returned an unexpected value: \(added)")
        let incremented = nonmutatingVariant(of: { (x: inout Int) in x += 1 }, on: 1)
        XCTAssert(incremented == 2, "Nonmutating variant returned an unexpected value: \(incremented)")
    }

    static var allTests: [(String, (SDGControlFlowTests) -> () throws -> Void)] {
        return [
            ("testBuildConfiguration", testBuildConfiguration),
            ("testCaching", testCaching),
            ("testNonmutatingVariants", testNonmutatingVariants)
        ]
    }
}
