/*
 FunctionAnalysisExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone
import SDGXCTestUtilities

class FunctionAnalysisExampleTests : TestCase {

    func testFindLocalMinimum() {
        // @example(findLocalMinimum)
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
        // @endExample
    }

    func doNotTestPreconditionViolationForFindLocalMinimum() {
        // @example(findLocalMinimum Precondition Violation)
        // Never do this:
        _ = findLocalMinimum(near: 0, inFunction: {$0})
        // @endExample
    }

    func doNotTestPreconditionViolationForFindLocalMaximum() {
        // @example(findLocalMaximum Precondition Violation)
        // Never do this:
        _ = findLocalMaximum(near: 0, inFunction: {$0})
        // @endExample
    }

    func testUndefinedCaseOneForFindLocalMaximum() {
        // @example(findLocalMaximum Undefined 1)
        // This is undefined:
        let maximum = findLocalMaximum(near: 0) { $0 ∈ −10 ... 10 ? $0 ↑ 2 : −($0 ↑ 2) }
        // @endExample

        XCTAssert(maximum ∈ Set([−10, 10]))
    }

    func testUndefinedCaseOneForFindLocalMinimum() {
        // @example(findLocalMinimum Undefined 1)
        // This is undefined:
        let minimum = findLocalMinimum(near: 0) { $0 ∈ −10 ... 10 ? −($0 ↑ 2) : $0 ↑ 2 }
        // @endExample

        XCTAssert(minimum ∈ Set([−10, 10]))
    }

    func testUndefinedCaseTwoForFindLocalMaximum() {
        // @example(findLocalMaximum Undefined 2)
        // This is undefined:
        let maximum = findLocalMaximum(near: 0) { $0 ∈ −10 ... 10 ? 1 : −(|$0|) }
        // @endExample

        XCTAssert(maximum ∈ −10 ... 10)
    }

    func testUndefinedCaseTwoForFindLocalMinimum() {
        // @example(findLocalMinimum Undefined 2)
        // This is undefined:
        let minimum = findLocalMinimum(near: 0) { $0 ∈ −10 ... 10 ? −1 : |$0| }
        // @endExample

        XCTAssert(minimum ∈ −10 ... 10)
    }
}
