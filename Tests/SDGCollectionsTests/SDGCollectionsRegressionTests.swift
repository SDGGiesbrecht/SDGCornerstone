/*
 SDGCollectionsRegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGXCTestUtilities

class SDGCollectionsRegressionTests : TestCase {

    func testBoundedRepetitionPatternSearch() {
        // Untracked

        XCTAssertEqual([1, 1, 1].matches(for: RepetitionPattern(LiteralPattern([1])), in: 1 ..< 2).map({ $0.range }), [1 ..< 2])
    }
}
