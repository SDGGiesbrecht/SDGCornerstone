/*
 RegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import XCTest

import SDGXCTestUtilities

class RegressionTests: TestCase {

  func testAddAndSetIsUnambiguous() {
    // Untracked

    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      func runTests<N: IntegralArithmetic>(_ type: N.Type) {
        var x: N = 0
        let _1: N = 1
        x −= _1
        XCTAssertEqual(x, −1)
        XCTAssertEqual((x − _1) as N, −2)
        x += _1
        XCTAssertEqual(x, 0)
        XCTAssertEqual(x + _1, 1)
      }
      runTests(Int.self)
      runTests(Int64.self)
      runTests(Int32.self)
      runTests(Int16.self)
      runTests(Int8.self)
      runTests(Double.self)
      runTests(Float.self)
    #endif
  }

  struct Values: Comparable, Equatable {
    let a: Int
    let b: Int
    let c: Int
    static func < (precedingValue: Values, followingValue: Values) -> Bool {
      return compare(precedingValue, followingValue, by: { $0.a }, { $0.b }, { $0.c })
    }
  }
  func testComparisonAids() {
    // Untracked

    XCTAssert(Values(a: 0, b: 0, c: 0) < Values(a: 0, b: 0, c: 1))
    XCTAssert(Values(a: 0, b: 0, c: 1) < Values(a: 0, b: 1, c: 0))
    XCTAssert(Values(a: 0, b: 1, c: 0) < Values(a: 0, b: 1, c: 1))
    XCTAssert(Values(a: 0, b: 1, c: 1) < Values(a: 1, b: 0, c: 0))
    XCTAssert(Values(a: 1, b: 0, c: 0) < Values(a: 1, b: 0, c: 1))
    XCTAssert(Values(a: 1, b: 0, c: 1) < Values(a: 1, b: 1, c: 0))
    XCTAssert(Values(a: 1, b: 1, c: 0) < Values(a: 1, b: 1, c: 1))

    XCTAssertFalse(Values(a: 0, b: 0, c: 0) > Values(a: 0, b: 0, c: 1))
    XCTAssertFalse(Values(a: 0, b: 0, c: 1) > Values(a: 0, b: 1, c: 0))
    XCTAssertFalse(Values(a: 0, b: 1, c: 0) > Values(a: 0, b: 1, c: 1))
    XCTAssertFalse(Values(a: 0, b: 1, c: 1) > Values(a: 1, b: 0, c: 0))
    XCTAssertFalse(Values(a: 1, b: 0, c: 0) > Values(a: 1, b: 0, c: 1))
    XCTAssertFalse(Values(a: 1, b: 0, c: 1) > Values(a: 1, b: 1, c: 0))
    XCTAssertFalse(Values(a: 1, b: 1, c: 0) > Values(a: 1, b: 1, c: 1))
  }

  func testDivisionIsUnambiguous() {
    // Untracked

    _ = Double(1) ÷ Double(1)
  }

  func testDivisionOfNegatives() {
    // Untracked

    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      let negativeThree = −3
      XCTAssertEqual(negativeThree.dividedAccordingToEuclid(by: 1), −3)
      let negativeEighteen = −18
      XCTAssertEqual(negativeEighteen.dividedAccordingToEuclid(by: 19), −1)
    #endif
  }

  func testFloor() {
    // Untracked

    let thirty = 30
    XCTAssertEqual(thirty, thirty.rounded(.down))
  }

  func testSubtraction() {
    // Untracked

    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      func runTests<N: WholeArithmetic>(_ type: N.Type) {
        let five: N = 10 − 5
        XCTAssertEqual(five, 5)
      }
      runTests(UInt.self)
      runTests(UInt64.self)
      runTests(UInt32.self)
      runTests(UInt16.self)
      runTests(UInt8.self)
      runTests(Int.self)
      runTests(Int64.self)
      runTests(Int32.self)
      runTests(Int16.self)
      runTests(Int8.self)
      runTests(Double.self)
      runTests(Float.self)
    #endif
  }

  func testSubtractionIsUnambiguous() {
    // Untracked

    #if !os(Windows)  // #workaround(Swift 5.3.1, Segmentation fault.)
      let _: UInt = 3 − 2
      let _: UInt64 = 3 − 2
      let _: UInt32 = 3 − 2
      let _: UInt16 = 3 − 2
      let _: UInt8 = 3 − 2
      let _: Int = 3 − 2
      let _: Int64 = 3 − 2
      let _: Int32 = 3 − 2
      let _: Int16 = 3 − 2
      let _: Int8 = 3 − 2
      let _: Double = 3 − 2
      #if !(os(Windows) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
        let _: Float80 = 3 − 2
      #endif
      let _: Float = 3 − 2
    #endif
  }
}
