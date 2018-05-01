/*
 SDGLogicAPITests.swift

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

import SDGMathematicsTestUtilities

class SDGLogicAPITests : TestCase {

    func testAny() {
        test(operator: (≠, "≠"), on: (Bool.self, Int.self), returns: true)
    }

    func testBool() {
        testEquatableConformance(differingInstances: (true, false))
        testComparableConformance(less: false, greater: true)

        test(prefixOperator: (¬, "¬"), on: true, returns: false)
        test(postfixAssignmentOperator: (¬=, "¬="), with: false, resultsIn: true)
        test(operator: (∧, "∧"), on: true, true, returns: true)
        test(assignmentOperator: (∧=, "∧="), with: true, false, resultsIn: false)
        test(operator: (∨, "∨"), on: true, false, returns: true)
        test(assignmentOperator: (∨=, "∨="), with: false, false, resultsIn: false)
    }

    func testEquatable() {
        test(operator: (≠, "≠"), on: (true, true), returns: false)

        test(operator: (≠, "≠"), on: ((true, true), (true, true)), returns: false)
        test(operator: (≠, "≠"), on: ((true, true, true), (true, true, true)), returns: false)
        test(operator: (≠, "≠"), on: ((true, true, true, true), (true, true, true, true)), returns: false)
        test(operator: (≠, "≠"), on: ((true, true, true, true, true), (true, true, true, true, true)), returns: false)
        test(operator: (≠, "≠"), on: ((true, true, true, true, true, true), (true, true, true, true, true, true)), returns: false)

        test(operator: (≠, "≠"), on: ([true], [true]), returns: false)
        test(operator: (≠, "≠"), on: (ArraySlice([true]), ArraySlice([true])), returns: false)
        test(operator: (≠, "≠"), on: (ContiguousArray([true]), ContiguousArray([true])), returns: false)

        test(operator: (≠, "≠"), on: ([true: true], [true: true]), returns: false)

        enum Enumeration : Int { // swiftlint:disable:this nesting
            case one = 1
        }
        test(operator: (≠, "≠"), on: (Enumeration.one, .one), returns: false)
    }

    func testOptional() {
        let optional: Bool? = true
        test(operator: (≠, "≠"), on: (optional, nil), returns: true)
        if optional ≠ nil {
            // Ensures syntax works.
        }

        struct Thing {} // Not equatable. // swiftlint:disable:this nesting
        let thing: Thing? = Thing()
        if thing ≠ nil {
            // Ensures syntax works.
        }
    }
}
