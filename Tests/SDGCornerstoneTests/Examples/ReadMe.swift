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

// Logic

func tryLogicOperators() {
    if ¬((true ∧ false) ∨ true) ≠ true {
        print("I’m confused...")
    }
}

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

func analyzeParabola() {
    let parabola: (Int) -> Int = {
        (x: Int) -> Int in
        return 2 × x↑2   +   4 × x   −   1
    }
    let vertexX = findLocalMinimum(near: 0, inFunction: parabola)
    print("The vertex is at (\( vertexX ), \( parabola(vertexX) )).")
}

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

// [_End_]
