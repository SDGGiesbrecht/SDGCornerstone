/*
 GenericAdditiveArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGTesting
import SDGCollectionsTestUtilities
import SDGPersistenceTestUtilities

/// Tests a type’s conformance to GenericAdditiveArithmetic.
///
/// - Parameters:
///     - augend: An augend.
///     - addend: An addend.
///     - sum: The expected sum.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testGenericAdditiveArithmeticConformance<T>(
  augend: T,
  addend: T,
  sum: T,
  file: StaticString = #file,
  line: UInt = #line
) where T: GenericAdditiveArithmetic {
  testHashableConformance(differingInstances: (augend, sum), file: file, line: line)
  testSubtractableConformance(
    minuend: sum,
    subtrahend: addend,
    difference: augend,
    file: file,
    line: line
  )
  testCodableConformance(of: augend, uniqueTestName: "AdditiveArithmetic", file: file, line: line)

  test(operator: (+, "+"), on: (sum, T.zero), returns: sum, file: file, line: line)
  test(operator: (-, "-"), on: (sum, T.zero), returns: sum, file: file, line: line)  // @exempt(from: unicode)
  test(assignmentOperator: (-=, "-="), with: (sum, T.zero), resultsIn: sum, file: file, line: line)  // @exempt(from: unicode)
}
