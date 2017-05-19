/*
 RegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGCornerstone

class RegressionTests : XCTestCase {

    func testAddAndSetIsUnambiguous() {
        // Untracked

        func runTests<N : IntegralArithmetic>(_ type: N.Type) {
            var x: N = 0
            x −= 1
            XCTAssert(x == −1)
            XCTAssert(x − 1 == −2)
            x += 1
            XCTAssert(x == 0)
            XCTAssert(x + 1 == 1)
        }
        runTests(Int.self)
        runTests(Int64.self)
        runTests(Int32.self)
        runTests(Int16.self)
        runTests(Int8.self)
        runTests(Double.self)
        runTests(Float.self)
        runTests(Integer.self)
        runTests(RationalNumber.self)
        runTests(RealArithmeticExample.self)
    }

    func testDivisionIsUnambiguous() {
        // Untracked

        _ = Double(1) ÷ Double(1)
    }

    func testMatchlessComponentSeperation() {
        // Untracked

        let glitch = StrictString("@version 8.0.0")
        let components = glitch.components(separatedBy: ConditionalPattern(condition: { $0 ∈ ["#", "%"] as Set<UnicodeScalar> }))
        XCTAssert(¬components.isEmpty, "Empty result of splitting collection at matches.")
    }

    func testMatchlessSearch() {
        // Untracked

        XCTAssert(StrictString("...").firstMatch(for: "_".scalars) == nil, "False positive.")
    }

    func testNestingLevelLocation() {
        // Untracked

        let nestString = StrictString("%{1~a~a^a|^}")
        let open: StrictString = "{"
        let close: StrictString = "}"
        let start = nestString.index(nestString.startIndex, offsetBy: 1)
        let end = nestString.index(nestString.startIndex, offsetBy: 12)
        let nestRange = nestString.firstNestingLevel(startingWith: open, endingWith: close)?.container.range
        XCTAssert(nestRange == start ..< end, "Incorrect range for nested group.")
    }

    func testReverseSearch() {
        // Untracked

        let glitch = StrictString("x{a^a}")
        XCTAssert(glitch.lastMatch(for: "{".scalars)?.range == glitch.index(after: glitch.startIndex) ..< glitch.index(after: glitch.index(after: glitch.startIndex)), "Reverse searching failed.")
    }

    func testSubtraction() {
        // Untracked

        func runTests<N : WholeArithmetic>(_ type: N.Type) {
            let five: N = 10 − 5
            XCTAssert(five == 5)
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
        runTests(WholeNumber.self)
        runTests(Integer.self)
        runTests(RationalNumber.self)
    }

    func testSubtractionIsUnambiguous() {
        // Untracked

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
        #if os(macOS) || os(Linux)
            let _: Float80 = 3 − 2
        #endif
        let _: Float = 3 − 2
        let _: WholeNumber = 3 − 2
        let _: Integer = 3 − 2
        let _: RationalNumberTypeExample = RationalNumberTypeExample(3) − RationalNumberTypeExample(2)
        let _: RealArithmeticExample = RealArithmeticExample(3) − RealArithmeticExample(2)
    }

    static var allTests: [(String, (RegressionTests) -> () throws -> Void)] {
        return [
            ("testAddAndSetIsUnambiguous", testAddAndSetIsUnambiguous),
            ("testDivisionIsUnambiguous", testDivisionIsUnambiguous),
            ("testMatchlessComponentSeperation", testMatchlessComponentSeperation),
            ("testNestingLevelLocation", testNestingLevelLocation),
            ("testReverseSearch", testReverseSearch),
            ("testSubtraction", testSubtraction),
            ("testSubtractionIsUnambiguous", testSubtractionIsUnambiguous)
        ]
    }
}
