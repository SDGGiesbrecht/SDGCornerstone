/*
 RegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import XCTest

import SDGXCTestUtilities

class RegressionTests: TestCase {

  func testBoundedRepetitionPatternSearch() {
    // Untracked

    XCTAssertEqual(
      [1, 1, 1][1..<2].matches(for: RepetitionPattern([1])).map({ $0.range }),
      [1..<2]
    )
  }

  func testContextualMappingRetainsPartialMatches() {
    // Untracked

    let mapping = ContextualMapping<String, String>(
      mapping: [
        "ABC": "Z"
      ],
      fallbackAlgorithm: { String($0) }
    )
    XCTAssertEqual(mapping.map("AB"), "AB")
  }

  func testContextualMappingUsesFallbackOnPartialMatch() {
    // Untracked

    let mapping = ContextualMapping(
      mapping: [
        "II": [2]
      ],
      fallbackAlgorithm: { _ in [1] }
    )
    XCTAssertEqual(mapping.map("I"), [1])
  }

  func testTrailingConditionSearch() {
    // Untracked

    XCTAssertNil([1, 2, 3].firstMatch(for: [1, 2, 3] + ConditionalPattern({ _ in true })))
  }

  func testSubstringContainmentIsUnambiguous() {
    // Untracked

    let _: (String.SubSequence) -> Bool = { $0.contains("...") }

    let string = "..."
    var array = string.split { $0.isNewline }
    array = array.filter { $0.contains("...") }
  }
}
