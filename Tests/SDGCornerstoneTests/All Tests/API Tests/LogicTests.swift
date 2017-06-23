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

        XCTAssert(¬true == false)
        XCTAssert(¬false == true)
        variable = false
        variable¬=
        XCTAssert(variable == true)

        XCTAssert(true ∧ true)
        XCTAssertFalse(false ∧ false)
        XCTAssertFalse(true ∧ false)
        XCTAssertFalse(false ∧ true)
        variable = true
        variable ∧= false
        XCTAssert(variable == false)

        XCTAssert(true ∨ true)
        XCTAssertFalse(false ∨ false)
        XCTAssert(true ∨ false)
        XCTAssert(false ∨ true)
        variable = false
        variable ∨= true
        XCTAssert(variable == true)

        for boolean in [true, false] {
            XCTAssert(boolean.checkOrX() ≠ "")
            XCTAssert(boolean.trueOrFalse(.sentenceMedial) ≠ "")
            XCTAssert(boolean.yesOrNo(.sentenceMedial) ≠ "")
            XCTAssert(boolean.wahrOderFalsch(.sentenceMedial) ≠ "")
            XCTAssert(boolean.jaOderNein(.sentenceMedial) ≠ "")
            XCTAssert(boolean.vraiOuFaux(.sentenceMedial) ≠ "")
            XCTAssert(boolean.ouiOuNon(.sentenceMedial) ≠ "")
            XCTAssert(boolean.αληθήςΉΨευδής(.sentenceMedial) ≠ "")
            XCTAssert(boolean.ναιΉΌχι(.sentenceMedial) ≠ "")
            XCTAssert(boolean.חיובי־או־שלילי() ≠ "")
            XCTAssert(boolean.כן־או־לא() ≠ "")
        }
        XCTAssert(true.trueOrFalse(.titleInitial) == "True")
        XCTAssert(false.ναιΉΌχι(.sentenceInitial) == "Όχι")
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
