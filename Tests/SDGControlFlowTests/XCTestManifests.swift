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

extension SDGControlFlowAPITests {
    static let __allTests = [
        ("testBuildConfiguration", testBuildConfiguration),
        ("testCaching", testCaching),
        ("testCodable", testCodable),
        ("testIterableEnumeration", testIterableEnumeration),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testNonmutatingVariants", testNonmutatingVariants),
        ("testPerformanceTest", testPerformanceTest),
        ("testShared", testShared),
        ("testWeak", testWeak)
    ]
}

#if !canImport(ObjectiveC)
// MARK: - #if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGControlFlowAPITests.__allTests)
    ]
}
#endif
