/*
 WindowsMain.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

@testable import SDGControlFlowTests
@testable import SDGLogicTests
@testable import SDGMathematicsTests

extension SDGControlFlowAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCaching", testCaching),
      ("testCodable", testCodable),
      ("testNonmutatingVariants", testNonmutatingVariants),
      ("testPerformanceTest", testPerformanceTest),
      ("testShared", testShared),
      ("testSharedProperty", testSharedProperty),
      ("testWeak", testWeak),
    ])
  ]
}

extension SDGLogicAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAny", testAny),
      ("testBool", testBool),
      ("testEquatable", testEquatable),
      ("testOptional", testOptional),
    ])
  ]
}

extension SDGMathematicsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
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
    ])
  ]
}

extension SDGMathematicsRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAddAndSetIsUnambiguous", testAddAndSetIsUnambiguous),
      ("testComparisonAids", testComparisonAids),
      ("testDivisionIsUnambiguous", testDivisionIsUnambiguous),
      ("testDivisionOfNegatives", testDivisionOfNegatives),
      ("testFloor", testFloor),
      ("testSubtraction", testSubtraction),
      ("testSubtractionIsUnambiguous", testSubtractionIsUnambiguous),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGControlFlowAPITests.windowsTests
tests += SDGLogicAPITests.windowsTests
tests += SDGMathematicsAPITests.windowsTests
tests += SDGMathematicsRegressionTests.windowsTests

XCTMain(tests)
