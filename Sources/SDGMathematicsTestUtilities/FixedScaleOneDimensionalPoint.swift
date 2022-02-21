/*
 FixedScaleOneDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// Tests a type’s conformance to FixedScaleOneDimensionalPoint.
///
/// - Precondition: `departure` is expected to be less than `destination`.
///
/// - Parameters:
///     - departure: A point of departure.
///     - vector: A vector.
///     - destination: The expected point of arrival.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testFixedScaleOneDimensionalPointConformance<T>(
  departure: T,
  vector: T.Vector,
  destination: T,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: OneDimensionalPoint & _ComparableIfNotInherited {
  testOneDimensionalPointConformance(
    departure: departure,
    vector: vector,
    destination: destination,
    file: file,
    line: line
  )
}
