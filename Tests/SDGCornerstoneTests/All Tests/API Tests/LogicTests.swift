/*
 LogicTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import SDGCornerstone

class LogicTests : TestCase {

    func testBool() {
        for boolean in [true, false] {
            XCTAssertNotEqual(boolean.checkOrX(), "")
            XCTAssertNotEqual(boolean.trueOrFalse(.sentenceMedial), "")
            XCTAssertNotEqual(boolean.yesOrNo(.sentenceMedial), "")
            XCTAssertNotEqual(boolean.wahrOderFalsch(.sentenceMedial), "")
            XCTAssertNotEqual(boolean.jaOderNein(.sentenceMedial), "")
            XCTAssertNotEqual(boolean.vraiOuFaux(.sentenceMedial), "")
            XCTAssertNotEqual(boolean.ouiOuNon(.sentenceMedial), "")
            XCTAssertNotEqual(boolean.αληθήςΉΨευδής(.sentenceMedial), "")
            XCTAssertNotEqual(boolean.ναιΉΌχι(.sentenceMedial), "")
            XCTAssertNotEqual(boolean.חיובי־או־שלילי(), "")
            XCTAssertNotEqual(boolean.כן־או־לא(), "")
        }
        XCTAssertEqual(true.trueOrFalse(.titleInitial), "True")
        XCTAssertEqual(false.ναιΉΌχι(.sentenceInitial), "Όχι")
    }

    static var allTests: [(String, (LogicTests) -> () throws -> Void)] {
        return [
            ("testBool", testBool)
        ]
    }
}
