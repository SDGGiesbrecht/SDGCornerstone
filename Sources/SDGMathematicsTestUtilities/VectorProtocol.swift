/*
 VectorProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGTesting

/// Tests a type’s conformance to VectorProtocol.
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
public func testVectorProtocolConformance<T>(
  augend: T,
  addend: T,
  sum: T,
  multiplicand: T,
  multiplier: T.Scalar,
  product: T,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: VectorProtocol, T: Hashable, T: Encodable, T: Decodable {

  testGenericAdditiveArithmeticConformance(
    augend: augend,
    addend: addend,
    sum: sum,
    file: file,
    line: line
  )

  test(operator: (×, "×"), on: (multiplicand, multiplier), returns: product, file: file, line: line)
  test(
    assignmentOperator: (×=, "×="),
    with: (multiplicand, multiplier),
    resultsIn: product,
    file: file,
    line: line
  )
}
