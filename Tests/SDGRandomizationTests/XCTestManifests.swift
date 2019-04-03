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

extension SDGRandomizationAPITests {
    static let __allTests = [
        ("testBool", testBool),
        ("testCollection", testCollection),
        ("testCyclicalNumberGenerator", testCyclicalNumberGenerator),
        ("testMeasurement", testMeasurement),
        ("testPseudorandomNumberGenerator", testPseudorandomNumberGenerator),
        ("testRangeReplaceableCollection", testRangeReplaceableCollection)
    ]
}

#if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGRandomizationAPITests.__allTests)
    ]
}
#endif
