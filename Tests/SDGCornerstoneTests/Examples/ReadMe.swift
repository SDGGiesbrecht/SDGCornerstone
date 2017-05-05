/*
 ReadMe.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Define Example: Read‐Me_]
import SDGCornerstone

// Mathematics

func verifyPythagoreanTheorem() {
    let a = 3.0
    let b = 4.0
    let c = 5.0
    if √(a↑2 + b↑2) ≠ c {
        print("Pythagoras was wrong! (Or maybe I just need to research floating point numbers...)")
    }
}

func tryTrigonometry() {
    let θ = 90.0°
    let sine = sin(θ)
    print("The sine of \(θ.inRadians) radians is \(sine)")
}

let tenDuotrigintillion: WholeNumber = "10 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000"

// Randomization

func playWithDice() {

    func rollDie() -> Int {
        return Int(randomInRange: 1 ... 6)
    }

    if rollDie() == 1 ∧ rollDie() == 1 {
        print("Snake eyes!")
    } else {
        print("Not this time...")
    }
}

// Sets

func trySetOperations() {
    let square: Set<Int> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196]
    let twoDigits = 10 ..< 100
    let odd = IntensionalSet<Int>(where: { $0.isOdd })

    if Set([23, 45, 67, 89]) ⊆ (twoDigits ∩ odd) ∖ square {
        print("They’re all in there.")
    }
}

// [_End_]
