/*
 LogicTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import SDGCornerstone

class LogicTests : TestCase {

    func testBool() {
        var variable = false

        XCTAssertFalse(true ≠ true)
        XCTAssertFalse(false ≠ false)
        XCTAssert(true ≠ false)
        XCTAssert(false ≠ true)

        XCTAssertEqual(¬true, false)
        XCTAssertEqual(¬false, true)
        variable = false
        variable¬=
        XCTAssertEqual(variable, true)

        XCTAssert(true ∧ true)
        XCTAssertFalse(false ∧ false)
        XCTAssertFalse(true ∧ false)
        XCTAssertFalse(false ∧ true)
        variable = true
        variable ∧= false
        XCTAssertEqual(variable, false)

        XCTAssert(true ∨ true)
        XCTAssertFalse(false ∨ false)
        XCTAssert(true ∨ false)
        XCTAssert(false ∨ true)
        variable = false
        variable ∨= true
        XCTAssertEqual(variable, true)

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

    func testAny() {
        XCTAssertFalse(Bool.self ≠ Bool.self)
        XCTAssert(Bool.self ≠ Int.self)
    }

    func testOptional() {
        let a: Bool? = true
        let b: Bool? = nil

        XCTAssertFalse(a ≠ a)
        XCTAssert(a ≠ b)
        XCTAssert(a ≠ false)
        XCTAssertFalse(b ≠ b)

        XCTAssertFalse(b ≠ nil)
        XCTAssert(a ≠ nil)

        let c: TypeExample? = TypeExample()
        let d: TypeExample? = nil

        XCTAssert(c ≠ nil)
        XCTAssertFalse(d ≠ nil)
    }

    func testTuple() {
        XCTAssertFalse((true, true) ≠ (true, true))
        XCTAssert((true, true) ≠ (true, false))

        XCTAssertFalse((true, true, true) ≠ (true, true, true))
        XCTAssert((true, true, true) ≠ (true, true, false))

        XCTAssertFalse((true, true, true, true) ≠ (true, true, true, true))
        XCTAssert((true, true, true, true) ≠ (true, true, true, false))

        XCTAssertFalse((true, true, true, true, true) ≠ (true, true, true, true, true))
        XCTAssert((true, true, true, true, true) ≠ (true, true, true, true, false))

        XCTAssertFalse((true, true, true, true, true, true) ≠ (true, true, true, true, true, true))
        XCTAssert((true, true, true, true, true, true) ≠ (true, true, true, true, true, false))
    }

    func testRawRepresentable() {
        let rawTrue = RawRepresentableExample(rawValue: true)
        let rawFalse = RawRepresentableExample(rawValue: false)

        XCTAssertFalse(rawTrue ≠ rawTrue)
        XCTAssertFalse(rawFalse ≠ rawFalse)
        XCTAssert(rawTrue ≠ rawFalse)
        XCTAssert(rawFalse ≠ rawTrue)

        let equatableTrue = EquatableRawRepresentableExample(rawValue: true)
        let equatableFalse = EquatableRawRepresentableExample(rawValue: false)

        XCTAssertFalse(equatableTrue ≠ equatableTrue)
        XCTAssertFalse(equatableFalse ≠ equatableFalse)
        XCTAssert(equatableTrue ≠ equatableFalse)
        XCTAssert(equatableFalse ≠ equatableTrue)
    }

    static var allTests: [(String, (LogicTests) -> () throws -> Void)] {
        return [
            ("testBool", testBool),
            ("testAny", testAny),
            ("testOptional", testOptional),
            ("testTuple", testTuple),
            ("testRawRepresentable", testRawRepresentable)
        ]
    }
}
