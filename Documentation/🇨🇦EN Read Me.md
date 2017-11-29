<!--
 🇨🇦EN Read Me.md

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

[🇨🇦EN](🇨🇦EN%20Read%20Me.md) <!--Skip in Jazzy-->

macOS • Linux • iOS • watchOS • tvOS

APIs: [SDGCornerstone](https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone)

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

(For a list of related projects, see [here](🇨🇦EN%20Related%20Projects.md).) <!--Skip in Jazzy-->

## Importing

`SDGCornerstone` is intended for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add `SDGCornerstone` as a dependency in `Package.swift`:

```swift
let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 7, 1))),
    ],
    targets: [
        .target(name: "MyTarget", dependencies: [
            .productItem(name: "SDGCornerstone", package: "SDGCornerstone"),
        ])
    ]
)
```
