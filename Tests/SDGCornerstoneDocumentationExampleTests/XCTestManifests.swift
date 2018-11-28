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

extension DateExampleTests {
    static let __allTests = [
        ("testCustomDate", testCustomDate),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility)
    ]
}

extension FunctionAnalysisExampleTests {
    static let __allTests = [
        ("testFindLocalMinimum", testFindLocalMinimum),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testUndefinedCaseOneForFindLocalMaximum", testUndefinedCaseOneForFindLocalMaximum),
        ("testUndefinedCaseOneForFindLocalMinimum", testUndefinedCaseOneForFindLocalMinimum),
        ("testUndefinedCaseTwoForFindLocalMaximum", testUndefinedCaseTwoForFindLocalMaximum),
        ("testUndefinedCaseTwoForFindLocalMinimum", testUndefinedCaseTwoForFindLocalMinimum)
    ]
}

extension MiscellaneousExampleTests {
    static let __allTests = [
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
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testNestingLevel", testNestingLevel),
        ("testRationalNumberLiterals", testRationalNumberLiterals),
        ("testRunLoopUsage", testRunLoopUsage),
        ("testWholeNumberLiterals", testWholeNumberLiterals)
    ]
}

extension ReadMeExampleTests {
    static let __allTests = [
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testReadMe", testReadMe)
    ]
}

#if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DateExampleTests.__allTests),
        testCase(FunctionAnalysisExampleTests.__allTests),
        testCase(MiscellaneousExampleTests.__allTests),
        testCase(ReadMeExampleTests.__allTests)
    ]
}
#endif
