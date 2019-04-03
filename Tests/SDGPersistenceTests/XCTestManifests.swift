/*
 XCTestManifests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

extension SDGPersistenceAPITests {
    static let __allTests = [
        ("testFileConvertible", testFileConvertible),
        ("testFileManager", testFileManager),
        ("testLosslessStringConvertible", testLosslessStringConvertible),
        ("testPreferences", testPreferences),
        ("testSpecification", testSpecification),
        ("testURL", testURL)
    ]
}

extension SDGPersistenceRegressionTests {
    static let __allTests = [
        ("testCachePermissions", testCachePermissions),
        ("testPercentEncodingIsNotDoubled", testPercentEncodingIsNotDoubled)
    ]
}

#if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGPersistenceAPITests.__allTests),
        testCase(SDGPersistenceRegressionTests.__allTests)
    ]
}
#endif
