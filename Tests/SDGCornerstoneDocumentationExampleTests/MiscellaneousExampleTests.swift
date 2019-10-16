/*
 MiscellaneousExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import Dispatch

import SDGMathematics
import SDGCollections
import SDGCalendar
import SDGConcurrency
import SDGRandomization
import SDGPrecisionMathematics

import XCTest

import SDGXCTestUtilities

class MiscellaneousExampleTests : TestCase {

    func testAbsoluteValue() {

        // @example(absoluteValue)
        let x = −1
        let y = |x|
        XCTAssertEqual(y, 1)
        // @endExample
    }

    func testAlternatingBooleans() {
        // @example(alternatingBooleans)
        var alternating = CyclicalNumberGenerator([
            Bool.falseRandomizerValue,
            Bool.trueRandomizerValue
            ])

        XCTAssertEqual(Bool.random(using: &alternating), false)
        XCTAssertEqual(Bool.random(using: &alternating), true)
        XCTAssertEqual(Bool.random(using: &alternating), false)
        XCTAssertEqual(Bool.random(using: &alternating), true)
        XCTAssertEqual(Bool.random(using: &alternating), false)
        XCTAssertEqual(Bool.random(using: &alternating), true)
        // ...
        // @endExample
    }

    func testApproximation() {

        // @example(≈)
        XCTAssert(1 ÷ 3 ≈ 0.33333 ± 0.00001)
        // @endExample
    }

    func testBackwardsSearchDifferences1() {

        // @example(lastMatchBackwardsDifferences1)
        let collection = [0, 0, 0, 0, 0]
        let pattern = [0, 0]

        XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 3 ..< 5)

        XCTAssertEqual(collection.matches(for: pattern).last?.range, 2 ..< 4)
        // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
        // @endExample
    }

    func testBackwardsSearchDifferences2() {

        // @example(lastMatchBackwardsDifferences2)
        let collection = [0, 0, 1]
        let pattern = RepetitionPattern([0], count: 1 ..< Int.max, consumption: .lazy) + [1]

        XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 1 ..< 3)
        // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)

        XCTAssertEqual(collection.matches(for: pattern).last?.range, 0 ..< 3)
        // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
        // @endExample
    }

    func testDecreasing() {

        // @example(decrease)
        func rollDie() -> Int {
            return Int.random(in: 1 ... 6)
        }

        let numberOfRolls = 5
        var lowestRoll = 6
        for _ in 1 ... numberOfRolls {
            lowestRoll.decrease(to: rollDie())
        }
        print("After rolling the die \(numberOfRolls.inDigits()) time(s), the lowest roll was \(lowestRoll.inDigits()).")
        // Prints, for example, “After rolling the die 5 time(s), the lowest roll was 2.”

        // In each iteration of the for loop, a new number is rolled, and if it is less than lowestRoll’s existing value, decrease(to:) changes lowestRoll to reflect the new low.
        // @endExample

        XCTAssert(lowestRoll ∈ 1 ... 6)
    }

    func testDictionaryMutation() {

        // @example(mutateValue)
        func rollDie() -> Int {
            return Int.random(in: 1 ... 6)
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
        // @endExample

        XCTAssert(frequencies.count ≤ 6)
    }

    func testGregorianYear() {
        // @example(gregorianYear)
        let adOne = GregorianYear(1)
        let oneBC = GregorianYear(−1)
        let oneYear = Int(1)

        XCTAssertEqual(adOne − oneYear, oneBC)
        XCTAssertEqual(adOne − oneBC, oneYear)
        // @endExample

        // @example(gregorianischesJahr)
        let einsNChr = GregorianischesJahr(1)
        let einsVChr = GregorianischesJahr(−1)
        let einJahr = Int(1)

        XCTFeststellenGleich(einsNChr − einJahr, einsVChr)
        XCTFeststellenGleich(einsNChr − einsVChr, einJahr)
        // @endExample
    }

    func testIncreasing() {

        // @example(increase)
        func rollDie() -> Int {
            return Int.random(in: 1 ... 6)
        }

        let numberOfRolls = 5
        var highestRoll = 1
        for _ in 1 ... numberOfRolls {
            highestRoll.increase(to: rollDie())
        }
        print("After rolling the die \(numberOfRolls.inDigits()) time(s), the highest roll was \(highestRoll.inDigits()).")
        // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”

        // In each iteration of the for loop, a new number is rolled, and if it is greater than highestRoll’s existing value, increase(to:) changes highestRoll to reflect the new high.
        // @endExample

        XCTAssert(highestRoll ∈ 1 ... 6)
    }

    func testIntegerLiterals() {

        typealias Integer = SDGPrecisionMathematics.Integer

        // @example(integerLiterals)
        let negativeMillion: Integer = −1_000_000
        let negativeDecillion: Integer = "−1 000 000 000 000 000 000 000 000 000 000 000"
        let negativeYobiMultiplier = Integer(binary: "−1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000")
        // @endExample

        XCTAssertEqual(−(1000 ↑ 2), negativeMillion)
        XCTAssertEqual(−(1000 ↑ 11), negativeDecillion)
        XCTAssertEqual(−(Integer(binary: "1 0000000000") ↑ 8), negativeYobiMultiplier)
    }

    func testNestingLevel() {

        // @example(nestingLevel)
        let equation = "2(3x − (y + 4)) = z"
        let nestingLevel = equation.scalars.firstNestingLevel(startingWith: "(".scalars, endingWith: ")".scalars)!

        XCTAssertEqual(String(nestingLevel.container.contents), "(3x − (y + 4))")
        XCTAssertEqual(String(nestingLevel.contents.contents), "3x − (y + 4)")
        // @endExample
    }

    func testPatternSwitch() {
        // @example(patternSwitch)
        switch "This is a string." {
        case RepetitionPattern("."):
            XCTFail("This case does not match.")
        case RepetitionPattern(¬".") + ".":
            print("This case does match.")
        default:
            XCTFail("This case is never reached.")
        }
        // @endExample
    }

    func testRationalNumberLiterals() {

        func ensureLiteralsCompile() {
            // This is 60 times slower in the debug configuration compared to the optimized release.
            // It is not worth bogging down tests.

            // @example(rationalNumberLiterals)
            let third: RationalNumber = 1 ÷ 3
            let decillionth: RationalNumber = "0.000 000 000 000 000 000 000 000 000 000 001"
            let half = RationalNumber(binary: "0.1")
            // @endExample

            _ = third
            _ = decillionth
            _ = half
        }
    }

    func testRunLoopUsage() {

        // @example(runLoopUsage)
        var driver: RunLoop.Driver?
        DispatchQueue.global(qos: .userInitiated).async {
            RunLoop.current.runForDriver { driver = $0 }
        }
        // The background run loop is now running.

        driver = nil
        // The background run loop has now stopped.
        // @endExample

        _ = driver
    }

    func testSetSwitch() {

        // @example(setSwitch)
        switch 5 {
        case IntensionalSet(where: { $0.isEven }):
            XCTFail("This case does not match.")
        case (2 ... 4 ∪ 7 ... 9)′:
            print("This case does match.")
        default:
            XCTFail("This case is never reached.")
        }
        // @endExample
    }

    func testWholeNumberLiterals() {

        // @example(wholeNumberLiterals)
        let million: WholeNumber = 1_000_000
        let decillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000"
        let yobiMultiplier = WholeNumber(binary: "1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000")
        // @endExample

        XCTAssertEqual(1000 ↑ 2, million)
        XCTAssertEqual(1000 ↑ 11, decillion)
        XCTAssertEqual(WholeNumber(binary: "1 0000000000") ↑ 8, yobiMultiplier)
    }
}
