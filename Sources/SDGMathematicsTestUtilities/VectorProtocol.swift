/*
 VectorProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to VectorProtocol.
@inlinable public func testVectorProtocolConformance<T>(augend: T, addend: T, sum: T, multiplicand: T, multiplier: T.Scalar, product: T, file: StaticString = #file, line: UInt = #line) where T : VectorProtocol {

    testAdditiveArithmeticConformance(augend: augend, addend: addend, sum: sum, file: file, line: line)

    test(operator: (×, "×"), on: (multiplicand, multiplier), returns: product, file: file, line: line)
    test(assignmentOperator: (×=, "×="), with: (multiplicand, multiplier), resultsIn: product, file: file, line: line)

    test(operator: (÷, "÷"), on: (product, multiplier), returns: multiplicand, file: file, line: line)
    test(assignmentOperator: (÷=, "÷="), with: (product, multiplier), resultsIn: multiplicand, file: file, line: line)
}
