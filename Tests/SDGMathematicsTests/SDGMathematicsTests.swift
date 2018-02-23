/*
 SDGMathematicsTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematicsTestUtilities
import SDGXCTestUtilities

import SDGBinaryDataTestUtilities

class SDGMathematicsTests : TestCase {

    func testComparable() {
        test(operator: (≤, "≤"), on: (0, 1), returns: true)
        test(operator: (≤, "≤"), on: (0, 0), returns: true)
        test(operator: (≤, "≤"), on: (0, −1), returns: false)

        test(operator: (≥, "≥"), on: (0, 1), returns: false)
        test(operator: (≥, "≥"), on: (0, 0), returns: true)
        test(operator: (≥, "≥"), on: (0, −1), returns: true)
    }

    func testFloat() {
        testRealArithmeticCoreConformance(of: Double.self)
        testRealArithmeticCoreConformance(of: FloatMax.self)
        testRealArithmeticCoreConformance(of: CGFloat.self)
        testRealArithmeticCoreConformance(of: Float80.self)
        testRealArithmeticCoreConformance(of: Float.self)
    }

    func testInt() {
        testIntegralArithmeticCoreConformance(of: Int.self)
        testIntegralArithmeticCoreConformance(of: IntMax.self)
        testIntegralArithmeticCoreConformance(of: Int64.self)
        testIntegralArithmeticCoreConformance(of: Int32.self)
        testIntegralArithmeticCoreConformance(of: Int16.self)
        testIntegralArithmeticCoreConformance(of: Int8.self)
    }

    func testUInt() {
        testWholeArithmeticCoreConformance(of: UInt.self, includingNegatives: false)
        testWholeArithmeticCoreConformance(of: UIntMax.self, includingNegatives: false)
        testWholeArithmeticCoreConformance(of: UInt64.self, includingNegatives: false)
        testWholeArithmeticCoreConformance(of: UInt32.self, includingNegatives: false)
        testWholeArithmeticCoreConformance(of: UInt16.self, includingNegatives: false)
        testWholeArithmeticCoreConformance(of: UInt8.self, includingNegatives: false)
    }

    static var allTests: [(String, (SDGMathematicsTests) -> () throws -> Void)] {
        return [
            ("testComparable", testComparable),
            ("testFloat", testFloat),
            ("testInt", testInt),
            ("testUInt", testUInt)
        ]
    }
}
