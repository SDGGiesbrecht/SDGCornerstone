/*
 SDGCollationAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGCollation

import XCTest

import SDGXCTestUtilities

class SDGCollationAPITests : TestCase {

    override func setUp() {
        super.setUp()
        StrictString.sortAlgorithm = { CollationOrder.root.stringsAreOrderedAscending($0, $1) }
    }

    override func tearDown() {
        super.tearDown()
        StrictString.sortAlgorithm = { String($0) < String($1) }
    }

    func testCoding() {
        let encoded = CollationOrder.root.file
        let decoded = try CollationOrder(file: encoded, origin: nil)
        XCTAssertEqual(decoded, CollationOrder.root)
    }

    func testCollationOrder() {
        XCTAssert(CollationOrder.root.stringsAreOrderedAscending("A", "B"))

        let testCollation = CollationOrder.root.tailored {

            *"β" ←< "γ"
            *"̂" ←<< "̧"
            *"̈" ←<<< "̃"
            *"β" ←<<<< "β̄"
            *"‐" ←<<<<< "."
            *"β" ←<<<<<< "ɓ"
            *"β" ←= "β̱"

            "α" <→ *"β"
            "̀" <<→ *"̂"
            "́" <<<→ *"̈"
            "β̇" <<<<→ *"β"
            " " <<<<<→ *"‐"
            /*a*/ "ב" <<<<<<→ *"β"
            "β̣" =→ *"β"
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
