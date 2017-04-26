/*
 FunctionAnalysisExamples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

private func useFindLocalMinimum() {
    // [_Define Example: findLocalMinimum_]
    let approximateSquareRootOf120 = findLocalMinimum(near: 10) { (guess: Int) -> Int in

        // Find the square of the guess.
        let square = guess × guess

        // Determine its proximity to 120.
        return |(square − 120)|
    }

    // First iteration (determined by “near: 10”):
    // 10 → 20

    // Second iteration:
    // 11 → 1
    // Decreasing, so continue.

    // Third iteration:
    // 12 → 24
    // No longer decreasing, so stop. 1 was the local minimum.

    print(approximateSquareRootOf120)
    // Prints “11”
    // [_End_]
}

private func demonstrateUndefinedCasesForFindLocalMinimum() {
    // [_Define Example: findLocalMinimum Undefined 1_]
    // This is undefined:
    _ = findLocalMinimum(near: 0) { (−10 ..< 10).contains($0) ? −($0 ↑ 2) : $0 ↑ 2 }
    // [_End_]

    // [_Define Example: findLocalMinimum Undefined 2_]
    // This is undefined:
    _ = findLocalMinimum(near: 0) { (−10 ..< 10).contains($0) ? −1 : |$0| }
    // [_End_]
}

private func demonstratePreconditionViolationForFindLocalMinimum() {
    // [_Define Example: findLocalMinimum Precondition Violation_]
    // Never do this:
    _ = findLocalMinimum(near: 0, inFunction: {$0})
    // [_End_]
}

private func demonstrateUndefinedCasesForFindLocalMaximum() {
    // [_Define Example: findLocalMaximum Undefined 1_]
    // This is undefined:
    _ = findLocalMaximum(near: 0) { (−10 ..< 10).contains($0) ? $0 ↑ 2 : −($0 ↑ 2) }
    // [_End_]

    // [_Define Example: findLocalMaximum Undefined 2_]
    // This is undefined:
    _ = findLocalMaximum(near: 0) { (−10 ..< 10).contains($0) ? 1 : −(|$0|) }
    // [_End_]
}

private func demonstratePreconditionViolationForFindLocalMaximum() {
    // [_Define Example: findLocalMaximum Precondition Violation_]
    // Never do this:
    _ = findLocalMaximum(near: 0, inFunction: {$0})
    // [_End_]
}
