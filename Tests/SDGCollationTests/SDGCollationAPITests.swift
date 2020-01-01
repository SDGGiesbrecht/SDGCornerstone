/*
 SDGCollationAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGCollation

import XCTest

import SDGXCTestUtilities

class SDGCollationAPITests: TestCase {

  var strictStringSortAlgorithm: ((StrictString, StrictString) -> Bool)?

  override func setUp() {
    super.setUp()
    XCTAssert(StrictString("a") < StrictString("b"))
    strictStringSortAlgorithm = StrictString.sortAlgorithm
    StrictString.sortAlgorithm = { CollationOrder.root.stringsAreOrderedAscending($0, $1) }
  }

  override func tearDown() {
    super.tearDown()
    StrictString.sortAlgorithm = strictStringSortAlgorithm!
  }

  func testCoding() throws {
    let encoded = CollationOrder.root.file
    _ = try CollationOrder(file: encoded, origin: nil)
  }

  func testCollationOrder() {
    XCTAssert(CollationOrder.root.stringsAreOrderedAscending("A", "B"))

    let testCollation = CollationOrder.root.tailored {

      "β" ←< "γ"
      "̂" ←<< "̧"
      "̈" ←<<< "̃"
      "β" ←<<<< "β̄"
      "‐" ←<<<<< "."
      "β" ←<<<<<< "ɓ"
      "β" ←= "β̱"

      "α" <→ "β"
      "̀" <<→ "̂"
      "́" <<<→ "̈"
      "β̇" <<<<→ "β"
      " " <<<<<→ "‐"
      /*a*/"ב" <<<<<<→ "β"
      "β̣" =→ "β"
    }

    XCTAssert(testCollation.stringsAreOrderedAscending("β", "γ"))
    XCTAssert(testCollation.stringsAreOrderedAscending("̂", "̧"))
    XCTAssert(testCollation.stringsAreOrderedAscending("̈", "̃"))
    XCTAssert(testCollation.stringsAreOrderedAscending("β", "β̄"))
    XCTAssert(testCollation.stringsAreOrderedAscending("‐", "."))
    XCTAssert(testCollation.stringsAreOrderedAscending("β", "ɓ"))
    XCTAssert(testCollation.stringsAreOrderedAscending("β", "β̱"))

    XCTAssert(testCollation.stringsAreOrderedAscending("α", "β"))
    XCTAssert(testCollation.stringsAreOrderedAscending("̀", "̂"))
    XCTAssert(testCollation.stringsAreOrderedAscending("́", "̈"))
    XCTAssert(testCollation.stringsAreOrderedAscending("β̇", "β"))
    XCTAssert(testCollation.stringsAreOrderedAscending(" ", "‐"))
    XCTAssert(testCollation.stringsAreOrderedAscending("ב", "β"))
    XCTAssert(testCollation.stringsAreOrderedAscending("β", "β̣"))

    XCTAssert(testCollation.collate(["γ", "α", "β"]) == ["α", "β", "γ"])

    XCTAssert(testCollation.stringsAreOrderedAscending("\u{FAFE}", "\u{FAFF}"))
    XCTAssert(testCollation.stringsAreOrderedAscending("\u{2B820}", "\u{2B821}"))
    XCTAssert(testCollation.stringsAreOrderedAscending("\u{30000}", "\u{30001}"))

    XCTAssert(testCollation.stringsAreOrderedEqual("a", "a"))
  }

  func testInterspersion() {
    XCTAssert(StrictString("aa") < StrictString("αb"))
    XCTAssert(StrictString("αa") < StrictString("ab"))

    XCTAssert(StrictString("aa") < StrictString("אb"))
    XCTAssert(StrictString("אa") < StrictString("ab"))

    XCTAssert(StrictString("αa") < StrictString("אb"))
    XCTAssert(StrictString("אa") < StrictString("αb"))
  }
}
