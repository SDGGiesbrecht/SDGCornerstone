/*
 RationalArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCollections

import SDGTesting

/// Tests a type’s conformance to RationalArithmetic.
///
/// - Parameters:
///     - type: The type.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testRationalArithmeticConformance<T>(
  of type: T.Type,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: RationalArithmetic {

  testIntegralArithmeticConformance(of: T.self, file: file, line: line)

  let converted = T(FloatMax(0.875))
  test(
    converted == 0.875,
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(T.self)(FloatMax(0.875)) → \(converted) ≠ 0.875"

    }(),
    file: file,
    line: line
  )

  test(operator: (÷, "÷"), on: (55 as T, 11), returns: 5, file: file, line: line)
  test(assignmentOperator: (÷=, "÷="), with: (76 as T, 4), resultsIn: 19, file: file, line: line)

  test(operator: (↑, "↑"), on: (0.5 as T, −2), returns: 4, file: file, line: line)

  let range: Range<T> = −5..<5
  let result = T.random(in: range)
  test(
    result ∈ range,
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(T.self).random(in: \(range)) → \(result) ∉ \(range)"

    }(),
    file: file,
    line: line
  )
}
