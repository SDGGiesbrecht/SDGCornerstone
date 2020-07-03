// swift-tools-version:5.2

/*
 Package.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

// #example(1, readMe🇨🇦EN)
/// SDGCornerstone forms the foundation of the SDG module family; it establishes design patterns and provides general‐use extensions to the [Swift Standard Library](https://developer.apple.com/reference/swift) and [Foundation](https://developer.apple.com/reference/foundation).
///
/// > [הִנְנִי יִסַּד בְּצִיּוֹן אָבֶן אֶבֶן בֹּחַן פִּנַּת יִקְרַת מוּסָד מוּסָד׃](https://www.biblegateway.com/passage/?search=Isaiah+28&version=WLC;NIV)
/// >
/// > [Behold, I establish in Zion a stone, a tested stone, a precious cornerstone, a sure foundation.](https://www.biblegateway.com/passage/?search=Isaiah+28&version=WLC;NIV)
/// >
/// > ―⁧יהוה⁩/Yehova
///
/// ### Features:
///
/// - Localization tools compatible with the Swift Package Manager and Linux. (`SDGLocalization`)
/// - User preferences compatible with Linux. (`PreferenceSet`, `Preference`)
/// - Platform‐independent access to best‐practice file system locations. (`url(for:in:at:)`)
/// - Shared instances of value types. (`Shared<Value>`)
/// - Generic pattern matching. (`SearchableCollection`, `Pattern<Element>`)
/// - Customizable randomization. (`SDGRandomization`)
/// - Arbitrary‐precision arithmetic. (`SDGPrecisionMathematics`)
/// - A simple API for running shell commands on desktop platforms. (`SDGExternalProcess`)
///
/// ...and much more.
///
/// ### Example Usage
///
/// ```swift
/// // ••••••• Localization •••••••
///
/// enum ApplicationLocalization: String, Localization {
///   case english = "en"
///   case français = "fr"
///   static let fallbackLocalization = ApplicationLocalization.english
/// }
///
/// // Define
/// let text = UserFacing<StrictString, ApplicationLocalization>({ localization in
///   switch localization {
///   case .english:
///     return "Hello, world!"
///   case .français:
///     return "Bonjour, le monde !"
///   }
/// })
///
/// // Use
/// XCTAssertEqual(
///   text.resolved(),
///   "Hello, world!"
/// )
///
/// // ••••••• Preferences •••••••
///
/// let preferences = PreferenceSet.applicationPreferences
///
/// // Save
/// preferences["name"].value.set(to: "John Doe")
/// // Load
/// let loaded: String? = preferences["name"].value.as(String.self)
///
/// XCTAssertEqual(
///   loaded,
///   "John Doe"
/// )
///
/// // ••••••• File System •••••••
///
/// let url = FileManager.default.url(in: .applicationSupport, at: "folder/file.txt")
/// do {
///   // Save
///   try "Contents".save(to: url)
///   // Load
///   let loaded = try String(from: url)
///
///   XCTAssertEqual(
///     loaded,
///     "Contents"
///   )
/// } catch {
///   XCTFail(error.localizedDescription)
/// }
///
/// // ••••••• Shared Values •••••••
///
/// class Owner {
///   @SharedProperty var property: String = ""
/// }
///
/// let originalOwner = Owner()
/// originalOwner.property = "original"
/// let anotherOwner = Owner()
/// anotherOwner.$property = originalOwner.$property
///
/// anotherOwner.property = "changed"
/// XCTAssertEqual(
///   originalOwner.property,
///   "changed"
/// )
///
/// // ••••••• Pattern Matching •••••••
///
/// let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
/// let patternFirstPart =
///   [1]  // 1
///   + ConditionalPattern({ $0.isEven })  // 2
///   + ([30, 40]  // (∅)
///     ∨ [3, 4])  // 3, 4
/// let pattern =
///   patternFirstPart
///   + RepetitionPattern(¬[5, 7])  // 5, 6, 7, 8, 9 (...)
///   + [10]  // 10
///
/// XCTAssertEqual(
///   numbers.firstMatch(for: pattern)?.range,
///   numbers.startIndex..<numbers.endIndex
/// )
///
/// // ••••••• Arbitrary Precision Arithmetic •••••••
///
/// let tenDuotrigintillion: WholeNumber =
///   "10 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000"
/// XCTAssert(tenDuotrigintillion.isDivisible(by: 10))
///
/// #if !(os(iOS) || os(watchOS) || os(tvOS))
///
///   // ••••••• Shell Commands •••••••
///
///   XCTAssertEqual(
///     try? Shell.default.run(command: ["echo", "Hello, world!"]).get(),
///     "Hello, world!"
///   )
/// #endif
/// ```
let package = Package(
  name: "SDGCornerstone",
  products: [

    // #documentation(SDGControlFlow)
    /// Very low‐level abstractions which can be used to reduce boilerplate code and simplify control flow.
    .library(name: "SDGControlFlow", targets: ["SDGControlFlow"]),

    // #documentation(SDGLogic)
    /// Extensions to related to Boolean logic.
    .library(name: "SDGLogic", targets: ["SDGLogic"]),
    // #documentation(SDGLogicTestUtilities)
    /// Utilities for testing code which uses `SDGLogic`.
    .library(name: "SDGLogicTestUtilities", targets: ["SDGLogicTestUtilities"]),

    // #documentation(SDGMathematics)
    /// A hierarchy of mathematical protocols and extensions to number types.
    .library(name: "SDGMathematics", targets: ["SDGMathematics"]),
    // #documentation(SDGMathematicsTestUtilities)
    /// Utilities for testing code which uses `SDGMathematics`.
    .library(name: "SDGMathematicsTestUtilities", targets: ["SDGMathematicsTestUtilities"]),

    // #documentation(SDGCollections)
    /// Pattern searching, set logic, and other extensions to collection types.
    .library(name: "SDGCollections", targets: ["SDGCollections"]),
    // #documentation(SDGCollectionsTestUtilities)
    /// Utilities for testing code which uses `SDGCollections`.
    .library(name: "SDGCollectionsTestUtilities", targets: ["SDGCollectionsTestUtilities"]),

    // #documentation(SDGBinaryData)
    /// Extensions related to raw binary data.
    .library(name: "SDGBinaryData", targets: ["SDGBinaryData"]),

    // #documentation(SDGText)
    /// Extensions related to text and Unicode.
    .library(name: "SDGText", targets: ["SDGText"]),

    // #documentatino(SDGCollation)
    /// Text collation.
    ///
    /// This product is distinct from SDGText, because its required Unicode data take a lot of space.
    .library(name: "SDGCollation", targets: ["SDGCollation"]),

    // #documentation(SDGPersistence)
    /// Preferences and simplified file system interactions.
    .library(name: "SDGPersistence", targets: ["SDGPersistence"]),
    // #documentation(SDGPersistenceTestUtilities)
    /// Utilities for testing code which uses `SDGPersistence`.
    .library(name: "SDGPersistenceTestUtilities", targets: ["SDGPersistenceTestUtilities"]),

    // #documentation(SDGRandomization)
    /// Randomization tools.
    .library(name: "SDGRandomization", targets: ["SDGRandomization"]),
    // #documentation(SDGRandomizationTestUtilities)
    /// Utilities for testing code which uses `SDGRandomization`.
    .library(name: "SDGRandomizationTestUtilities", targets: ["SDGRandomizationTestUtilities"]),

    // #documentation(SDGLocalization)
    /// Localization tools and locale information.
    .library(name: "SDGLocalization", targets: ["SDGLocalization"]),
    // #documentation(SDGLocalizationTestUtilities)
    /// Utilities for testing code which uses `SDGLocalization`.
    .library(name: "SDGLocalizationTestUtilities", targets: ["SDGLocalizationTestUtilities"]),

    // #documentation(SDGGeometry)
    /// Extensions related to geometry.
    .library(name: "SDGGeometry", targets: ["SDGGeometry"]),
    // #documentation(SDGGeometryTestUtilities)
    /// Utilities for testing code which uses `SDGGeometry`.
    .library(name: "SDGGeometryTestUtilities", targets: ["SDGGeometryTestUtilities"]),

    // #documentation(SDGCalendar)
    /// Tools for working with human calendar systems.
    .library(name: "SDGCalendar", targets: ["SDGCalendar"]),

    // #documentation(SDGPrecisionMathematics)
    /// Arbitrary‐precision number types.
    .library(name: "SDGPrecisionMathematics", targets: ["SDGPrecisionMathematics"]),

    // #documentation(SDGConcurrency)
    /// Concurrency and threading tools.
    .library(name: "SDGConcurrency", targets: ["SDGConcurrency"]),

    // #documentation(SDGExternalProcess)
    /// Tools for running external processes and shell commands.
    .library(name: "SDGExternalProcess", targets: ["SDGExternalProcess"]),

    // #documentation(SDGVersioning)
    /// Utilities for working with semantic versions.
    .library(name: "SDGVersioning", targets: ["SDGVersioning"]),

    // #documentation(SDGTesting)
    /// Miscellaneous test utilities.
    .library(name: "SDGTesting", targets: ["SDGTesting"]),

    // #documentation(SDGXCTestUtilities)
    /// Additional test utilities which require `XCTest`.
    .library(name: "SDGXCTestUtilities", targets: ["SDGXCTestUtilities"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift\u{2D}numerics", .exact(Version(0, 0, 6)))
  ],
  targets: [

    // @documentation(SDGControlFlow)
    /// Very low‐level abstractions which can be used to reduce boilerplate code and simplify control flow.
    .target(name: "SDGControlFlow"),

    // @documentation(SDGLogic)
    /// Extensions to related to Boolean logic.
    .target(name: "SDGLogic", dependencies: []),
    // @documentation(SDGLogicTestUtilities)
    /// Utilities for testing code which uses `SDGLogic`.
    .target(name: "SDGLogicTestUtilities", dependencies: ["SDGLogic", "SDGTesting"]),

    // @documentation(SDGMathematics)
    /// A hierarchy of mathematical protocols and extensions to number types.
    .target(
      name: "SDGMathematics",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        .product(name: "RealModule", package: "swift\u{2D}numerics"),
      ]
    ),
    // @documentation(SDGMathematicsTestUtilities)
    /// Utilities for testing code which uses `SDGMathematics`.
    .target(
      name: "SDGMathematicsTestUtilities",
      dependencies: [
        "SDGMathematics", "SDGTesting",
        "SDGCollections",
        "SDGLogicTestUtilities",
        "SDGCollectionsTestUtilities",
        "SDGPersistenceTestUtilities",
      ]
    ),

    // @documentation(SDGCollections)
    /// Pattern searching, set logic, and other extensions to collection types.
    .target(
      name: "SDGCollections",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
      ]
    ),
    // @documentation(SDGCollectionsTestUtilities)
    /// Utilities for testing code which uses `SDGCollections`.
    .target(
      name: "SDGCollectionsTestUtilities",
      dependencies: [
        "SDGCollections", "SDGTesting",
        "SDGLogicTestUtilities",
      ]
    ),

    // @documentation(SDGBinaryData)
    /// Extensions related to raw binary data.
    .target(
      name: "SDGBinaryData",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
      ]
    ),

    // @documentation(SDGText)
    /// Extensions related to text and Unicode.
    .target(
      name: "SDGText",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
      ]
    ),
    // @documentation(SDGCollation)
    /// Text collation.
    ///
    /// This product is distinct from SDGText, because its required Unicode data take a lot of space.
    .target(
      name: "SDGCollation",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
        "SDGPersistence",
      ]
    ),

    // @documentation(SDGPersistence)
    /// Preferences and simplified file system interactions.
    .target(
      name: "SDGPersistence",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
      ]
    ),
    // @documentation(SDGPersistenceTestUtilities)
    /// Utilities for testing code which uses `SDGPersistence`.
    .target(
      name: "SDGPersistenceTestUtilities",
      dependencies: [
        "SDGPersistence", "SDGTesting",
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
        "SDGLocalization",
        "SDGCalendar",
        "SDGCornerstoneLocalizations",
      ]
    ),

    // @documentation(SDGRandomization)
    /// Randomization tools.
    .target(
      name: "SDGRandomization",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
      ]
    ),
    // @documentation(SDGRandomizationTestUtilities)
    /// Utilities for testing code which uses `SDGRandomization`.
    .target(
      name: "SDGRandomizationTestUtilities",
      dependencies: [
        "SDGRandomization", "SDGTesting",
      ]
    ),

    // @documentation(SDGLocalization)
    /// Localization tools and locale information.
    .target(
      name: "SDGLocalization",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
        "SDGPersistence",
      ]
    ),
    // @documentation(SDGLocalizationTestUtilities)
    /// Utilities for testing code which uses `SDGLocalization`.
    .target(
      name: "SDGLocalizationTestUtilities",
      dependencies: [
        "SDGLocalization", "SDGTesting",
        "SDGText",
        "SDGPersistence",
        "SDGPersistenceTestUtilities",
      ]
    ),

    // @documentation(SDGGeometry)
    /// Extensions related to geometry.
    .target(
      name: "SDGGeometry",
      dependencies: [
        "SDGControlFlow",
        "SDGMathematics",
      ]
    ),
    // @documentation(SDGGeometryTestUtilities)
    /// Utilities for testing code which uses `SDGGeometry`.
    .target(
      name: "SDGGeometryTestUtilities",
      dependencies: [
        "SDGGeometry", "SDGTesting",
        "SDGMathematicsTestUtilities",
      ]
    ),

    // @documentation(SDGCalendar)
    /// Tools for working with human calendar systems.
    .target(
      name: "SDGCalendar",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
        "SDGLocalization",
        "SDGCornerstoneLocalizations",
      ]
    ),

    // @documentation(SDGPrecisionMathematics)
    /// Arbitrary‐precision number types.
    .target(
      name: "SDGPrecisionMathematics",
      dependencies: [
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGBinaryData",
        "SDGText",
        "SDGLocalization",
        "SDGCornerstoneLocalizations",
      ]
    ),

    // @documentation(SDGConcurrency)
    /// Concurrency and threading tools.
    .target(
      name: "SDGConcurrency",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
      ]
    ),

    // @documentation(SDGExternalProcess)
    /// Tools for running external processes and shell commands.
    .target(
      name: "SDGExternalProcess",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGText",
        "SDGPersistence",
        "SDGLocalization",
      ]
    ),

    // @documentation(SDGVersioning)
    /// Utilities for working with semantic versions.
    .target(
      name: "SDGVersioning",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
        "SDGLocalization",
        "SDGCornerstoneLocalizations",
      ]
    ),

    // @documentation(SDGTesting)
    /// Miscellaneous test utilities.
    .target(
      name: "SDGTesting",
      dependencies: [
        "SDGControlFlow",
        "SDGMathematics",
        "SDGText",
        "SDGLocalization",
        "SDGCornerstoneLocalizations",
      ]
    ),

    // @documentation(SDGXCTestUtilities)
    /// Additional test utilities which require `XCTest`.
    .target(
      name: "SDGXCTestUtilities",
      dependencies: [
        "SDGTesting",
        "SDGLogic",
        "SDGMathematics",
        "SDGText",
        "SDGPersistence",
      ]
    ),

    // Internal modules.

    .target(
      name: "SDGCornerstoneLocalizations",
      dependencies: [
        "SDGControlFlow",
        "SDGLocalization",
      ]
    ),

    // Internal utilities.

    .target(
      name: "generate‐root‐collation",
      dependencies: [
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
        "SDGCollation",
        "SDGPersistence",
        "SDGLocalization",
      ]
    ),

    // Internal tests.

    .testTarget(
      name: "SDGControlFlowTests",
      dependencies: [
        "SDGControlFlow", "SDGTesting", "SDGXCTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGLogicTests",
      dependencies: [
        "SDGLogic", "SDGLogicTestUtilities", "SDGTesting", "SDGXCTestUtilities",
        "SDGMathematicsTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGBinaryDataTests",
      dependencies: [
        "SDGBinaryData", "SDGTesting", "SDGXCTestUtilities",
        "SDGLogic",
        "SDGCornerstoneLocalizations",
        "SDGMathematicsTestUtilities",
        "SDGLocalizationTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGMathematicsTests",
      dependencies: [
        "SDGMathematics", "SDGMathematicsTestUtilities", "SDGTesting", "SDGXCTestUtilities",
        "SDGLogic",
      ]
    ),
    .testTarget(
      name: "SDGCollectionsTests",
      dependencies: [
        "SDGCollections", "SDGCollectionsTestUtilities", "SDGTesting", "SDGXCTestUtilities",
        "SDGLogic",
        "SDGMathematics",
        "SDGCornerstoneLocalizations",
        "SDGPersistenceTestUtilities",
        "SDGLocalizationTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGTextTests",
      dependencies: [
        "SDGText", "SDGTesting", "SDGXCTestUtilities",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGCornerstoneLocalizations",
        "SDGMathematicsTestUtilities",
        "SDGCollectionsTestUtilities",
        "SDGPersistenceTestUtilities",
        "SDGLocalizationTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGCollationTests",
      dependencies: [
        "SDGText",
        "SDGCollation",
        "SDGXCTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGPersistenceTests",
      dependencies: [
        "SDGPersistence", "SDGPersistenceTestUtilities", "SDGTesting", "SDGXCTestUtilities",
        "SDGLogic",
        "SDGCollections",
        "SDGText",
        "SDGLocalization",
        "SDGExternalProcess",
        "SDGCornerstoneLocalizations",
        "SDGLocalizationTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGRandomizationTests",
      dependencies: [
        "SDGRandomization", "SDGRandomizationTestUtilities", "SDGTesting", "SDGXCTestUtilities",
        "SDGLogic",
        "SDGMathematics",
      ]
    ),
    .testTarget(
      name: "SDGLocalizationTests",
      dependencies: [
        "SDGLocalization", "SDGLocalizationTestUtilities", "SDGTesting", "SDGXCTestUtilities",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
        "SDGPersistence",
        "SDGPrecisionMathematics",
        "SDGCornerstoneLocalizations",
        "SDGPersistenceTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGGeometryTests",
      dependencies: [
        "SDGGeometry", "SDGGeometryTestUtilities", "SDGTesting", "SDGXCTestUtilities",
        "SDGMathematics",
        "SDGMathematicsTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGCalendarTests",
      dependencies: [
        "SDGCalendar", "SDGTesting", "SDGXCTestUtilities",
        "SDGMathematics",
        "SDGLocalization",
        "SDGCornerstoneLocalizations",
        "SDGMathematicsTestUtilities",
        "SDGPersistenceTestUtilities",
        "SDGLocalizationTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGPrecisionMathematicsTests",
      dependencies: [
        "SDGPrecisionMathematics", "SDGTesting", "SDGXCTestUtilities",
        "SDGMathematics",
        "SDGBinaryData",
        "SDGCornerstoneLocalizations",
        "SDGMathematicsTestUtilities",
        "SDGPersistenceTestUtilities",
        "SDGLocalizationTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGConcurrencyTests",
      dependencies: [
        "SDGConcurrency", "SDGTesting", "SDGXCTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGExternalProcessTests",
      dependencies: [
        "SDGExternalProcess", "SDGTesting", "SDGXCTestUtilities",
        "SDGLogic",
      ]
    ),
    .testTarget(
      name: "SDGVersioningTests",
      dependencies: [
        "SDGVersioning", "SDGTesting", "SDGXCTestUtilities",
        "SDGCornerstoneLocalizations",
        "SDGLocalizationTestUtilities",
      ]
    ),
    .testTarget(
      name: "SDGCornerstoneDocumentationExampleTests",
      dependencies: [
        "SDGControlFlow",
        "SDGLogic",
        "SDGMathematics",
        "SDGCollections",
        "SDGText",
        "SDGPersistence",
        "SDGRandomization",
        "SDGLocalization",
        "SDGCalendar",
        "SDGConcurrency",
        "SDGPrecisionMathematics",
        "SDGExternalProcess",
        "SDGPersistenceTestUtilities",
        "SDGXCTestUtilities",
      ]
    ),
  ]
)

// #workaround(Swift 5.2.4, The generated Xcode project cannot import XCTest on iOS devices.)
import Foundation
let path = ProcessInfo.processInfo.environment["PATH"] ?? ""
let firstColon = path.range(of: ":")?.lowerBound ?? path.endIndex
let firstEntry = path[..<firstColon]
if firstEntry.hasSuffix("/Contents/Developer/usr/bin") {
  let sdgXCTestUtilities = package.targets.first(where: { $0.name == "SDGXCTestUtilities" })!
  var settings = sdgXCTestUtilities.swiftSettings ?? []
  settings.append(.define("MANIFEST_LOADED_BY_XCODE"))
  sdgXCTestUtilities.swiftSettings = settings
}

// #workaround(Swift 5.2.4, The generated Xcode project cannot handle tools when building for iOS.)
func disableDevelopmentTools() {
  package.targets.removeAll(where: { $0.name == "generate‐root‐collation" })
}
#if os(macOS)
  disableDevelopmentTools()
#endif

func adjustForWindows() {
  // #workaround(workspace version 0.33.1, CMake cannot handle Unicode.)
  disableDevelopmentTools()

  for target in package.targets {
    target.dependencies.removeAll(where: { dependency in
      // #workaround(workspace version 0.33.1, Windows does not support C.)
      return "\(dependency)".contains("RealModule")
    })
  }
}
#if os(Windows)
  adjustForWindows()
#endif
if ProcessInfo.processInfo.environment["GENERATING_CMAKE_FOR_WINDOWS"] == "true" {
  adjustForWindows()
}

if ProcessInfo.processInfo.environment["TARGETING_WEB"] == "true" {
  for target in package.targets {
    // #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
    target.exclude.append("Resources.swift")
  }

}
