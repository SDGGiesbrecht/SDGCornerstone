/*
 Subtractable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to Subtractable.
@inlinable public func testSubtractableConformance<T>(minuend: T, subtrahend: T, difference: T, file: StaticString = #file, line: UInt = #line) where T : Subtractable, T : Equatable {

    testAddableConformance(augend: difference, addend: subtrahend, sum: minuend, file: file, line: line)

    test(operator: (−, "−"), on: (minuend, subtrahend), returns: difference, file: file, line: line)
    test(assignmentOperator: (−=, "−="), with: (minuend, subtrahend), resultsIn: difference, file: file, line: line)
    test(operator: (±, "±"), on: (minuend, subtrahend), returns: (sum: minuend + subtrahend, difference: difference), file: file, line: line)
}
