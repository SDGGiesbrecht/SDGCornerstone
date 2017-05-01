<!--
 README.md

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

<!--
 !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!!
 This file is managed by Workspace.
 Manual changes will not persist.
 For more information, see:
 https://github.com/SDGGiesbrecht/Workspace/blob/master/Documentation/Read‐Me.md
 !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!!
 -->

APIs: [macOS](https://sdggiesbrecht.github.io/SDGCornerstone/macOS) • [Linux](https://sdggiesbrecht.github.io/SDGCornerstone/Linux) • [iOS](https://sdggiesbrecht.github.io/SDGCornerstone/iOS) • [watchOS](https://sdggiesbrecht.github.io/SDGCornerstone/watchOS) • [tvOS](https://sdggiesbrecht.github.io/SDGCornerstone/tvOS)

# SDGCornerstone

SDGCornerstone forms the foundation of the SDG module family. It establishes design patterns and provides general‐use extensions to the [Swift Standard Library](https://developer.apple.com/reference/swift) and [Foundation](https://developer.apple.com/reference/foundation).

> [הִנְנִי יִסַּד בְּצִיּוֹן אָבֶן אֶבֶן בֹּחַן פִּנַּת יִקְרַת מוּסָד מוּסָד׃<br>Behold, I establish in Zion a stone, a tested stone, a precious cornerstone, a sure foundation.](https://www.biblegateway.com/passage/?search=Isaiah+28&version=WLC;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―⁧יהוה⁩/Yehova

## Features

- Mathematics: exponents, roots, logarithms, trigonometry, etc.
- Arbitrary‐precision arithmetic.
- Customizable randomization.

(For a list of related projecs, see [here](Documentation/Related%20Projects.md).) <!--Skip in Jazzy-->

## Importing

SDGCornerstone is intended for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGCornerstone as a dependency in `Package.swift`:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .Package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", versions: "0.1.0" ..< "0.2.0"),
        ...
    ]
)
```

SDGCornerstone can then be imported in source files:

```swift
import SDGCornerstone
```

## Example Usage

```swift
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
```

## About

The SDGCornerstone project is maintained by Jeremy David Giesbrecht.

If SDGCornerstone saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGCornerstone saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGCornerstone) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.<br>For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―‎ישוע/Yeshuʼa
