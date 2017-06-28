/*
 ComparableExamples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

private func demonstrateIncrease() {

    // [_Define Example: increase(to:)_]
    func rollDie() -> Int {
        return Int(randomInRange: 1 ... 6)
    }

    let numberOfRolls = 5
    var highestRoll = 1
    for _ in 1 ... numberOfRolls {
        highestRoll.increase(to: rollDie())
    }
    print("After rolling the die \(numberOfRolls.inDigits()) time(s), the highest roll was \(highestRoll.inDigits()).")
    // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”

    // In each iteration of the for loop, a new number is rolled, and if it is greater than highestRoll’s existing value, increase(to:) changes highestRoll to reflect the new high.
    // [_End_]
}

private func demonstrateDecrease() {

    // [_Define Example: decrease(to:)_]
    func rollDie() -> Int {
        return Int(randomInRange: 1 ... 6)
    }

    let numberOfRolls = 5
    var lowestRoll = 6
    for _ in 1 ... numberOfRolls {
        lowestRoll.decrease(to: rollDie())
    }
    print("After rolling the die \(numberOfRolls.inDigits()) time(s), the lowest roll was \(lowestRoll.inDigits()).")
    // Prints, for example, “After rolling the die 5 time(s), the lowest roll was 2.”

    // In each iteration of the for loop, a new number is rolled, and if it is less than lowestRoll’s existing value, decrease(to:) changes lowestRoll to reflect the new low.
    // [_End_]
}

private func demonstrateApproximates() {

    // [_Define Example: ≈_]
    if 1 ÷ 3 ≈ 0.33333 ± 0.00001 {
        print("It is accurate to at least four digits.")
    }
    // [_End_]
}
