<!--
 README.md

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

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

- Localization tools (compatible with the Swift Package Manager and Linux).
- User preferences access (compatible with Linux).
- Platform‐independent access to best‐practice file system locations.
- Shared instances of value types.
- Generic pattern matching.
- Customizable randomization.
- Arbitrary‐precision arithmetic.
- Simple API for running shell commands (desktop platforms only).

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
        .Package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", versions: "0.7.1" ..< "0.8.0"),
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

let preferences = Preferences.applicationPreferences

// Save
preferences["name"].value = "John Doe"
// Load
let loaded: String? = preferences["name"].value?.as(String.self)

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
    ConditionalPattern(condition: { $0.isEven }), // 2
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
