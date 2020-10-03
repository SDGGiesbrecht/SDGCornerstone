/*
 Measurement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGTesting

/// Tests a type’s conformance to Measurement.
///
/// - Parameters:
///     - type: The type to test.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testMeasurementConformance<T>(
  of type: T.Type,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: Measurement {

  testNumericAdditiveArithmeticConformance(
    augend: T(rawValue: 3),
    addend: T(rawValue: 5),
    sum: T(rawValue: 8),
    includingNegatives: true,
    file: file,
    line: line
  )
  testNegatableConformance(
    minuend: T(rawValue: 8),
    subtrahend: T(rawValue: 5),
    difference: T(rawValue: 3),
    file: file,
    line: line
  )

  test(property: ({ $0.rawValue }, "rawValue"), of: T(), is: 0)

  test(
    operator: (×, "×"),
    on: (T(rawValue: 42), 3),
    returns: T(rawValue: 126),
    file: file,
    line: line
  )
  test(
    assignmentOperator: (×=, "×="),
    with: (T(rawValue: 4), 4),
    resultsIn: T(rawValue: 16),
    file: file,
    line: line
  )

  test(
    operator: (÷, "÷"),
    on: (T(rawValue: 55), 11),
    returns: T(rawValue: 5),
    file: file,
    line: line
  )
  test(
    operator: (÷, "÷"),
    on: (T(rawValue: 55), T(rawValue: 11)),
    returns: 5,
    file: file,
    line: line
  )
  test(
    assignmentOperator: (÷=, "÷="),
    with: (T(rawValue: 76), 4),
    resultsIn: T(rawValue: 19),
    file: file,
    line: line
  )

  test(
    method: (T.dividedAccordingToEuclid, "dividedAccordingToEuclid"),
    of: T(rawValue: 5),
    with: T(rawValue: 3),
    returns: 1,
    file: file,
    line: line
  )

  test(
    method: (T.mod, "mod"),
    of: T(rawValue: 86),
    with: T(rawValue: 18),
    returns: T(rawValue: 14),
    file: file,
    line: line
  )
  test(
    mutatingMethod: ({ $0.formRemainder(mod: $1) }, "formRemainder"),
    of: T(rawValue: 32),
    with: T(rawValue: 2),
    resultsIn: T(rawValue: 0),
    file: file,
    line: line
  )

  test(
    method: (T.isDivisible, "isDivisible"),
    of: T(rawValue: 64),
    with: T(rawValue: 4),
    returns: true,
    file: file,
    line: line
  )

  test(
    function: (gcd, "gcd"),
    on: (T(rawValue: 32), T(rawValue: 80)),
    returns: T(rawValue: 16),
    file: file,
    line: line
  )
  test(
    mutatingMethod: ({ $0.formGreatestCommonDivisor(with: $1) }, "formGreatestCommonDivisor"),
    of: T(rawValue: 60),
    with: T(rawValue: 10),
    resultsIn: T(rawValue: 10),
    file: file,
    line: line
  )

  test(
    function: (lcm, "lcm"),
    on: (T(rawValue: 5), T(rawValue: 3)),
    returns: T(rawValue: 15),
    file: file,
    line: line
  )
  test(
    mutatingMethod: ({ $0.formLeastCommonMultiple(with: $1) }, "formLeastCommonMultiple"),
    of: T(rawValue: 4),
    with: T(rawValue: 30),
    resultsIn: T(rawValue: 60),
    file: file,
    line: line
  )

  test(
    mutatingMethod: ({ $0.round($1, toMultipleOf: $2) }, "round"),
    of: T(rawValue: 52),
    with: (.toNearestOrAwayFromZero, T(rawValue: 39)),
    resultsIn: T(rawValue: 39),
    file: file,
    line: line
  )
  test(
    method: (T.rounded, "rounded"),
    of: T(rawValue: 99),
    with: (.toNearestOrAwayFromZero, T(rawValue: 10)),
    returns: T(rawValue: 100),
    file: file,
    line: line
  )
}
