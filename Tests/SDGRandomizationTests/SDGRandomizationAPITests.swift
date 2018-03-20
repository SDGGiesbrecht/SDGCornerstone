/*
 SDGRandomizationAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGRandomizationTestUtilities
import SDGXCTestUtilities

import SDGLogic
import SDGMathematics

class SDGRandomizationAPITests : TestCase {

    func testBool() {
        var values: Set<Bool> = []
        for _ in 1 ..< 100 {
            values.insert(Bool.random())
        }
        XCTAssertEqual(values.count, 2)
    }

    func testCollection() {
        let forDrawing = (1 ... 6)
        var sameOccurred = false
        var differentOccurred = false
        for _ in 1 ... 100 {
            let random = forDrawing.randomElement()
            if random == 1 {
                sameOccurred = true
            } else {
                differentOccurred = true
            }
        }
        XCTAssert(sameOccurred)
        XCTAssert(differentOccurred)
    }

    func testCyclicalNumberGenerator() {
        testRandomizerConformance(of: CyclicalNumberGenerator([0, 1, 6, 7, 11, 12, UInt64.max]))
    }

    func testDouble() {
        XCTAssertEqual(Double(randomInRange: 0 ... 0), 0)
        XCTAssert((0 ..< 1).contains(Double(randomInRange: 0 ..< 1)))
    }

    func testInt() {
        testRandomizableNumberConformance(of: Int.self)
    }

    func testMeasurement() {
        XCTAssertEqual(Angle<Double>(randomInRange: 0.rad ... 0.rad), 0.rad)
        XCTAssert((0° ..< 1°).contains(Angle<Double>(randomInRange: 0° ..< 1°)))
    }

    func testPseudorandomNumberGenerator() {
        let randomizer = PseudorandomNumberGenerator.defaultGenerator
        testRandomizerConformance(of: randomizer)

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

        XCTAssertEqual(uInt64sReturned.count, 6)
        XCTAssertEqual(int64sReturned.count, 7)
        XCTAssertEqual(positiveInt64sReturned.count, 6)
    }

    func testRangeReplaceableCollection() {
        var last = [1, 2, 3, 4, 5]
        var same = true
        for _ in 1 ... 100 where same {
            let next = last.shuffled()
            if ¬next.elementsEqual(last) {
                same = false
            }
            last = next
        }
        XCTAssert(¬same)
    }

    func testUInt() {
        testRandomizableNumberConformance(of: UInt.self)
    }

    static var allTests: [(String, (SDGRandomizationAPITests) -> () throws -> Void)] {
        return [
            ("testBool", testBool),
            ("testCollection", testCollection),
            ("testCyclicalNumberGenerator", testCyclicalNumberGenerator),
            ("testDouble", testDouble),
            ("testInt", testInt),
            ("testMeasurement", testMeasurement),
            ("testPseudorandomNumberGenerator", testPseudorandomNumberGenerator),
            ("testRangeReplaceableCollection", testRangeReplaceableCollection),
            ("testUInt", testUInt),
        ]
    }
}
