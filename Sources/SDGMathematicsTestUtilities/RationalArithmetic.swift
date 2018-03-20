/*
 RationalArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to RationalArithmetic.
@_inlineable public func testRationalArithmeticConformance<T>(of type: T.Type, file: StaticString = #file, line: UInt = #line) where T : RationalArithmetic {

    testIntegralArithmeticConformance(of: T.self, file: file, line: line)

    let converted = T(FloatMax(0.875))
    test(converted == 0.875, "\(T.self)(FloatMax(0.875)) → \(converted) ≠ 0.875", file: file, line: line)

    test(operator: (÷, "÷"), on: (55 as T, 11), returns: 5, file: file, line: line)
    test(assignmentOperator: (÷=, "÷="), with: (76 as T, 4), resultsIn: 19, file: file, line: line)
}
