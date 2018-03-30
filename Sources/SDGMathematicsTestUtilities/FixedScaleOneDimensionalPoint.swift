/*
 FixedScaleOneDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to FixedScaleOneDimensionalPoint.
///
/// - Precondition: `departure` is expected to be less than `destination`.
@_inlineable public func testFixedScaleOneDimensionalPointConformance<T>(departure: T, vector: T.Vector, destination: T, file: StaticString = #file, line: UInt = #line) where T : OneDimensionalPoint {
    testOneDimensionalPointConformance(departure: departure, vector: vector, destination: destination, file: file, line: line)
}
