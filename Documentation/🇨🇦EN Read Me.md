<!--
 🇨🇦EN Read Me.md

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

[🇨🇦EN](🇨🇦EN%20Read%20Me.md)

macOS • Linux • iOS • watchOS • tvOS

[Documentation](https://sdggiesbrecht.github.io/SDGCornerstone/%F0%9F%87%A8%F0%9F%87%A6EN)

# SDGCornerstone

SDGCornerstone forms the foundation of the SDG module family. It establishes design patterns and provides general‐use extensions to the [Swift Standard Library](https://developer.apple.com/reference/swift) and [Foundation](https://developer.apple.com/reference/foundation).

> [הִנְנִי יִסַּד בְּצִיּוֹן אָבֶן אֶבֶן בֹּחַן פִּנַּת יִקְרַת מוּסָד מוּסָד׃<br>Behold, I establish in Zion a stone, a tested stone, a precious cornerstone, a sure foundation.](https://www.biblegateway.com/passage/?search=Isaiah+28&version=WLC;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―⁧יהוה⁩/Yehova

## Features

- Localization tools (compatible with the Swift Package Manager and Linux).
- User preferences access (compatible with Linux).
- Platform‐independent access to best‐practice file system locations.
- Shared instances of value types.
- Generic pattern matching.
- Arbitrary‐precision arithmetic.
- Simple API for running shell commands (desktop platforms only).

...and much more.

Use the entire package together by importing the `SDGCornerstone` product, or pick and choose pieces by importing the various component products.

(For a list of related projects, see [here](🇨🇦EN%20Related%20Projects.md).)

## Importing

SDGCornerstone provides libraries for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGCornerstone as a dependency in `Package.swift` and specify which of the libraries to use:

```swift
let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 15, 0))),
    ],
    targets: [
        .target(name: "MyTarget", dependencies: [
            .productItem(name: "SDGCornerstone", package: "SDGCornerstone"),
            .productItem(name: "SDGCornerstoneTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematics", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematicsTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGCollectionsTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGBinaryData", package: "SDGCornerstone"),
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistence", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGRandomization", package: "SDGCornerstone"),
            .productItem(name: "SDGRandomizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGGeometry", package: "SDGCornerstone"),
            .productItem(name: "SDGCalendar", package: "SDGCornerstone"),
            .productItem(name: "SDGPrecisionMathematics", package: "SDGCornerstone"),
            .productItem(name: "SDGConcurrency", package: "SDGCornerstone"),
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone"),
            .productItem(name: "SDGTesting", package: "SDGCornerstone"),
        ])
    ]
)
```

The libraries’ modules can then be imported in source files:

```swift
import SDGCornerstone
import SDGCornerstoneTestUtilities
import SDGXCTestUtilities
import SDGControlFlow
import SDGLogic
import SDGLogicTestUtilities
import SDGMathematics
import SDGMathematicsTestUtilities
import SDGCollections
import SDGCollectionsTestUtilities
import SDGBinaryData
import SDGText
import SDGPersistence
import SDGPersistenceTestUtilities
import SDGRandomization
import SDGRandomizationTestUtilities
import SDGLocalization
import SDGLocalizationTestUtilities
import SDGGeometry
import SDGCalendar
import SDGPrecisionMathematics
import SDGConcurrency
import SDGExternalProcess
import SDGTesting
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
let text = UserFacing<StrictString, ApplicationLocalization>({ localization in
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
} catch {
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

// ••••••• Arbitrary Precision Arithmetic •••••••

let tenDuotrigintillion: WholeNumber = "10 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000"
XCTAssert(tenDuotrigintillion.isDivisible(by: 10))

#if !(os(iOS) || os(watchOS) || os(tvOS))

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
