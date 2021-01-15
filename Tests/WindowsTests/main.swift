/*
 main.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

extension SDGBinaryDataTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testData", testData),
      ("testDataStream", testDataStream),
      ("testUInt", testUInt),
    ])
  ]
}

extension SDGCalendarTests.APITests {
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

extension SDGCalendarTests.InternalTests {
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

extension SDGCalendarTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCalendarEquatability", testCalendarEquatability),
      ("testWeekday", testWeekday),
    ])
  ]
}

extension SDGCollationTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCoding", testCoding),
      ("testCollationOrder", testCollationOrder),
      ("testInterspersion", testInterspersion),
    ])
  ]
}

extension SDGCollationTests.LanguageTests {
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

extension SDGCollectionsTests.APITests {
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
      ("testLexicographicalComparison", testLexicographicalComparison),
      ("testLiteralPattern", testLiteralPattern),
      ("testMutableSet", testMutableSet),
      ("testNegatedPattern", testNegatedPattern),
      ("testOrderedSet", testOrderedSet),
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

extension SDGCollectionsTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testBoundedRepetitionPatternSearch", testBoundedRepetitionPatternSearch),
      (
        "testContextualMappingUsesFallbackOnPartialMatch",
        testContextualMappingUsesFallbackOnPartialMatch
      ),
      ("testTrailingConditionSearch", testTrailingConditionSearch),
      ("testSubstringContainmentIsUnambiguous", testSubstringContainmentIsUnambiguous),
    ])
  ]
}

extension SDGConcurrencyTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testRunLoop", testRunLoop)
    ])
  ]
}

extension SDGControlFlowTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCaching", testCaching),
      ("testCodable", testCodable),
      ("testNonmutatingVariants", testNonmutatingVariants),
      ("testPerformanceTest", testPerformanceTest),
      ("testShared", testShared),
      ("testSharedProperty", testSharedProperty),
      ("testTuple", testTuple),
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
      ("testReadMe", testReadMe)
    ])
  ]
}

extension SDGCornerstoneDocumentationExampleTests.StrictInterpolationExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testStrictInterpolation", testStrictInterpolation)
    ])
  ]
}

extension SDGExternalProcessTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testExternalProcess", testExternalProcess),
      ("testExternalProcessError", testExternalProcessError),
      ("testShell", testShell),
    ])
  ]
}

extension SDGExternalProcessTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCMDWorks", testCMDWorks),
      ("testDelayedShellOutput", testDelayedShellOutput),
      ("testSearchFindsGit", testSearchFindsGit),
    ])
  ]
}

extension SDGGeometryTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAngle", testAngle),
      ("testBézierPath", testBézierPath),
      ("testPoint", testPoint),
      ("testVector", testVector),
    ])
  ]
}

extension SDGLocalizationTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAngle", testAngle),
      ("testAnyLocalization", testAnyLocalization),
      ("testBool", testBool),
      ("testCasing", testCasing),
      ("testCustomStringConvertible", testCustomStringConvertible),
      ("testEnglishCasing", testEnglishCasing),
      ("testGrammaticalGender", testGrammaticalGender),
      ("testGrammaticalNumber", testGrammaticalNumber),
      ("testΓραμματικήΠτώση", testΓραμματικήΠτώση),
      ("testLocalization", testLocalization),
      ("testLocalizationData", testLocalizationData),
      ("testLocalizationRelationships", testLocalizationRelationships),
      ("testLocalizationSetting", testLocalizationSetting),
      ("testמין־דיקדקי", testמין־דיקדקי),
      ("testRange", testRange),
      ("testRationalArithmetic", testRationalArithmetic),
      ("testStateData", testStateData),
      ("testUserFacingDynamicText", testUserFacingDynamicText),
      ("testWholeArithmetic", testWholeArithmetic),
    ])
  ]
}

extension SDGLocalizationTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContentLocalization", testContentLocalization),
      ("testInterfaceLocalization", testInterfaceLocalization),
      ("testLocalizationSetting", testLocalizationSetting),
      ("testWholeNumber", testWholeNumber),
    ])
  ]
}

extension SDGLogicTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAny", testAny),
      ("testBool", testBool),
      ("testEquatable", testEquatable),
      ("testOptional", testOptional),
    ])
  ]
}

extension SDGMathematicsTests.APITests {
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

extension SDGMathematicsTests.RegressionTests {
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

extension SDGPersistenceTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testFileConvertible", testFileConvertible),
      ("testFileManager", testFileManager),
      ("testLosslessStringConvertible", testLosslessStringConvertible),
      ("testPreferences", testPreferences),
      ("testSpecification", testSpecification),
      ("testURL", testURL),
      ("testXMLEncoder", testXMLEncoder),
    ])
  ]
}

extension SDGPersistenceTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAndroidTemporaryDirectory", testAndroidTemporaryDirectory),
      ("testCachePermissions", testCachePermissions),
      ("testDirectoryDetection", testDirectoryDetection),
      ("testPercentEncodingIsNotDoubled", testPercentEncodingIsNotDoubled),
      ("testRemoteURLs", testRemoteURLs),
    ])
  ]
}

extension SDGPrecisionMathematicsTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testInteger", testInteger),
      ("testRationalNumber", testRationalNumber),
      ("testWholeNumber", testWholeNumber),
    ])
  ]
}

extension SDGPrecisionMathematicsTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testUIntHalvesView", testUIntHalvesView),
      ("testWholeNumberBinaryView", testWholeNumberBinaryView),
    ])
  ]
}

extension SDGRandomizationTests.APITests {
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

extension SDGTextTests.APITests {
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

extension SDGTextTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLineViewIndex", testLineViewIndex)
    ])
  ]
}

extension SDGTextTests.RegressionTests {
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

extension SDGVersioningTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testVersion", testVersion)
    ])
  ]
}

extension SDGVersioningTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testWindowsGitVersionDetectable", testWindowsGitVersionDetectable),
      ("testVersionRangesCanBeCreated", testVersionRangesCanBeCreated),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGBinaryDataTests.APITests.windowsTests
tests += SDGCalendarTests.APITests.windowsTests
tests += SDGCalendarTests.InternalTests.windowsTests
tests += SDGCalendarTests.RegressionTests.windowsTests
tests += SDGCollationTests.APITests.windowsTests
tests += SDGCollationTests.LanguageTests.windowsTests
tests += SDGCollectionsTests.APITests.windowsTests
tests += SDGCollectionsTests.RegressionTests.windowsTests
tests += SDGConcurrencyTests.APITests.windowsTests
tests += SDGControlFlowTests.APITests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.DateExampleTests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.FunctionAnalysisExampleTests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.MiscellaneousExampleTests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.ReadMeExampleTests.windowsTests
tests += SDGCornerstoneDocumentationExampleTests.StrictInterpolationExampleTests.windowsTests
tests += SDGExternalProcessTests.APITests.windowsTests
tests += SDGExternalProcessTests.RegressionTests.windowsTests
tests += SDGGeometryTests.APITests.windowsTests
tests += SDGLocalizationTests.APITests.windowsTests
tests += SDGLocalizationTests.InternalTests.windowsTests
tests += SDGLogicTests.APITests.windowsTests
tests += SDGMathematicsTests.APITests.windowsTests
tests += SDGMathematicsTests.RegressionTests.windowsTests
tests += SDGPersistenceTests.APITests.windowsTests
tests += SDGPersistenceTests.RegressionTests.windowsTests
tests += SDGPrecisionMathematicsTests.APITests.windowsTests
tests += SDGPrecisionMathematicsTests.InternalTests.windowsTests
tests += SDGRandomizationTests.APITests.windowsTests
tests += SDGTextTests.APITests.windowsTests
tests += SDGTextTests.InternalTests.windowsTests
tests += SDGTextTests.RegressionTests.windowsTests
tests += SDGVersioningTests.APITests.windowsTests
tests += SDGVersioningTests.RegressionTests.windowsTests

XCTMain(tests)
