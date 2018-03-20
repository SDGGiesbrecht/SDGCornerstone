/*
 PointProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogicTestUtilities
import SDGPersistenceTestUtilities

/// Tests a type’s conformance to PointProtocol.
///
/// - Precondition: `departure` and `destination` are expected to be inequal.
@_inlineable public func testPointProtocolConformance<T>(departure: T, vector: T.Vector, destination: T, file: StaticString = #file, line: UInt = #line) where T : PointProtocol {

    testEquatableConformance(differingInstances: (departure, destination), file: file, line: line)
    testCodableConformance(of: departure, uniqueTestName: "PointProtocol")

    test(operator: (+, "+"), on: (departure, vector), returns: destination, file: file, line: line)
    test(assignmentOperator: (+=, "+="), with: (departure, vector), resultsIn: destination, file: file, line: line)
    test(operator: (−, "−"), on: (destination, vector), returns: departure, file: file, line: line)
    test(assignmentOperator: (−=, "−="), with: (destination, vector), resultsIn: departure, file: file, line: line)
    test(operator: (−, "−"), on: (destination, departure), returns: vector, file: file, line: line)
}
