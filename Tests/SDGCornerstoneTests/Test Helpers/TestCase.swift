/*
 TestCase.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

class TestCase : XCTestCase {

    static var initialized = false

    override func setUp() {
        if ¬TestCase.initialized {
            TestCase.initialized = true
            SDGCornerstone.initialize(mode: .guiApplication, applicationIdentifier: "ca.solideogloria.SDGCornerstone.Tests")
        }
        super.setUp()
    }

    func lock(_ testName: String, to duration: TimeInterval, file: StaticString = #file, line: UInt = #line, test: () -> Void) {

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
            XCTFail("“\(testName)” took an average of \(mean) seconds! That is too slow (compared to \(duration) seconds.", file: file, line: line)
        } else {
            print("• “\(testName)” took an average of \(mean) seconds.")
        }
    }
}
