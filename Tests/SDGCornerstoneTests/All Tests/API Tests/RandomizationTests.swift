/*
 RandomizationTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGCornerstone

import SDGXCTestUtilities

class RandomizationTests : TestCase {

    func testBool() {
        var values: Set<Bool> = []
        for _ in 1 ..< 100 {
            values.insert(Bool.random())
        }
        XCTAssertEqual(values.count, 2)
    }

    func testRandomizer() {
        func runTests<R : Randomizer>(_ randomizer: R) {

            var uInt64sReturned: Set<UInt64> = []
            var int64sReturned: Set<Int64> = []
            var positiveInt64sReturned: Set<Int64> = []

            for _ in 1 ... 100 {
                let random = randomizer.randomNumber(inRange: 1 ... 6)
                uInt64sReturned.insert(random)
                XCTAssert(1 ≤ random ∧ random ≤ 6)

                let randomInt = Int64(randomInRange: −3 ... 3)
                int64sReturned.insert(randomInt)
                XCTAssert(−3 ≤ randomInt ∧ randomInt ≤ 3)

                let randomPositiveInt = Int64(randomInRange: 1 ... 6)
                positiveInt64sReturned.insert(randomPositiveInt)
                XCTAssert(1 ≤ randomPositiveInt ∧ randomPositiveInt ≤ 6)

                let randomDouble = Double(randomInRange: −3 ... 3)
                XCTAssert(−3 ≤ randomDouble ∧ randomDouble ≤ 3)
            }

            if R.self == PseudorandomNumberGenerator.self {
                XCTAssertEqual(uInt64sReturned.count, 6)
                XCTAssertEqual(int64sReturned.count, 7)
                XCTAssertEqual(positiveInt64sReturned.count, 6)
            }
        }
        runTests(CyclicalNumberGenerator([0, 1, 6, 7, 11, 12, UInt64.max]))
        runTests(PseudorandomNumberGenerator.defaultGenerator)
    }

    static var allTests: [(String, (RandomizationTests) -> () throws -> Void)] {
        return [
            ("testBool", testBool),
            ("testRandomizer", testRandomizer)
        ]
    }
}
