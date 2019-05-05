/*
 TwoDimensionalVectorProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGGeometry

import SDGLogicTestUtilities
import SDGMathematicsTestUtilities
import SDGCollectionTestUtilities
import SDGPersistenceTestUtilities

/// Tests a type’s conformance to TwoDimensionalVectorProtocol.
///
/// - Parameters:
///     - type: The type.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func testTwoDimensionalVectorConformance<T>(
    augend: T.Type,
    file: StaticString = #file,
    line: UInt = #line) where T : TwoDimensionalVectorProtocol {

    testHashableConformance(differingInstances: (augend, sum), file: file, line: line)
    testSubtractableConformance(minuend: sum, subtrahend: addend, difference: augend, file: file, line: line)
    testCodableConformance(of: augend, uniqueTestName: "AdditiveArithmetic", file: file, line: line)

    test(operator: (+, "+"), on: (sum, T.zero), returns: sum, file: file, line: line)
    test(operator: (-, "-"), on: (sum, T.zero), returns: sum, file: file, line: line) // @exempt(from: unicode)
    test(assignmentOperator: (-=, "-="), with: (sum, T.zero), resultsIn: sum, file: file, line: line) // @exempt(from: unicode)
}
