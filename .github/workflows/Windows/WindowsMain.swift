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

extension SDGBinaryDataAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testData", testData),
      ("testDataStream", testDataStream),
      ("testUInt", testUInt),
    ])
  ]
}

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

extension SDGCollationAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCoding", testCoding),
      ("testCollationOrder", testCollationOrder),
      ("testInterspersion", testInterspersion),
    ])
  ]
}

extension SDGCollationLanguageTests {
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

extension SDGConcurrencyAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testRunLoop", testRunLoop),
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

extension DateExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCustomDate", testCustomDate),
      ("testCustomDate", testCustomDate),
    ])
  ]
}

extension FunctionAnalysisExampleTests {
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

extension MiscellaneousExampleTests {
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

extension ReadMeExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testReadMe", testReadMe),
    ])
  ]
}

extension StrictInterpolationExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testStrictInterpolation", testStrictInterpolation),
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

extension SDGGeometryAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAngle", testAngle),
      ("testBézierPath", testBézierPath),
      ("testPoint", testPoint),
      ("testVector", testVector),
    ])
  ]
}

extension SDGLocalizationAPITests {
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

extension SDGLocalizationInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContentLocalization", testContentLocalization),
      ("testInterfaceLocalization", testInterfaceLocalization),
      ("testLocalizationSetting", testLocalizationSetting),
      ("testWholeNumber", testWholeNumber),
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
      ("testAndroidTemporaryDirectory", testAndroidTemporaryDirectory),
      ("testCachePermissions", testCachePermissions),
      ("testPercentEncodingIsNotDoubled", testPercentEncodingIsNotDoubled),
    ])
  ]
}

extension SDGPrecisionMathematicsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testInteger", testInteger),
      ("testRationalNumber", testRationalNumber),
      ("testWholeNumber", testWholeNumber),
    ])
  ]
}

extension SDGPrecisionMathematicsInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testUIntHalvesView", testUIntHalvesView),
      ("testWholeNumberBinaryView", testWholeNumberBinaryView),
    ])
  ]
}

extension SDGRandomizationAPITests {
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

extension SDGVersioningAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testVersion", testVersion),
    ])
  ]
}

extension SDGVersioningRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testVersionRangesCanBeCreated", testVersionRangesCanBeCreated),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGBinaryDataAPITests.windowsTests
tests += SDGCalendarAPITests.windowsTests
tests += SDGCalendarInternalTests.windowsTests
tests += SDGCalendarRegressionTests.windowsTests
tests += SDGCollationAPITests.windowsTests
tests += SDGCollationLanguageTests.windowsTests
tests += SDGCollectionsAPITests.windowsTests
tests += SDGCollectionsRegressionTests.windowsTests
tests += SDGConcurrencyAPITests.windowsTests
tests += SDGControlFlowAPITests.windowsTests
tests += DateExampleTests.windowsTests
tests += FunctionAnalysisExampleTests.windowsTests
tests += MiscellaneousExampleTests.windowsTests
tests += ReadMeExampleTests.windowsTests
tests += StrictInterpolationExampleTests.windowsTests
tests += SDGExternalProcessAPITests.windowsTests
tests += SDGExternalProcessRegressionTests.windowsTests
tests += SDGGeometryAPITests.windowsTests
tests += SDGLocalizationAPITests.windowsTests
tests += SDGLocalizationInternalTests.windowsTests
tests += SDGLogicAPITests.windowsTests
tests += SDGMathematicsAPITests.windowsTests
tests += SDGMathematicsRegressionTests.windowsTests
tests += SDGPersistenceAPITests.windowsTests
tests += SDGPersistenceRegressionTests.windowsTests
tests += SDGPrecisionMathematicsAPITests.windowsTests
tests += SDGPrecisionMathematicsInternalTests.windowsTests
tests += SDGRandomizationAPITests.windowsTests
tests += SDGTextAPITests.windowsTests
tests += SDGTextInternalTests.windowsTests
tests += SDGTextRegressionTests.windowsTests
tests += SDGVersioningAPITests.windowsTests
tests += SDGVersioningRegressionTests.windowsTests

XCTMain(tests)
