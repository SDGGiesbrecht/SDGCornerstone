/*
 TwoDimensionalVectorProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGGeometry

import SDGTesting
import SDGMathematicsTestUtilities

/// Tests a type’s conformance to TwoDimensionalVectorProtocol.
///
/// - Parameters:
///   - type: The type.
///   - file: Optional. A different source file to associate with any failures.
///   - line: Optional. A different line to associate with any failures.
public func testTwoDimensionalVectorProtocolConformance<T>(
  _ type: T.Type,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: TwoDimensionalVectorProtocol {

  testVectorProtocolConformance(
    augend: T(Δx: 1, Δy: 2),
    addend: T(Δx: 3, Δy: 4),
    sum: T(Δx: 4, Δy: 6),
    multiplicand: T(Δx: 5, Δy: 6),
    multiplier: 7,
    product: T(Δx: 35, Δy: 42),
    file: file,
    line: line
  )

  test(variable: (T.zero, "\(T.self).zero"), is: T(Δx: 0, Δy: 0), file: file, line: line)
}
