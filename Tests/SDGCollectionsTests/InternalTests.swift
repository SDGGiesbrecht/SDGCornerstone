/*
 InternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGCollections

import XCTest

final class InternalTests: XCTestCase {

  func testNestingContentsPattern() {
    let string = "...(...(...(...)...(...)...)...(...)...)..."
    let pattern = NestingPattern(opening: "(", closing: ")").contents
    XCTAssertNotNil(pattern.primaryMatch(in: string, at: string.dropFirst(3).startIndex))
    XCTAssertEqual(string.matches(for: pattern).count, 1)
    #warning("Disabled.")
    //XCTAssertNotNil(string.lastMatch(for: pattern))
  }

  func testNestingSegmentPattern() {
    let string = "...(...(...(...)...(...)...)...(...)...)..."
    let pattern = NestingPattern(opening: "(", closing: ")").contents.segmentPattern
    XCTAssertEqual(
      pattern.primaryMatch(in: string, at: string.dropFirst(4).startIndex)?.contents,
      string.dropFirst(4).prefix(3)
    )
    XCTAssertEqual(string.matches(for: pattern).count, 3)
    #warning("Disabled.")
    //XCTAssertNotNil(string.lastMatch(for: pattern))
    XCTAssertEqual(pattern.matches(in: string, at: string.dropFirst(4).startIndex).count, 1)
    XCTAssertEqual(pattern.matches(in: string, at: string.dropLast(4).endIndex).count, 0)
  }
}
