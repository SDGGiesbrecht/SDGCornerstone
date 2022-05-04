/*
 IntegralArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGTesting

/// Tests a type’s conformance to IntegralArithmetic.
///
/// - Parameters:
///     - type: The type to test.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testIntegralArithmeticConformance<T>(
  of type: T.Type,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: IntegralArithmetic & _WholeArithmeticRandomness {

  testNegatableConformance(minuend: 61 as T, subtrahend: 23, difference: 38, file: file, line: line)
  testWholeArithmeticConformance(of: T.self, includingNegatives: true, file: file, line: line)
  test(
    prefixOperator: (-, "-"),  // @exempt(from: unicode)
    on: 9 as T,
    returns: −9,
    file: file,
    line: line
  )
  test(
    mutatingMethod: ({ $0.negate() }, "negate"),
    of: −5 as T,
    resultsIn: 5,
    file: file,
    line: line
  )

  // Comparable (extended)
  test(operator: (<, "<"), on: (−2 as T, −1), returns: true, file: file, line: line)
  test(operator: (<, "<"), on: (−1 as T, −2), returns: false, file: file, line: line)
  test(operator: (<, "<"), on: (−1 as T, −1), returns: false, file: file, line: line)
  // WholeArithmetic (extended)
  test(
    method: (T.dividedAccordingToEuclid, "dividedAccordingToEuclid"),
    of: −1 as T,
    with: −1,
    returns: 1,
    file: file,
    line: line
  )

  let converted = T(IntMax(10))
  test(converted == 10, "\(T.self)(IntMax(10)) → \(converted) ≠ 10", file: file, line: line)
}
