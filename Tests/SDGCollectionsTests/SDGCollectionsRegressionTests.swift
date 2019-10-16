/*
 SDGCollectionsRegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import XCTest

import SDGXCTestUtilities

class SDGCollectionsRegressionTests : TestCase {

    func testBoundedRepetitionPatternSearch() {
        // Untracked

        XCTAssertEqual([1, 1, 1][1 ..< 2].matches(for: RepetitionPattern(LiteralPattern([1]))).map({ $0.range }), [1 ..< 2])
    }

    func testTrailingConditionSearch() {
        // Untracked

        XCTAssertNil([1, 2, 3].firstMatch(for: [1, 2, 3] + ConditionalPattern({ _ in true })))
    }
}
