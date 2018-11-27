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

extension SDGLocalizationAPITests {
    static let __allTests = [
        ("testAngle", testAngle),
        ("testBool", testBool),
        ("testCasing", testCasing),
        ("testCustomStringConvertible", testCustomStringConvertible),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testLocalization", testLocalization),
        ("testLocalizationRelationships", testLocalizationRelationships),
        ("testLocalizationSetting", testLocalizationSetting),
        ("testRange", testRange),
        ("testRationalArithmetic", testRationalArithmetic),
        ("testUserFacingDynamicText", testUserFacingDynamicText),
        ("testWholeArithmetic", testWholeArithmetic)
    ]
}

extension SDGLocalizationInternalTests {
    static let __allTests = [
        ("testContentLocalization", testContentLocalization),
        ("testInterfaceLocalization", testInterfaceLocalization),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testLocalizationSetting", testLocalizationSetting),
        ("testWholeNumber", testWholeNumber)
    ]
}

#if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGLocalizationAPITests.__allTests),
        testCase(SDGLocalizationInternalTests.__allTests)
    ]
}
#endif
