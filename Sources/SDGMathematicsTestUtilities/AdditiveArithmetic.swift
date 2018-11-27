/*
 AdditiveArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollectionsTestUtilities
import SDGPersistenceTestUtilities

/// Tests a type’s conformance to AdditiveArithmetic.
@inlinable public func testAdditiveArithmeticConformance<T>(augend: T, addend: T, sum: T, file: StaticString = #file, line: UInt = #line) where T : AdditiveArithmetic {
    testHashableConformance(differingInstances: (augend, sum), file: file, line: line)
    testSubtractableConformance(minuend: sum, subtrahend: addend, difference: augend, file: file, line: line)
    testCodableConformance(of: augend, uniqueTestName: "AdditiveArithmetic", file: file, line: line)

    test(operator: (+, "+"), on: (sum, T.additiveIdentity), returns: sum, file: file, line: line)
}
