/*
 TwoDimensionalPointProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGGeometry

import SDGMathematicsTestUtilities

/// Tests a type’s conformance to TwoDimensionalPointProtocol.
///
/// - Parameters:
///   - type: The type.
///   - file: Optional. A different source file to associate with any failures.
///   - line: Optional. A different line to associate with any failures.
public func testTwoDimensionalPointProtocolConformance<T>(
  _ type: T.Type,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: TwoDimensionalPointProtocol {

  testPointProtocolConformance(
    departure: T(1, 2),
    vector: T.Vector(Δx: 3, Δy: 4),
    destination: T(4, 6),
    file: file,
    line: line
  )
}
