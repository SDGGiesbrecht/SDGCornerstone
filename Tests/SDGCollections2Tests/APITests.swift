/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections2

import XCTest

final class APITests: XCTestCase {

  func testAtomicPatternMatch() {
    let string = "Hello!"
    let match = AtomicPatternMatch(range: string.bounds, in: string)
    XCTAssertEqual(match.contents, string[...])
    XCTAssertEqual(match.range, string.bounds)
    XCTAssertEqual(match.contents, match.in(string[...]).contents)
  }

  func testBidirectionalPattern() {
    let string = "Hello!"
    let reversedPattern: String.Reversed = string.reversed()
    let reversedSearchSpace: ReversedCollection<String> = string.reversed()
    guard let reversedMatch = reversedSearchSpace.firstMatch(for: reversedPattern) else {
      XCTFail("Failed to match.")
      return
    }
    let forwardRange = string.forward(reversedMatch.range)
    XCTAssertEqual(forwardRange, string.bounds)
    let forwardMatch = string.forward(match: reversedMatch, in: string)
    XCTAssertEqual(forwardMatch.contents, string[...])
  }

  func testPattern() {
    let string = "Hello!"
    let match = string.primaryMatch(in: string, at: string.startIndex)
    XCTAssertEqual(match?.contents, string[...])
    let matchesAtStart = string.matches(in: string, at: string.startIndex)
    XCTAssertEqual(matchesAtStart.count, 1)
    let matchesInMiddle = string.matches(in: string, at: string.index(after: string.startIndex))
    XCTAssertEqual(matchesInMiddle.count, 0)

    let incomplete = "H"
    XCTAssertNil(string.primaryMatch(in: incomplete, at: incomplete.startIndex))

    let mismatched = "Bonjour !"
    XCTAssertNil(string.primaryMatch(in: mismatched, at: mismatched.startIndex))

    XCTAssertNil(Nothing().primaryMatch(in: string, at: string.startIndex))
  }

  func testReversedCollection() {
    let string = "Hello!"
    let reversed: ReversedCollection<String> = string.reversed()
    XCTAssertEqual(
      (reversed.firstMatch(for: reversed)?.contents).map({ Array($0) }),
      Array(reversed)
    )
    XCTAssertEqual(reversed.matches(for: reversed).count, 1)
    XCTAssertEqual(reversed[...].matches(for: reversed[...]).count, 1)
  }

  func testSearchableBidirectionalCollection() {
    let string = "Hello!"
    let reverseMatch = string.lastMatch(for: string)
    XCTAssertEqual(reverseMatch?.contents, string[...])

    let mismatched = "Bonjour !"
    XCTAssertNil(string.lastMatch(for: mismatched))
  }

  func testSearchableCollection() {
    let string = "Hello!"
    let subMatch = string.forSubSequence().primaryMatch(in: string[...], at: string.startIndex)
    let match = subMatch.map { string.convertMatch(from: $0, in: string) }
    XCTAssertEqual(match?.contents, string[...])

    XCTAssertEqual(string.firstMatch(for: "e")?.contents, "e"[...])
    XCTAssertNil(string.firstMatch(for: Nothing()))

    XCTAssertEqual(string.matches(for: "l").count, 2)
    XCTAssertEqual(string.matches(for: Nothing()).count, 0)
  }

  func testSlice() {
    let string = "Hello!"
    let slice = Slice(base: "Hello!", bounds: string.dropLast().bounds)
    XCTAssertEqual((slice.firstMatch(for: slice)?.contents).map({ Array($0) }), Array(slice))
    XCTAssertEqual(slice[...].matches(for: slice[...]).count, 1)
  }

  func testString() {
    let string = "Hello!"
    XCTAssertEqual(string[...].matches(for: "l"[...]).count, 2)
    XCTAssertEqual(string.unicodeScalars.matches(for: "l".unicodeScalars).count, 2)
    XCTAssertEqual(string.unicodeScalars[...].matches(for: "l".unicodeScalars[...]).count, 2)
    XCTAssertEqual(string.utf8.matches(for: "l".utf8).count, 2)
    XCTAssertEqual(string.utf8[...].matches(for: "l".utf8[...]).count, 2)
    XCTAssertEqual(string.utf16.matches(for: "l".utf16).count, 2)
    XCTAssertEqual(string.utf16[...].matches(for: "l".utf16[...]).count, 2)
  }
}
