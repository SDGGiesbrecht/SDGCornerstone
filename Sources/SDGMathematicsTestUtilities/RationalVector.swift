/*
 RationalVector.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to RationalVector.
///
/// - Parameters:
///     - augend: An augend.
///     - addend: An addend.
///     - sum: The expected sum.
///     - multiplicand: A multiplicand.
///     - multiplier: A multiplier.
///     - product: The expected product.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testRationalVectorConformance<T>(
    augend: T,
    addend: T,
    sum: T,
    multiplicand: T,
    multiplier: T.Scalar,
    product: T,
    file: StaticString = #file,
    line: UInt = #line) where T : RationalVector {

    testVectorProtocolConformance(
        augend: augend,
        addend: addend,
        sum: sum,
        multiplicand: multiplicand,
        multiplier: multiplier,
        product: product,
        file: file,
        line: line)

    test(operator: (÷, "÷"), on: (product, multiplier), returns: multiplicand, file: file, line: line)
    test(assignmentOperator: (÷=, "÷="), with: (product, multiplier), resultsIn: multiplicand, file: file, line: line)
}
