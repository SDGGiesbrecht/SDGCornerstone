/*
 PerformanceTest.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematicsCore

/// Tests that a closure executes within a specified amount of time.
///
/// The closure will be run several times to determine the mean duration. If the mean duration is slower than the expected time, the test will fail. If the mean duration is within the expected time, then the test will pass and the mean duration will be printed.
///
/// Notes: A closure’s execution times may vary vastly accross different systems or build configurations. Expectations must either be set according to the slowest environment where the tests will be run, or else limited by conditions so as to only run on those environments that are meaningful.
///
/// - Parameters:
///     - testName: A name to identify the particular test in the output.
///     - duration: The time limit within which the closure is expected to complete.
///     - file: The file name where the call occurs. Provided.
///     - line: The line number where the call occurs. Provided.
///     - test: The closure to test.
@_transparent public func limit(_ testName: String, to duration: TimeInterval, file: StaticString = #file, line: UInt = #line, test: () -> Void) {

    let iterations = 10

    var results: [TimeInterval] = []
    for _ in 1 ... iterations {
        let start = Date.timeIntervalSinceReferenceDate
        test()
        let end = Date.timeIntervalSinceReferenceDate
        results.append(end − start)
    }
    let sum = results.reduce(0) { $0 + $1 }
    let mean = sum ÷ TimeInterval(iterations)

    if mean > duration {
        // [_Warning: Localize this._]
        fail("“\(testName)” took an average of \(mean) seconds! That is too slow (compared to \(duration) seconds).", file: file, line: line)
    } else {
        print("• “\(testName)” took an average of \(mean) seconds.")
    }
}
