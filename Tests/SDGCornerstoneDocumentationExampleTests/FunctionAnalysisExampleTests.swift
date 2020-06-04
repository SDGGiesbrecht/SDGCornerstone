/*
 FunctionAnalysisExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCollections

import XCTest

import SDGXCTestUtilities

class FunctionAnalysisExampleTests: TestCase {

  func testFindLocalMinimum() {
    #if !os(Windows)  // #workaround(Swift 5.2.4, SegFault)
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
      _ = 0  // Prevents SwiftFormat from breaking the example.
    #endif
  }

  func doNotTestPreconditionViolationForFindLocalMinimum() {
    // @example(findLocalMinimumPreconditionViolation)
    // Never do this:
    _ = findLocalMinimum(near: 0, inFunction: { $0 })
    // @endExample
  }

  func doNotTestPreconditionViolationForFindLocalMaximum() {
    // @example(findLocalMaximumPreconditionViolation)
    // Never do this:
    _ = findLocalMaximum(near: 0, inFunction: { $0 })
    // @endExample
  }

  func testUndefinedCaseOneForFindLocalMaximum() {
    #if !os(Windows)  // #workaround(Swift 5.2.4, SegFault)
      // @example(findLocalMaximumUndefined1)
      // This is undefined:
      let maximum = findLocalMaximum(near: 0) { $0 ∈ −10...10 ? $0 ↑ 2 : −($0 ↑ 2) }
      // @endExample

      XCTAssert(maximum ∈ Set([−10, 10]))
    #endif
  }

  func testUndefinedCaseOneForFindLocalMinimum() {
    #if !os(Windows)  // #workaround(Swift 5.2.4, SegFault)
      // @example(findLocalMinimumUndefined1)
      // This is undefined:
      let minimum = findLocalMinimum(near: 0) { $0 ∈ −10...10 ? −($0 ↑ 2) : $0 ↑ 2 }
      // @endExample

      XCTAssert(minimum ∈ Set([−10, 10]))
    #endif
  }

  func testUndefinedCaseTwoForFindLocalMaximum() {
    #if !os(Windows)  // #workaround(Swift 5.2.4, SegFault)
      // @example(findLocalMaximumUndefined2)
      // This is undefined:
      let maximum = findLocalMaximum(near: 0) { $0 ∈ −10...10 ? 1 : −(|$0|) }
      // @endExample

      XCTAssert(maximum ∈ −10...10)
    #endif
  }

  func testUndefinedCaseTwoForFindLocalMinimum() {
    #if !os(Windows)  // #workaround(Swift 5.2.4, SegFault)
      // @example(findLocalMinimumUndefined2)
      // This is undefined:
      let minimum = findLocalMinimum(near: 0) { $0 ∈ −10...10 ? −1 : |$0| }
      // @endExample

      XCTAssert(minimum ∈ −10...10)
    #endif
  }
}
