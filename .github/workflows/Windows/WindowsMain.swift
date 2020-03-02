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

@testable import SDGBinaryDataTests
@testable import SDGCalendarTests
@testable import SDGCollationTests
@testable import SDGCollectionsTests
@testable import SDGConcurrencyTests
@testable import SDGControlFlowTests
@testable import SDGCornerstoneDocumentationExampleTests
@testable import SDGExternalProcessTests
@testable import SDGGeometryTests
@testable import SDGLocalizationTests
@testable import SDGLogicTests
@testable import SDGMathematicsTests
@testable import SDGPersistenceTests
@testable import SDGPrecisionMathematicsTests
@testable import SDGRandomizationTests
@testable import SDGTextTests
@testable import SDGVersioningTests

extension SDGBinaryDataTests.SDGBinaryDataAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testData", testData),
      ("testDataStream", testDataStream),
      ("testUInt", testUInt),
    ])
  ]
}

extension SDGCalendarTests.SDGCalendarAPITests {
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

extension SDGCalendarTests.SDGCalendarInternalTests {
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

extension SDGCalendarTests.SDGCalendarRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCalendarEquatability", testCalendarEquatability),
      ("testWeekday", testWeekday),
    ])
  ]
}

extension SDGCollationTests.SDGCollationAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCoding", testCoding),
      ("testCollationOrder", testCollationOrder),
      ("testInterspersion", testInterspersion),
    ])
  ]
}

extension SDGCollationTests.SDGCollationLanguageTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAramaic", testAramaic),
      ("testBosnian", testBosnian),
      ("testEnglish", testEnglish),
      ("testFrench", testFrench),
      ("testGerman", testGerman),
      ("testGreek", testGreek),
      ("testHebrew", testHebrew),
      ("testItalian", testItalian),
      ("testSpanish", testSpanish),
    ])
  ]
}

extension SDGCollectionsTests.SDGCollectionsAPITests {
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

extension SDGCollectionsTests.SDGCollectionsRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testBoundedRepetitionPatternSearch", testBoundedRepetitionPatternSearch),
      ("testTrailingConditionSearch", testTrailingConditionSearch),
      ("testSubstringContainmentIsUnambiguous", testSubstringContainmentIsUnambiguous),
    ])
  ]
}

extension SDGConcurrencyTests.SDGConcurrencyAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testRunLoop", testRunLoop),
    ])
  ]
}

extension SDGControlFlowTests.SDGControlFlowAPITests {
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

extension SDGCornerstoneDocumentationExampleTests.DateExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCustomDate", testCustomDate),
      ("testCustomDate", testCustomDate),
    ])
  ]
}

extension SDGCornerstoneDocumentationExampleTests.FunctionAnalysisExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testFindLocalMinimum", testFindLocalMinimum),
      ("testUndefinedCaseOneForFindLocalMaximum", testUndefinedCaseOneForFindLocalMaximum),
      ("testUndefinedCaseOneForFindLocalMinimum", testUndefinedCaseOneForFindLocalMinimum),
      ("testUndefinedCaseTwoForFindLocalMaximum", testUndefinedCaseTwoForFindLocalMaximum),
      ("testUndefinedCaseTwoForFindLocalMinimum", testUndefinedCaseTwoForFindLocalMinimum),
    ])
  ]
}

extension SDGCornerstoneDocumentationExampleTests.MiscellaneousExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAbsoluteValue", testAbsoluteValue),
      ("testAlternatingBooleans", testAlternatingBooleans),
      ("testApproximation", testApproximation),
      ("testBackwardsSearchDifferences1", testBackwardsSearchDifferences1),
      ("testBackwardsSearchDifferences2", testBackwardsSearchDifferences2),
      ("testDecreasing", testDecreasing),
      ("testDictionaryMutation", testDictionaryMutation),
      ("testGregorianYear", testGregorianYear),
      ("testIncreasing", testIncreasing),
      ("testIntegerLiterals", testIntegerLiterals),
      ("testNestingLevel", testNestingLevel),
      ("testPatternSwitch", testPatternSwitch),
      ("testRationalNumberLiterals", testRationalNumberLiterals),
      ("testRunLoopUsage", testRunLoopUsage),
      ("testSetSwitch", testSetSwitch),
      ("testWholeNumberLiterals", testWholeNumberLiterals),
    ])
  ]
}

extension SDGCornerstoneDocumentationExampleTests.ReadMeExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testReadMe", testReadMe),
    ])
  ]
}

extension SDGCornerstoneDocumentationExampleTests.StrictInterpolationExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testStrictInterpolation", testStrictInterpolation),
    ])
  ]
}

extension SDGExternalProcessTests.SDGExternalProcessAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testExternalProcess", testExternalProcess),
      ("testExternalProcessError", testExternalProcessError),
      ("testShell", testShell),
    ])
  ]
}

extension SDGExternalProcessTests.SDGExternalProcessRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDelayedShellOutput", testDelayedShellOutput),
    ])
  ]
}

extension SDGGeometryTests.SDGGeometryAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAngle", testAngle),
      ("testBézierPath", testBézierPath),
      ("testPoint", testPoint),
      ("testVector", testVector),
    ])
  ]
}

extension SDGLocalizationTests.SDGLocalizationAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAngle", testAngle),
      ("testAnyLocalization", testAnyLocalization),
      ("testBool", testBool),
      ("testCasing", testCasing),
      ("testCustomStringConvertible", testCustomStringConvertible),
      ("testLocalization", testLocalization),
      ("testLocalizationData", testLocalizationData),
      ("testLocalizationRelationships", testLocalizationRelationships),
      ("testLocalizationSetting", testLocalizationSetting),
      ("testRange", testRange),
      ("testRationalArithmetic", testRationalArithmetic),
      ("testStateData", testStateData),
      ("testUserFacingDynamicText", testUserFacingDynamicText),
      ("testWholeArithmetic", testWholeArithmetic),
    ])
  ]
}

extension SDGLocalizationTests.SDGLocalizationInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContentLocalization", testContentLocalization),
      ("testInterfaceLocalization", testInterfaceLocalization),
      ("testLocalizationSetting", testLocalizationSetting),
      ("testWholeNumber", testWholeNumber),
    ])
  ]
}

extension SDGLogicTests.SDGLogicAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAny", testAny),
      ("testBool", testBool),
      ("testEquatable", testEquatable),
      ("testOptional", testOptional),
    ])
  ]
}

extension SDGMathematicsTests.SDGMathematicsAPITests {
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

extension SDGMathematicsTests.SDGMathematicsRegressionTests {
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

extension SDGPersistenceTests.SDGPersistenceAPITests {
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

extension SDGPersistenceTests.SDGPersistenceRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAndroidTemporaryDirectory", testAndroidTemporaryDirectory),
      ("testCachePermissions", testCachePermissions),
      ("testPercentEncodingIsNotDoubled", testPercentEncodingIsNotDoubled),
    ])
  ]
}

extension SDGPrecisionMathematicsTests.SDGPrecisionMathematicsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testInteger", testInteger),
      ("testRationalNumber", testRationalNumber),
      ("testWholeNumber", testWholeNumber),
    ])
  ]
}

extension SDGPrecisionMathematicsTests.SDGPrecisionMathematicsInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testUIntHalvesView", testUIntHalvesView),
      ("testWholeNumberBinaryView", testWholeNumberBinaryView),
    ])
  ]
}

extension SDGRandomizationTests.SDGRandomizationAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testBool", testBool),
      ("testCollection", testCollection),
      ("testCyclicalNumberGenerator", testCyclicalNumberGenerator),
      ("testMeasurement", testMeasurement),
      ("testPseudorandomNumberGenerator", testPseudorandomNumberGenerator),
      ("testRangeReplaceableCollection", testRangeReplaceableCollection),
    ])
  ]
}

extension SDGTextTests.SDGTextAPITests {
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

extension SDGTextTests.SDGTextInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLineViewIndex", testLineViewIndex),
    ])
  ]
}

extension SDGTextTests.SDGTextRegressionTests {
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

extension SDGVersioningTests.SDGVersioningAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testVersion", testVersion),
    ])
  ]
}

extension SDGVersioningTests.SDGVersioningRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testVersionRangesCanBeCreated", testVersionRangesCanBeCreated),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGBinaryDataTests.SDGBinaryDataAPITests.windowsTests
tests += SDGCalendarTests.SDGCalendarAPITests.windowsTests
tests += SDGCalendarTests.SDGCalendarInternalTests.windowsTests
tests += SDGCalendarTests.SDGCalendarRegressionTests.windowsTests
tests += SDGCollationTests.SDGCollationAPITests.windowsTests
tests += SDGCollationTests.SDGCollationLanguageTests.windowsTests
tests += SDGCollectionsTests.SDGCollectionsAPITests.windowsTests
tests += SDGCollectionsTests.SDGCollectionsRegressionTests.windowsTests
tests += SDGConcurrencyTests.SDGConcurrencyAPITests.windowsTests
tests += SDGControlFlowTests.SDGControlFlowAPITests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.DateExampleTests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.FunctionAnalysisExampleTests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.MiscellaneousExampleTests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.ReadMeExampleTests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.StrictInterpolationExampleTests.windowsTests
tests += SDGExternalProcessTests.SDGExternalProcessAPITests.windowsTests
tests += SDGExternalProcessTests.SDGExternalProcessRegressionTests.windowsTests
tests += SDGGeometryTests.SDGGeometryAPITests.windowsTests
tests += SDGLocalizationTests.SDGLocalizationAPITests.windowsTests
tests += SDGLocalizationTests.SDGLocalizationInternalTests.windowsTests
tests += SDGLogicTests.SDGLogicAPITests.windowsTests
tests += SDGMathematicsTests.SDGMathematicsAPITests.windowsTests
tests += SDGMathematicsTests.SDGMathematicsRegressionTests.windowsTests
tests += SDGPersistenceTests.SDGPersistenceAPITests.windowsTests
tests += SDGPersistenceTests.SDGPersistenceRegressionTests.windowsTests
tests += SDGPrecisionMathematicsTests.SDGPrecisionMathematicsAPITests.windowsTests
tests += SDGPrecisionMathematicsTests.SDGPrecisionMathematicsInternalTests.windowsTests
tests += SDGRandomizationTests.SDGRandomizationAPITests.windowsTests
tests += SDGTextTests.SDGTextAPITests.windowsTests
tests += SDGTextTests.SDGTextInternalTests.windowsTests
tests += SDGTextTests.SDGTextRegressionTests.windowsTests
tests += SDGVersioningTests.SDGVersioningAPITests.windowsTests
tests += SDGVersioningTests.SDGVersioningRegressionTests.windowsTests

XCTMain(tests)
