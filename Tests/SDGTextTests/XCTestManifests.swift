/*
 XCTestManifests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

extension SDGTextAPITests {
    static let __allTests = [
        ("testCharacterSet", testCharacterSet),
        ("testLineView", testLineView),
        ("testLineViewIndex", testLineViewIndex),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testNewlinePattern", testNewlinePattern),
        ("testRange", testRange),
        ("testScalarView", testScalarView),
        ("testSemanticMarkup", testSemanticMarkup),
        ("testStrictString", testStrictString),
        ("testStrictStringClusterView", testStrictStringClusterView),
        ("testString", testString),
        ("testStringClusterIndex", testStringClusterIndex),
        ("testStringScalarIndex", testStringScalarIndex),
        ("testStringScalarView", testStringScalarView),
        ("testUnicodeScalar", testUnicodeScalar),
    ]
}

extension SDGTextInternalTests {
    static let __allTests = [
        ("testLineViewIndex", testLineViewIndex),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
    ]
}

extension SDGTextRegressionTests {
    static let __allTests = [
        ("testLastLineNotDropped", testLastLineNotDropped),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testMatchlessComponentSeperation", testMatchlessComponentSeperation),
        ("testMatchlessSearch", testMatchlessSearch),
        ("testNestingLevelLocation", testNestingLevelLocation),
        ("testReverseSearch", testReverseSearch),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGTextAPITests.__allTests),
        testCase(SDGTextInternalTests.__allTests),
        testCase(SDGTextRegressionTests.__allTests),
    ]
}
#endif
