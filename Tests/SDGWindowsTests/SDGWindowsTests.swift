/*
 SDGWindowsTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Until standard tests work.)

import SDGControlFlow
import SDGLogic
import SDGMathematics

import XCTest

class WindowsTests: XCTestCase {

  func testControlFlow() {
    var cache: Bool?
    let computed = cached(in: &cache) { true }
    XCTAssert(computed)
  }

  func testLogic() {
    XCTAssert(true ≠ false)
  }

  func testMathematics() {
    XCTAssertEqual(3 − 2, 1)
    let x = sin(45°)
    XCTAssertNotNil(x)
  }
}
