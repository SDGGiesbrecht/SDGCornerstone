/*
 XCTestManifests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !canImport(ObjectiveC)
import XCTest

extension SDGMathematicsAPITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGMathematicsAPITests = [
        ("testAddable", testAddable),
        ("testAngle", testAngle),
        ("testBitField", testBitField),
        ("testComparable", testComparable),
        ("testFloat", testFloat),
        ("testFunctionAnalysis", testFunctionAnalysis),
        ("testInt", testInt),
        ("testNegatable", testNegatable),
        ("testOneDimensionalPoint", testOneDimensionalPoint),
        ("testOrderedEnumeration", testOrderedEnumeration),
        ("testPointProtocol", testPointProtocol),
        ("testRealArithmetic", testRealArithmetic),
        ("testSequence", testSequence),
        ("testSubtractable", testSubtractable),
        ("testTuple", testTuple),
        ("testUInt", testUInt),
        ("testVectorProtocol", testVectorProtocol),
    ]
}

extension SDGMathematicsRegressionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGMathematicsRegressionTests = [
        ("testAddAndSetIsUnambiguous", testAddAndSetIsUnambiguous),
        ("testDivisionIsUnambiguous", testDivisionIsUnambiguous),
        ("testDivisionOfNegatives", testDivisionOfNegatives),
        ("testFloor", testFloor),
        ("testSubtraction", testSubtraction),
        ("testSubtractionIsUnambiguous", testSubtractionIsUnambiguous),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGMathematicsAPITests.__allTests__SDGMathematicsAPITests),
        testCase(SDGMathematicsRegressionTests.__allTests__SDGMathematicsRegressionTests),
    ]
}
#endif
