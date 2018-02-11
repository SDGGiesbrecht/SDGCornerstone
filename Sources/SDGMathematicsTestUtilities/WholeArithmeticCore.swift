/*
 WholeArithmeticCore.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGTesting

/// Tests a type’s conformance to WholeArithmeticCore.
@_transparent public func testWholeArithmeticCoreConformance<T>(of type: T.Type, includingNegatives: Bool, file: StaticString = #file, line: UInt = #line) where T : WholeArithmeticCore {

    testFixedScaleOneDimensionalPointConformance(departure: 58 as T, vector: 21, destination: 79, file: file, line: line)
    testNumericAdditiveArithmeticConformance(augend: 25 as T, addend: 9, sum: 34, includingNegatives: includingNegatives, file: file, line: line)

    let converted = T(UIntMax(64))
    test(converted == 64, "\(T.self)(UIntMax(64)) → \(converted) ≠ 64", file: file, line: line)

    test(operator: (×, "×"), on: (42 as T, 3), returns: 126, file: file, line: line)
    test(assignmentOperator: (×=, "×="), with: (4 as T, 4), resultsIn: 16, file: file, line: line)

    test(method: (T.dividedAccordingToEuclid, "dividedAccordingToEuclid"), of: 5 as T, with: 3, returns: 1, file: file, line: line)
    test(mutatingMethod: (T.divideAccordingToEuclid, "divideAccordingToEuclid"), of: 72 as T, with: 25, resultsIn: 2, file: file, line: line)

    test(method: (T.mod, "mod"), of: 86 as T, with: 18, returns: 14, file: file, line: line)
    test(mutatingMethod: (T.formRemainder, "formRemainder"), of: 32 as T, with: 2, resultsIn: 0, file: file, line: line)

    test(method: (T.isDivisible, "isDivisible"), of: 64 as T, with: 4, returns: true, file: file, line: line)
    test(method: (T.isDivisible, "isDivisible"), of: 23 as T, with: 62, returns: false, file: file, line: line)

    test(function: (gcd, "gcd"), on: (32 as T, 80), returns: 16, file: file, line: line)
    test(mutatingMethod: (T.formGreatestCommonDivisor, "formGreatestCommonDivisor"), of: 60 as T, with: 10, resultsIn: 10, file: file, line: line)

    test(function: (lcm, "lcm"), on: (5 as T, 3), returns: 15, file: file, line: line)
    test(mutatingMethod: (T.formLeastCommonMultiple, "formLeastCommonMultiple"), of: 4 as T, with: 30, resultsIn: 60, file: file, line: line)

    test(operator: (↑, "↑"), on: (5 as T, 3), returns: 125, file: file, line: line)
    test(assignmentOperator: (↑=, "↑="), with: (2 as T, 5), resultsIn: 32, file: file, line: line)

    test(property: ({ $0.isNatural }, "isNatural"), of: 80 as T, is: true, file: file, line: line)
    test(property: ({ $0.isNatural }, "isNatural"), of: 0 as T, is: false, file: file, line: line)
    if includingNegatives {
        test(property: ({ $0.isNatural }, "isNatural"), of: 0 as T − 34, is: false, file: file, line: line)
    }

    test(property: ({ $0.isWhole }, "isWhole"), of: 35 as T, is: true, file: file, line: line)
    test(property: ({ $0.isWhole }, "isWhole"), of: 0 as T, is: true, file: file, line: line)
    if includingNegatives {
        test(property: ({ $0.isWhole }, "isWhole"), of: 0 as T − 34, is: false, file: file, line: line)
    }

    test(property: ({ $0.isIntegral }, "isIntegral"), of: 14 as T, is: true, file: file, line: line)
    if includingNegatives {
        test(property: ({ $0.isIntegral }, "isIntegral"), of: 0 as T − 83, is: true, file: file, line: line)
    }

    test(property: ({ $0.isEven }, "isEven"), of: 92 as T, is: true, file: file, line: line)
    test(property: ({ $0.isEven }, "isEven"), of: 87 as T, is: false, file: file, line: line)

    test(property: ({ $0.isOdd }, "isOdd"), of: 15 as T, is: true, file: file, line: line)
    test(property: ({ $0.isOdd }, "isOdd"), of: 42 as T, is: false, file: file, line: line)

    test(mutatingMethod: (T.round, "round"), of: 26 as T, with: .toNearestOrAwayFromZero, resultsIn: 26, file: file, line: line)
    test(method: (T.rounded, "rounded"), of: 114 as T, with: .toNearestOrAwayFromZero, returns: 114, file: file, line: line)

    test(mutatingMethod: (T.round, "round"), of: 52 as T, with: (.toNearestOrAwayFromZero, 39), resultsIn: 39, file: file, line: line)
    test(method: (T.rounded, "rounded"), of: 99 as T, with: (.toNearestOrAwayFromZero, 10), returns: 100, file: file, line: line)
}
