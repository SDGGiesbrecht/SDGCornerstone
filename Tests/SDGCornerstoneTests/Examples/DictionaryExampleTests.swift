/*
 DictionaryExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstone

class DictionaryExampleTests : TestCase {

    func testMutate() {

        // [_Define Example: mutateValue(for:_:)_]
        func rollDie() -> Int {
            return Int(randomInRange: 1 ... 6)
        }

        var frequencies = [Int: Int]()
        for _ in 1 ... 100 {
            frequencies.mutateValue(for: rollDie()) { ($0 ?? 0) + 1 }
        }
        print(frequencies.keys.sorted().map({ "\($0.inDigits()): \(frequencies[$0]!.inDigits())" }).joined(separator: "\n"))
        // Prints, for example:
        //
        // 1: 21
        // 2: 8
        // 3: 29
        // 4: 12
        // 5: 20
        // 6: 10

        // In this example, the die is rolled 100 times, and each time the tally for the outcome is incremented. After the for loop, the dictionary contains the frequencies (values) for each outcome (keys).
        // [_End_]

        XCTAssert(frequencies.count ≤ 6)
    }

    static var allTests: [(String, (DictionaryExampleTests) -> () throws -> Void)] {
        return [
            ("testMutate", testMutate)
        ]
    }
}
