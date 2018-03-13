/*
 FunctionAnalysisExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstone

import SDGXCTestUtilities

class FunctionAnalysisExampleTests : TestCase {

    func testFindLocalMinimum() {
        // [_Define Example: findLocalMinimum_]
        let approximateSquareRootOf120 = findLocalMinimum(near: 10) { (guess: Int) -> Int in

            // Find the square of the guess.
            let square = guess × guess

            // Determine its proximity to 120.
            return |(square − 120)|
        }

        // First iteration (determined by “near: 10”):
        // 10 → 20

        // Second iteration:
        // 11 → 1
        // Decreasing, so continue.

        // Third iteration:
        // 12 → 24
        // No longer decreasing, so stop. 1 was the local minimum.

        XCTAssertEqual(approximateSquareRootOf120, 11)
        // [_End_]
    }

    func doNotTestPreconditionViolationForFindLocalMinimum() {
        // [_Define Example: findLocalMinimum Precondition Violation_]
        // Never do this:
        _ = findLocalMinimum(near: 0, inFunction: {$0})
        // [_End_]
    }

    func doNotTestPreconditionViolationForFindLocalMaximum() {
        // [_Define Example: findLocalMaximum Precondition Violation_]
        // Never do this:
        _ = findLocalMaximum(near: 0, inFunction: {$0})
        // [_End_]
    }

    func testUndefinedCaseOneForFindLocalMaximum() {
        // [_Define Example: findLocalMaximum Undefined 1_]
        // This is undefined:
        let maximum = findLocalMaximum(near: 0) { $0 ∈ −10 ... 10 ? $0 ↑ 2 : −($0 ↑ 2) }
        // [_End_]

        XCTAssert(maximum ∈ Set([−10, 10]))
    }

    func testUndefinedCaseOneForFindLocalMinimum() {
        // [_Define Example: findLocalMinimum Undefined 1_]
        // This is undefined:
        let minimum = findLocalMinimum(near: 0) { $0 ∈ −10 ... 10 ? −($0 ↑ 2) : $0 ↑ 2 }
        // [_End_]

        XCTAssert(minimum ∈ Set([−10, 10]))
    }

    func testUndefinedCaseTwoForFindLocalMaximum() {
        // [_Define Example: findLocalMaximum Undefined 2_]
        // This is undefined:
        let maximum = findLocalMaximum(near: 0) { $0 ∈ −10 ... 10 ? 1 : −(|$0|) }
        // [_End_]

        XCTAssert(maximum ∈ −10 ... 10)
    }

    func testUndefinedCaseTwoForFindLocalMinimum() {
        // [_Define Example: findLocalMinimum Undefined 2_]
        // This is undefined:
        let minimum = findLocalMinimum(near: 0) { $0 ∈ −10 ... 10 ? −1 : |$0| }
        // [_End_]

        XCTAssert(minimum ∈ −10 ... 10)
    }

    static var allTests: [(String, (FunctionAnalysisExampleTests) -> () throws -> Void)] {
        return [
            ("testFindLocalMinimum", testFindLocalMinimum),
            ("testUndefinedCaseOneForFindLocalMaximum", testUndefinedCaseOneForFindLocalMaximum),
            ("testUndefinedCaseOneForFindLocalMinimum", testUndefinedCaseOneForFindLocalMinimum),
            ("testUndefinedCaseTwoForFindLocalMaximum", testUndefinedCaseTwoForFindLocalMaximum),
            ("testUndefinedCaseTwoForFindLocalMinimum", testUndefinedCaseTwoForFindLocalMinimum)
        ]
    }
}
