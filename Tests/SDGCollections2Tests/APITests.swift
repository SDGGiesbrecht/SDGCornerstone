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

    struct NothingSubPattern: SDGCollections2.Pattern {
      func matches(
        in collection: Substring,
        at location: Substring.Index
      ) -> [AtomicPatternMatch<Substring>] {
        return []
      }
      func forSubSequence() -> NothingSubPattern {
        return self
      }
      func convertMatch(
        from subSequenceMatch: AtomicPatternMatch<Substring>,
        in collection: Substring
      ) -> AtomicPatternMatch<Substring> {
        return AtomicPatternMatch(range: subSequenceMatch.range, in: collection)
      }
    }
    struct Nothing: SDGCollections2.Pattern {
      func matches(
        in collection: String,
        at location: String.Index
      ) -> [AtomicPatternMatch<String>] {
        return []
      }
      func forSubSequence() -> NothingSubPattern {
        return NothingSubPattern()
      }
      func convertMatch(
        from subSequenceMatch: AtomicPatternMatch<Substring>,
        in collection: String
      ) -> AtomicPatternMatch<String> {
        return AtomicPatternMatch(range: subSequenceMatch.range, in: collection)
      }
    }
    XCTAssertNil(Nothing().primaryMatch(in: string, at: string.startIndex))
  }

  func testSearchableCollection() {
    let string = "Hello!"
    let subMatch = string.forSubSequence().primaryMatch(in: string[...], at: string.startIndex)
    let match = subMatch.map { string.convertMatch(from: $0, in: string) }
    XCTAssertEqual(match?.contents, string[...])
  }
}
