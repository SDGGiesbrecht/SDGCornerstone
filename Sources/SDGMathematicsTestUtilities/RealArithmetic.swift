/*
 RealArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGTesting

/// Tests a type’s conformance to RealArithmetic.
///
/// - Parameters:
///     - type: The type.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testRealArithmeticConformance<T>(
  of type: T.Type,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: FloatingPoint, T: RealArithmetic {

  testRationalArithmeticConformance(of: T.self, file: file, line: line)

  test(variable: (T.π, "\(T.self).π"), is: 3.141_59, file: file, line: line)
  test(variable: (T.τ, "\(T.self).τ"), is: 6.283_18, file: file, line: line)
  test(variable: (T.e, "\(T.self).e"), is: 2.718_28, file: file, line: line)

  test(operator: (↑, "↑"), on: (2 as T, −0.5), returns: 0.707_11, file: file, line: line)
  test(operator: (↑, "↑"), on: (−3 as T, 2), returns: 9, file: file, line: line)

  test(method: (T.root, "root"), of: 81 as T, with: 4, returns: 3, file: file, line: line)
  test(
    mutatingMethod: ({ $0.formRoot(ofDegree: $1) }, "formRoot"),
    of: 64 as T,
    with: 3,
    resultsIn: 4,
    file: file,
    line: line
  )

  test(prefixOperator: (√, "√"), on: 100 as T, returns: 10, file: file, line: line)
  test(postfixAssignmentOperator: (√=, "√="), with: 64, resultsIn: 8, file: file, line: line)

  test(function: (log, "log"), on: (2 as T, 8), returns: 3, file: file, line: line)
  test(function: (log, "log"), on: (2 as T, 1), returns: 0, file: file, line: line)
  test(function: (log, "log"), on: (8 as T, 8), returns: 1, file: file, line: line)
  test(
    mutatingMethod: ({ $0.formLogarithm(toBase: $1) }, "formLogarithm"),
    of: 81 as T,
    with: 3,
    resultsIn: 4,
    file: file,
    line: line
  )

  test(function: (log, "log"), on: 100 as T, returns: 2, file: file, line: line)
  test(
    mutatingMethod: ({ $0.formCommonLogarithm() }, "formCommonLogarithm"),
    of: 1000 as T,
    resultsIn: 3,
    file: file,
    line: line
  )

  test(function: (ln, "ln"), on: 714 as T, returns: 6.570_88, file: file, line: line)
  test(
    mutatingMethod: ({ $0.formNaturalLogarithm() }, "formNaturalLogarithm"),
    of: 342 as T,
    resultsIn: 5.834_81,
    file: file,
    line: line
  )

  test(function: (sin, "sin"), on: (171 as T).rad, returns: 0.976_59, file: file, line: line)
  test(function: (cos, "cos"), on: (401 as T).rad, returns: 0.432_21, file: file, line: line)
  test(function: (cos, "cos"), on: (−T.π).rad, returns: −1, file: file, line: line)
  test(function: (tan, "tan"), on: (5 as T).rad, returns: −3.380_52, file: file, line: line)
  test(function: (sec, "sec"), on: (2 as T).rad, returns: −2.403_00, file: file, line: line)
  test(function: (csc, "csc"), on: (1 as T).rad, returns: 1.188_39, file: file, line: line)
  test(function: (cot, "cot"), on: (3 as T).rad, returns: −7.015_26, file: file, line: line)

  test(
    function: (arcsin, "arcsin"),
    on: 1 ÷ 6,
    returns: (0.167_44 as T).rad,
    file: file,
    line: line
  )
  test(
    function: (arccos, "arccos"),
    on: 1 ÷ 7,
    returns: (1.427_44 as T).rad,
    file: file,
    line: line
  )
  test(
    function: (arctan, "arctan"),
    on: 1 ÷ 2,
    returns: (0.463_64 as T).rad,
    file: file,
    line: line
  )
  test(function: (arctan, "arctan"), on: 2, returns: (1.107_14 as T).rad, file: file, line: line)
  test(
    function: (arcsec, "arcsec"),
    on: 1 × 4,
    returns: (1.318_11 as T).rad,
    file: file,
    line: line
  )
  test(
    function: (arccsc, "arccsc"),
    on: 1 × 3,
    returns: (0.339_83 as T).rad,
    file: file,
    line: line
  )
  test(
    function: (arccot, "arccot"),
    on: 1 × 5,
    returns: (0.197_39 as T).rad,
    file: file,
    line: line
  )
  test(function: (arccot, "arccot"), on: −2, returns: (2.677_94 as T).rad, file: file, line: line)

  _ = (7 as T).floatingPointApproximation
}
