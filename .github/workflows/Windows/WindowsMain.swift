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

@testable import SDGCalendarTests
@testable import SDGCollectionsTests
@testable import SDGControlFlowTests
@testable import SDGExternalProcessTests
@testable import SDGLogicTests
@testable import SDGMathematicsTests
@testable import SDGPersistenceTests
@testable import SDGTextTests

extension SDGCalendarAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCalendarComponent", testCalendarComponent),
      ("testCalendarDate", testCalendarDate),
      ("testCalendarInterval", testCalendarInterval),
      ("testGregorianDay", testGregorianDay),
      ("testGregorianHour", testGregorianHour),
      ("testGregorianMinute", testGregorianMinute),
      ("testGregorianMonth", testGregorianMonth),
      ("testGregorianSecond", testGregorianSecond),
      ("testGregorianWeekday", testGregorianWeekday),
      ("testGregorianYear", testGregorianYear),
      ("testHebrewDay", testHebrewDay),
      ("testHebrewHour", testHebrewHour),
      ("testHebrewMonth", testHebrewMonth),
      ("testHebrewMonthAndYear", testHebrewMonthAndYear),
      ("testHebrewPart", testHebrewPart),
      ("testHebrewWeekday", testHebrewWeekday),
      ("testHebrewYear", testHebrewYear),
      ("testWeekday", testWeekday),
    ])
  ]
}

extension SDGCalendarInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDate", testDate),
      ("testGregorianMonth", testGregorianMonth),
      ("testGregorianWeekdayDate", testGregorianWeekdayDate),
      ("testHebrewWeekdayDate", testHebrewWeekdayDate),
      ("testHebrewYear", testHebrewYear),
      ("testHebrewYear", testHebrewYear),
      ("testRelativeDate", testRelativeDate),
    ])
  ]
}

extension SDGCalendarRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCalendarEquatability", testCalendarEquatability),
      ("testWeekday", testWeekday),
    ])
  ]
}

extension SDGCollectionsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAbsoluteComplement", testAbsoluteComplement),
      ("testAddable", testAddable),
      ("testAlternativePatterns", testAlternativePatterns),
      ("testAnyPattern", testAnyPattern),
      ("testArray", testArray),
      ("testBidirectionalCollection", testBidirectionalCollection),
      ("testBijectiveMapping", testBijectiveMapping),
      ("testCollection", testCollection),
      ("testCollectionDifference", testCollectionDifference),
      ("testCollectionDifferenceChange", testCollectionDifferenceChange),
      ("testComparableSet", testComparableSet),
      ("testConcatenatedPatterns", testConcatenatedPatterns),
      ("testConditionalPattern", testConditionalPattern),
      ("testContextualMapping", testContextualMapping),
      ("testDictionary", testDictionary),
      ("testFiniteSet", testFiniteSet),
      ("testIntensionalSet", testIntensionalSet),
      ("testIntersection", testIntersection),
      ("testLiteralPattern", testLiteralPattern),
      ("testMutableSet", testMutableSet),
      ("testNegatedPattern", testNegatedPattern),
      ("testPatternClassCluster", testPatternClassCluster),
      ("testRange", testRange),
      ("testRangeReplaceableCollection", testRangeReplaceableCollection),
      ("testRepetitionPattern", testRepetitionPattern),
      ("testSet", testSet),
      ("testSetInRepresentableUniverse", testSetInRepresentableUniverse),
      ("testSymmetricDifference", testSymmetricDifference),
      ("testUnion", testUnion),
    ])
  ]
}

extension SDGCollectionsRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testBoundedRepetitionPatternSearch", testBoundedRepetitionPatternSearch),
      ("testTrailingConditionSearch", testTrailingConditionSearch),
      ("testSubstringContainmentIsUnambiguous", testSubstringContainmentIsUnambiguous),
    ])
  ]
}

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

extension SDGExternalProcessAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testExternalProcess", testExternalProcess),
      ("testExternalProcessError", testExternalProcessError),
      ("testShell", testShell),
    ])
  ]
}

extension SDGExternalProcessRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDelayedShellOutput", testDelayedShellOutput),
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

extension SDGPersistenceAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testFileConvertible", testFileConvertible),
      ("testFileManager", testFileManager),
      ("testLosslessStringConvertible", testLosslessStringConvertible),
      ("testPreferences", testPreferences),
      ("testSpecification", testSpecification),
      ("testURL", testURL),
    ])
  ]
}

extension SDGPersistenceRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCachePermissions", testCachePermissions),
      ("testPercentEncodingIsNotDoubled", testPercentEncodingIsNotDoubled),
    ])
  ]
}

extension SDGTextAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCharacterSet", testCharacterSet),
      ("testFont", testFont),
      ("testLineView", testLineView),
      ("testLineViewIndex", testLineViewIndex),
      ("testRange", testRange),
      ("testNewlinePattern", testNewlinePattern),
      ("testScalarView", testScalarView),
      ("testSemanticMarkup", testSemanticMarkup),
      ("testStrictString", testStrictString),
      ("testStrictStringClusterView", testStrictStringClusterView),
      ("testString", testString),
      ("testStringClusterIndex", testStringClusterIndex),
      ("testStringFamily", testStringFamily),
      ("testStringScalarIndex", testStringScalarIndex),
      ("testStringScalarView", testStringScalarView),
      ("testUnicodeScalar", testUnicodeScalar),
    ])
  ]
}

extension SDGTextInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLineViewIndex", testLineViewIndex),
    ])
  ]
}

extension SDGTextRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLastLineNotDropped", testLastLineNotDropped),
      ("testMatchlessComponentSeperation", testMatchlessComponentSeperation),
      ("testMatchlessSearch", testMatchlessSearch),
      ("testNestingLevelLocation", testNestingLevelLocation),
      ("testReverseSearch", testReverseSearch),
      (
        "testSemanticMarkupToAttributedStringPreservesFont",
        testSemanticMarkupToAttributedStringPreservesFont
      ),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGCalendarAPITests.windowsTests
tests += SDGCalendarInternalTests.windowsTests
tests += SDGCalendarRegressionTests.windowsTests
tests += SDGCollectionsAPITests.windowsTests
tests += SDGCollectionsRegressionTests.windowsTests
tests += SDGControlFlowAPITests.windowsTests
tests += SDGExternalProcessAPITests.windowsTests
tests += SDGExternalProcessRegressionTests.windowsTests
tests += SDGLogicAPITests.windowsTests
tests += SDGMathematicsAPITests.windowsTests
tests += SDGMathematicsRegressionTests.windowsTests
tests += SDGPersistenceAPITests.windowsTests
tests += SDGPersistenceRegressionTests.windowsTests
tests += SDGTextAPITests.windowsTests
tests += SDGTextInternalTests.windowsTests
tests += SDGTextRegressionTests.windowsTests

XCTMain(tests)
