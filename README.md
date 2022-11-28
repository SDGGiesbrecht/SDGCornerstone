<!--
 README.md

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

macOS • Windows • Web • Ubuntu • tvOS • iOS • Android • Amazon Linux • watchOS

[Documentation](https://sdggiesbrecht.github.io/SDGCornerstone/%F0%9F%87%A8%F0%9F%87%A6EN)

# SDGCornerstone

SDGCornerstone forms the foundation of the SDG module family; it establishes design patterns and provides general‐use extensions to the [Swift Standard Library](https://developer.apple.com/reference/swift) and [Foundation](https://developer.apple.com/reference/foundation).

> [הִנְנִי יִסַּד בְּצִיּוֹן אָבֶן אֶבֶן בֹּחַן פִּנַּת יִקְרַת מוּסָד מוּסָד׃](https://www.biblegateway.com/passage/?search=Isaiah+28&version=WLC;NIV)
>
> [Behold, I establish in Zion a stone, a tested stone, a precious cornerstone, a sure foundation.](https://www.biblegateway.com/passage/?search=Isaiah+28&version=WLC;NIV)
>
> ―⁧יהוה⁩/Yehova

### Features:

- Localization tools compatible with the Swift Package Manager and Linux. (`SDGLocalization`)
- User preferences compatible with Linux. (`PreferenceSet`, `Preference`)
- Platform‐independent access to best‐practice file system locations. (`url(for:in:at:)`)
- Shared instances of value types. (`Shared<Value>`)
- Generic pattern matching. (`SearchableCollection`, `Pattern<Element>`)
- Customizable randomization. (`SDGRandomization`)
- Arbitrary‐precision arithmetic. (`SDGPrecisionMathematics`)
- A simple API for running shell commands on desktop platforms. (`SDGExternalProcess`)

...and much more.

### Example Usage

```swift
// ••••••• Localization •••••••

enum ApplicationLocalization: String, Localization {
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
XCTAssertEqual(
  text.resolved(),
  "Hello, world!"
)

// ••••••• Preferences •••••••

let preferences = PreferenceSet.applicationPreferences

// Save
preferences["name"].value.set(to: "John Doe")
// Load
let loaded: String? = preferences["name"].value.as(String.self)

XCTAssertEqual(
  loaded,
  "John Doe"
)

// ••••••• File System •••••••

let url = FileManager.default.url(in: .applicationSupport, at: "folder/file.txt")
do {
  // Save
  try "Contents".save(to: url)
  // Load
  let loaded = try String(from: url)

  XCTAssertEqual(
    loaded,
    "Contents"
  )
} catch {
  XCTFail(error.localizedDescription)
}

// ••••••• Shared Values •••••••

class Owner {
  @SharedProperty var property: String = ""
}

let originalOwner = Owner()
originalOwner.property = "original"
let anotherOwner = Owner()
anotherOwner.$property = originalOwner.$property

anotherOwner.property = "changed"
XCTAssertEqual(
  originalOwner.property,
  "changed"
)

// ••••••• Pattern Matching •••••••

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let patternFirstPart =
  [1]  // 1
  + ConditionalPattern({ $0.isEven })  // 2
  + ([30, 40]  // (∅)
    ∨ [3, 4])  // 3, 4
let pattern =
  patternFirstPart
  + RepetitionPattern(¬[5, 7])  // 5, 6, 7, 8, 9 (...)
  + [10]  // 10

XCTAssertEqual(
  numbers.firstMatch(for: pattern)?.range,
  numbers.startIndex..<numbers.endIndex
)

// ••••••• Arbitrary Precision Arithmetic •••••••

let tenDuotrigintillion: WholeNumber =
  "10 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000"
XCTAssert(tenDuotrigintillion.isDivisible(by: 10))

// ••••••• Shell Commands •••••••

#if !PLATFORM_LACKS_FOUNDATION_PROCESS
  XCTAssertEqual(
    try? Shell.default.run(command: ["echo", "Hello, world!"]).get().suffix(13),
    "Hello, world!"
  )
#endif
```

Some platforms lack certain features. The compilation conditions which appear throughout the documentation are defined as follows:

```swift
.define("PLATFORM_HAS_COCOA", .when(platforms: [.macOS, .tvOS, .iOS, .watchOS])),
.define("PLATFORM_LACKS_FOUNDATION_FILE_MANAGER", .when(platforms: [.wasi])),
.define(
  "PLATFORM_LACKS_FOUNDATION_PROCESS",
  .when(platforms: [.wasi, .tvOS, .iOS, .watchOS])
),
.define("PLATFORM_LACKS_FOUNDATION_RUN_LOOP", .when(platforms: [.wasi])),
.define("PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS", .when(platforms: [.wasi])),
.define("PLATFORM_LACKS_FOUNDATION_PROPERTY_LIST_ENCODER", .when(platforms: [.wasi])),
.define("PLATFORM_LACKS_FOUNDATION_XML", .when(platforms: [.wasi, .android])),
.define(
  "PLATFORM_LACKS_FOUNDATION_XML_XML_DOCUMENT",
  .when(platforms: [.wasi, .tvOS, .iOS, .android, .watchOS])
),
.define("PLATFORM_LACKS_SWIFT_FLOAT_16", .when(platforms: [.macOS])),
.define(
  "PLATFORM_LACKS_SWIFT_FLOAT_80",
  .when(platforms: [.windows, .wasi, .tvOS, .iOS, .android, .watchOS])
),
```

## Importing

SDGCornerstone provides libraries for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGCornerstone as a dependency in `Package.swift` and specify which of the libraries to use:

```swift
let package = Package(
  name: "MyPackage",
  dependencies: [
    .package(
      name: "SDGCornerstone",
      url: "https://github.com/SDGGiesbrecht/SDGCornerstone",
      from: Version(10, 1, 0)
    ),
  ],
  targets: [
    .target(
      name: "MyTarget",
      dependencies: [
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGMathematicsTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGCollectionsTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGBinaryData", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGCollation", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
        .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGRandomization", package: "SDGCornerstone"),
        .product(name: "SDGRandomizationTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGGeometry", package: "SDGCornerstone"),
        .product(name: "SDGGeometryTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGCalendar", package: "SDGCornerstone"),
        .product(name: "SDGPrecisionMathematics", package: "SDGCornerstone"),
        .product(name: "SDGConcurrency", package: "SDGCornerstone"),
        .product(name: "SDGExternalProcess", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(name: "SDGXML", package: "SDGCornerstone"),
        .product(name: "SDGTesting", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    )
  ]
)
```

The modules can then be imported in source files:

```swift
import SDGControlFlow
import SDGLogic
import SDGLogicTestUtilities
import SDGMathematics
import SDGMathematicsTestUtilities
import SDGCollections
import SDGCollectionsTestUtilities
import SDGBinaryData
import SDGText
import SDGCollation
import SDGPersistence
import SDGPersistenceTestUtilities
import SDGRandomization
import SDGRandomizationTestUtilities
import SDGLocalization
import SDGLocalizationTestUtilities
import SDGGeometry
import SDGGeometryTestUtilities
import SDGCalendar
import SDGPrecisionMathematics
import SDGConcurrency
import SDGExternalProcess
import SDGVersioning
import SDGXML
import SDGTesting
import SDGXCTestUtilities
```

## About

The SDGCornerstone project is maintained by Jeremy David Giesbrecht.

If SDGCornerstone saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGCornerstone saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGCornerstone) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)
>
> [For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)
>
> ―‎ישוע/Yeshuʼa
