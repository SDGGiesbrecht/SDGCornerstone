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

- Generic pattern matching.
- Customizable randomization.
- Arbitrary‐precision arithmetic.
- Inter‐type set operations.
- Mathematics: exponents, roots, logarithms, trigonometry, etc.

...and much more.

(For a list of related projecs, see [here](Documentation/Related%20Projects.md).) <!--Skip in Jazzy-->

## Importing

SDGCornerstone is intended for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGCornerstone as a dependency in `Package.swift`:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .Package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", versions: "0.1.2" ..< "0.2.0"),
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
    print("The sine of \(θ.inRadians.inDigits(maximumDecimalPlaces: 3, radixCharacter: ".")) radians is \(sine.inDigits(maximumDecimalPlaces: 3, radixCharacter: "."))")
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

// Pattern Matching

func tryPatternMatching() {
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    if numbers.contains(CompositePattern([
        LiteralPattern([1]), // 1
        ConditionalPattern(condition: { $0.isEven }), // 2
        AlternativePatterns([
            LiteralPattern([30, 40]), // (∅)
            LiteralPattern([3, 4]) // 3, 4
            ]),
        RepetitionPattern(NotPattern(LiteralPattern([5, 7]))), // 5, 6, 7, 8, 9 (...)
        LiteralPattern([10]) // 10
        ])) {

        print("I found a match!")
    }
}
```

## About

The SDGCornerstone project is maintained by Jeremy David Giesbrecht.

If SDGCornerstone saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGCornerstone saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGCornerstone) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.<br>For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―‎ישוע/Yeshuʼa
