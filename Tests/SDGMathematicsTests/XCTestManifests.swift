/*
 XCTestManifests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

extension SDGMathematicsAPITests {
    static let __allTests = [
        ("testAddable", testAddable),
        ("testAngle", testAngle),
        ("testBitField", testBitField),
        ("testComparable", testComparable),
        ("testFloat", testFloat),
        ("testFunctionAnalysis", testFunctionAnalysis),
        ("testInt", testInt),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testOneDimensionalPoint", testOneDimensionalPoint),
        ("testOrderedEnumeration", testOrderedEnumeration),
        ("testPointProtocol", testPointProtocol),
        ("testRealArithmetic", testRealArithmetic),
        ("testSequence", testSequence),
        ("testSubtractable", testSubtractable),
        ("testTuple", testTuple),
        ("testUInt", testUInt),
        ("testVectorProtocol", testVectorProtocol)
    ]
}

extension SDGMathematicsRegressionTests {
    static let __allTests = [
        ("testAddAndSetIsUnambiguous", testAddAndSetIsUnambiguous),
        ("testDivisionIsUnambiguous", testDivisionIsUnambiguous),
        ("testDivisionOfNegatives", testDivisionOfNegatives),
        ("testFloor", testFloor),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testSubtraction", testSubtraction),
        ("testSubtractionIsUnambiguous", testSubtractionIsUnambiguous)
    ]
}

#if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGMathematicsAPITests.__allTests),
        testCase(SDGMathematicsRegressionTests.__allTests)
    ]
}
#endif
