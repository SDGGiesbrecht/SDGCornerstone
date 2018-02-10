/*
 SDGLogicTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGLogicTestUtilities
import SDGXCTestUtilities

class SDGLogicTests : TestCase {

    func testAny() {
        XCTAssert(Bool.self ≠ Int.self, "“\(Bool.self)” ≠ “\(Int.self)” → “\(false)”")
    }

    func testBool() {
        var variable = true

        testEquatableConformance(differingInstances: (true, false))
        // [_Warning: Should test Comparable conformance too._]

        variable = true
        variable¬=
        XCTAssertFalse(variable, "“\(true)”¬= → “\(true)”")

        variable = true
        variable ∧= true
        XCTAssert(variable, "“\(true)” ∧= “\(true)” → “\(false)”")

        variable = true
        variable ∨= true
        XCTAssert(variable, "“\(true)” ∨= “\(true)” → “\(false)”")
    }

    func testEquatable() {
        XCTAssertFalse(true ≠ true, "“\(true)” ≠ “\(true)” → “\(true)”")

        XCTAssertFalse((true, true) ≠ (true, true), "“\((true, true))” ≠ “\((true, true))” → “\(true)”")
        XCTAssertFalse((true, true, true) ≠ (true, true, true), "“\((true, true, true))” ≠ “\((true, true, true))” → “\(true)”")
        XCTAssertFalse((true, true, true, true) ≠ (true, true, true, true), "“\((true, true, true, true))” ≠ “\((true, true, true, true))” → “\(true)”")
        XCTAssertFalse((true, true, true, true, true) ≠ (true, true, true, true, true), "“\((true, true, true, true, true))” ≠ “\((true, true, true, true, true))” → “\(true)”")
        XCTAssertFalse((true, true, true, true, true, true) ≠ (true, true, true, true, true, true), "“\((true, true, true, true, true, true))” ≠ “\((true, true, true, true, true, true))” → “\(true)”")

        XCTAssertFalse([true] ≠ [true], "“\([true])” ≠ “\([true])” → “\(true)”")
        XCTAssertFalse(ArraySlice([true]) ≠ ArraySlice([true]), "“\(ArraySlice([true]))” ≠ “\(ArraySlice([true]))” → “\(true)”")
        XCTAssertFalse(ContiguousArray([true]) ≠ ContiguousArray([true]), "“\(ContiguousArray([true]))” ≠ “\(ContiguousArray([true]))” → “\(true)”")

        XCTAssertFalse([true: true] ≠ [true: true], "“\([true: true])” ≠ “\([true:true])” → “\(true)”")

        enum Enumeration: Int {
            case one = 1
        }
        XCTAssertFalse(Enumeration.one ≠ Enumeration.one, "“\(Enumeration.one)” ≠ “\(Enumeration.one)” → “\(true)”")

        struct Structure: RawRepresentable {
            var rawValue: Int = 1
        }
        XCTAssertFalse(Structure() ≠ Structure(), "“\(Structure())” ≠ “\(Structure())” → “\(true)”")
    }

    func testOptional() {
        let optional: Bool? = true
        XCTAssert(optional ≠ nil, "“\(String(describing: optional))” ≠ nil → “\(false)”")
    }

    static var allTests: [(String, (SDGLogicTests) -> () throws -> Void)] {
        return [
            ("testAny", testAny),
            ("testBool", testBool),
            ("testEquatable", testEquatable),
            ("testOptional", testOptional)
        ]
    }
}
