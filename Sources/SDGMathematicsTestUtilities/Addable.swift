/*
 Addable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to Addable.
///
/// - Parameters:
///     - augend: An augend.
///     - addend: An addend.
///     - sum: The expected sum.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testAddableConformance<T>(augend: T, addend: T, sum: T, file: StaticString = #file, line: UInt = #line) where T : Addable, T : Equatable {
    test(operator: (+, "+"), on: (augend, addend), returns: sum, file: file, line: line)
    test(assignmentOperator: (+=, "+="), with: (augend, addend), resultsIn: sum, file: file, line: line)
}
