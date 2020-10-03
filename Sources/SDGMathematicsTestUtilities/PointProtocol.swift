/*
 PointProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGTesting
import SDGLogicTestUtilities
import SDGPersistenceTestUtilities

/// Tests a type’s conformance to PointProtocol.
///
/// - Precondition: `departure` and `destination` are expected to be inequal.
///
/// - Parameters:
///     - departure: A point of departure.
///     - vector: A vector.
///     - destination: The expected point of arrival.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testPointProtocolConformance<T>(
  departure: T,
  vector: T.Vector,
  destination: T,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: PointProtocol {

  testEquatableConformance(differingInstances: (departure, destination), file: file, line: line)
  testCodableConformance(of: departure, uniqueTestName: "PointProtocol", file: file, line: line)

  test(operator: (+, "+"), on: (departure, vector), returns: destination, file: file, line: line)
  test(
    assignmentOperator: (+=, "+="),
    with: (departure, vector),
    resultsIn: destination,
    file: file,
    line: line
  )
  test(operator: (−, "−"), on: (destination, vector), returns: departure, file: file, line: line)
  test(
    assignmentOperator: (−=, "−="),
    with: (destination, vector),
    resultsIn: departure,
    file: file,
    line: line
  )
  test(operator: (−, "−"), on: (destination, departure), returns: vector, file: file, line: line)
}
