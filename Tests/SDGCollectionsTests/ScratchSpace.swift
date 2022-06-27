#warning("Removed this file.")

import SDGCollections

import XCTest

final class ScratchSpaceTests: XCTestCase {

  func testPatternMatches() {
    let string = "Hello!"
    let matches = string.matches(in: string, at: string.startIndex)
    XCTAssert(matches.first?.contents.elementsEqual(string) == true)
  }

  func testSearchableCollectionFirstMatch() {
    let pattern = "!"
    let firstMatch = "Hello!".firstMatch(for: pattern)
    XCTAssert(firstMatch?.contents.elementsEqual(pattern) == true)
  }
}
