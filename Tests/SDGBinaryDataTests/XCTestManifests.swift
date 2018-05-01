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

extension SDGBinaryDataAPITests {
    static let __allTests = [
        ("testData", testData),
        ("testDataStream", testDataStream),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testUInt", testUInt)
    ]
}

#if !canImport(ObjectiveC)
// MARK: - #if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGBinaryDataAPITests.__allTests)
    ]
}
#endif
