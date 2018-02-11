/*
 IntegralArithmeticCore.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to IntegralArithmeticCore.
@_transparent public func testIntegralArithmeticCoreConformance<T>(of type: T.Type, file: StaticString = #file, line: UInt = #line) where T : IntegralArithmeticCore {

    testNegatableConformance(minuend: 61, subtrahend: 23, difference: 38, file: file, line: line)
    testWholeArithmeticCoreConformance(of: T.self, includingNegatives: true, file: file, line: line)

    let converted = T(IntMax(10))
    test(converted == 10, "\(T.self)(IntMax(10)) → \(converted) ≠ 10", file: file, line: line)
}
