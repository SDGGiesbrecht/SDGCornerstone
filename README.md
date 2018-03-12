<!--
 README.md

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

[🇨🇦EN](Documentation/🇨🇦EN%20Read%20Me.md) <!--Skip in Jazzy-->

macOS • Linux • iOS • watchOS • tvOS

APIs: [SDGCornerstone](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGCornerstone) • [SDGCornerstoneTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGCornerstoneTestUtilities) • [SDGControlFlow](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGControlFlow) • [SDGLogic](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGLogic) • [SDGLogicTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGLogicTestUtilities) • [SDGBinaryData](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGBinaryData) • [SDGBinaryDataTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGBinaryDataTestUtilities) • [SDGMathematics](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGMathematics) • [SDGMathematicsTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGMathematicsTestUtilities) • [SDGCollections](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGCollections) • [SDGCollectionsTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGCollectionsTestUtilities) • [SDGText](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGText) • [SDGTextTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGTextTestUtilities) • [SDGPersistence](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGPersistence) • [SDGPersistenceTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGPersistenceTestUtilities) • [SDGRandomization](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGRandomization) • [SDGRandomizationTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGRandomizationTestUtilities) • [SDGLocalization](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGLocalization) • [SDGLocalizationTestUtilities](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGLocalizationTestUtilities) • [SDGTesting](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGTesting) • [SDGMathematicsCore](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGMathematicsCore) • [SDGCollectionsCore](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGCollectionsCore) • [SDGTextCore](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone/SDGTextCore)

# SDGCornerstone

SDGCornerstone forms the foundation of the SDG module family. It establishes design patterns and provides general‐use extensions to the [Swift Standard Library](https://developer.apple.com/reference/swift) and [Foundation](https://developer.apple.com/reference/foundation).

> [הִנְנִי יִסַּד בְּצִיּוֹן אָבֶן אֶבֶן בֹּחַן פִּנַּת יִקְרַת מוּסָד מוּסָד׃<br>Behold, I establish in Zion a stone, a tested stone, a precious cornerstone, a sure foundation.](https://www.biblegateway.com/passage/?search=Isaiah+28&version=WLC;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―⁧יהוה⁩/Yehova

## Features

- Localization tools (compatible with the Swift Package Manager and Linux).
- User preferences access (compatible with Linux).
- Platform‐independent access to best‐practice file system locations.
- Shared instances of value types.
- Generic pattern matching.
- Customizable randomization.
- Arbitrary‐precision arithmetic.
- Simple API for running shell commands (desktop platforms only).

...and much more.

(For a list of related projects, see [here](Documentation/🇨🇦EN%20Related%20Projects.md).) <!--Skip in Jazzy-->

## Importing

`SDGCornerstone` is intended for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add `SDGCornerstone` as a dependency in `Package.swift`:

```swift
let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 7, 3))),
    ],
    targets: [
        .target(name: "MyTarget", dependencies: [
            .productItem(name: "SDGCornerstone", package: "SDGCornerstone"),
            .productItem(name: "SDGCornerstoneTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGBinaryData", package: "SDGCornerstone"),
            .productItem(name: "SDGBinaryDataTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematics", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematicsTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGCollectionsTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGTextTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistence", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGRandomization", package: "SDGCornerstone"),
            .productItem(name: "SDGRandomizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGTesting", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematicsCore", package: "SDGCornerstone"),
            .productItem(name: "SDGCollectionsCore", package: "SDGCornerstone"),
            .productItem(name: "SDGTextCore", package: "SDGCornerstone"),
        ])
    ]
)
```

`SDGCornerstone` can then be imported in source files:

```swift
import SDGCornerstone
import SDGCornerstoneTestUtilities
import SDGControlFlow
import SDGLogic
import SDGLogicTestUtilities
import SDGBinaryData
import SDGBinaryDataTestUtilities
import SDGMathematics
import SDGMathematicsTestUtilities
import SDGCollections
import SDGCollectionsTestUtilities
import SDGText
import SDGTextTestUtilities
import SDGPersistence
import SDGPersistenceTestUtilities
import SDGRandomization
import SDGRandomizationTestUtilities
import SDGLocalization
import SDGLocalizationTestUtilities
import SDGTesting
import SDGMathematicsCore
import SDGCollectionsCore
import SDGTextCore
```

## Example Usage

```swift
// ••••••• Localization •••••••

enum ApplicationLocalization : String, Localization {
    case english = "en"
    case français = "fr"
    static let fallbackLocalization = ApplicationLocalization.english
}

// Define
let text = UserFacingText<ApplicationLocalization, Void>({ (localization, _) in
    switch localization {
    case .english:
        return "Hello, world!"
    case .français:
        return "Bonjour, le monde !"
    }
})

// Use
XCTAssertEqual(text.resolved(),
               "Hello, world!")

// ••••••• Preferences •••••••

let preferences = PreferenceSet.applicationPreferences

// Save
preferences["name"].value.set(to: "John Doe")
// Load
let loaded: String? = preferences["name"].value.as(String.self)

XCTAssertEqual(loaded,
               "John Doe")

// ••••••• File System •••••••

let url = FileManager.default.url(in: .applicationSupport, at: "folder/file.txt")
do {
    // Save
    try "Contents".save(to: url)
    // Load
    let loaded = try String(from: url)

    XCTAssertEqual(loaded,
                   "Contents")
} catch let error {
    XCTFail(error.localizedDescription)
}

// ••••••• Shared Values •••••••

class Owner {
    var property: Shared<String>
    init(property: Shared<String>) {
        self.property = property
    }
}

let originalOwner = Owner(property: Shared("original"))
let anotherOwner = Owner(property: originalOwner.property)

anotherOwner.property.value = "changed"
XCTAssertEqual(originalOwner.property.value,
               "changed")

// ••••••• Pattern Matching •••••••

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let pattern = CompositePattern([
    LiteralPattern([1]), // 1
    ConditionalPattern({ $0.isEven }), // 2
    AlternativePatterns([
        LiteralPattern([30, 40]), // (∅)
        LiteralPattern([3, 4]) // 3, 4
        ]),
    RepetitionPattern(NotPattern(LiteralPattern([5, 7]))), // 5, 6, 7, 8, 9 (...)
    LiteralPattern([10]) // 10
    ])

XCTAssertEqual(numbers.firstMatch(for: pattern)?.range,
               numbers.startIndex ..< numbers.endIndex)

// ••••••• Randomization •••••••

func rollDie() -> Int {
    return Int(randomInRange: 1 ... 6)
}

if rollDie() == 1 ∧ rollDie() == 1 {
    print("Snake eyes!")
} else {
    print("Not this time...")
}

// ••••••• Arbitrary Precision Arithmetic •••••••

let tenDuotrigintillion: WholeNumber = "10 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000"
XCTAssert(tenDuotrigintillion.isDivisible(by: 10))

#if os(macOS) || os(Linux)

    // ••••••• Shell Commands •••••••

    XCTAssertEqual(try? Shell.default.run(command: ["echo", "Hello, world!"]),
                   "Hello, world!")
#endif
```

## About

The SDGCornerstone project is maintained by Jeremy David Giesbrecht.

If SDGCornerstone saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGCornerstone saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGCornerstone) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.<br>For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―‎ישוע/Yeshuʼa
