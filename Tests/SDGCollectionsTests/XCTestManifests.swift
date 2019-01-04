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

extension SDGCollectionsAPITests {
    static let __allTests = [
        ("testAbsoluteComplement", testAbsoluteComplement),
        ("testAlternativePatterns", testAlternativePatterns),
        ("testArray", testArray),
        ("testBidirectionalCollection", testBidirectionalCollection),
        ("testBijectiveMapping", testBijectiveMapping),
        ("testCollection", testCollection),
        ("testComparableSet", testComparableSet),
        ("testCompositePattern", testCompositePattern),
        ("testConditionalPattern", testConditionalPattern),
        ("testDictionary", testDictionary),
        ("testFiniteSet", testFiniteSet),
        ("testIntensionalSet", testIntensionalSet),
        ("testIntersection", testIntersection),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testLiteralPattern", testLiteralPattern),
        ("testMutableSet", testMutableSet),
        ("testNotPattern", testNotPattern),
        ("testPatternClassCluster", testPatternClassCluster),
        ("testRange", testRange),
        ("testRangeReplaceableCollection", testRangeReplaceableCollection),
        ("testRepetitionPattern", testRepetitionPattern),
        ("testSet", testSet),
        ("testSetInRepresentableUniverse", testSetInRepresentableUniverse),
        ("testSymmetricDifference", testSymmetricDifference),
        ("testUnion", testUnion)
    ]
}

extension SDGCollectionsRegressionTests {
    static let __allTests = [
        ("testBoundedRepetitionPatternSearch", testBoundedRepetitionPatternSearch),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility)
    ]
}

#if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGCollectionsAPITests.__allTests),
        testCase(SDGCollectionsRegressionTests.__allTests)
    ]
}
#endif
