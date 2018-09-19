/*
 Negatable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to Negatable.
@inlinable public func testNegatableConformance<T>(minuend: T, subtrahend: T, difference: T, file: StaticString = #file, line: UInt = #line) where T : Negatable {

    testAddableConformance(augend: difference, addend: subtrahend, sum: minuend, file: file, line: line)

    test(prefixOperator: (−, "−"), on: subtrahend, returns: difference − minuend, file: file, line: line)
    test(postfixAssignmentOperator: (−=, "−="), with: subtrahend, resultsIn: difference − minuend, file: file, line: line)
}
