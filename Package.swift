// swift-tools-version:5.0

/*
 Package.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

/// SDGCornerstone forms the foundation of the SDG module family. It establishes design patterns and provides general‐use extensions to the [Swift Standard Library](https://developer.apple.com/reference/swift) and [Foundation](https://developer.apple.com/reference/foundation).
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
let package = Package(
    name: "SDGCornerstone",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .watchOS(.v4),
        .tvOS(.v11)
    ],
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

        // #documentation(SDGTesting)
        /// Miscellaneous test utilities.
        .library(name: "SDGTesting", targets: ["SDGTesting"]),

        // #documentation(SDGXCTestUtilities)
        /// Additional test utilities which require `XCTest`.
        .library(name: "SDGXCTestUtilities", targets: ["SDGXCTestUtilities"])
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
        .target(name: "SDGMathematics", dependencies: [
            "SDGControlFlow",
            "SDGLogic"
            ]),
        // @documentation(SDGMathematicsTestUtilities)
        /// Utilities for testing code which uses `SDGMathematics`.
        .target(name: "SDGMathematicsTestUtilities", dependencies: [
            "SDGMathematics", "SDGTesting",
            "SDGCollections",
            "SDGLogicTestUtilities",
            "SDGCollectionsTestUtilities",
            "SDGPersistenceTestUtilities"
            ]),

        // @documentation(SDGCollections)
        /// Pattern searching, set logic, and other extensions to collection types.
        .target(name: "SDGCollections", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics"
            ]),
        // @documentation(SDGCollectionsTestUtilities)
        /// Utilities for testing code which uses `SDGCollections`.
        .target(name: "SDGCollectionsTestUtilities", dependencies: [
            "SDGCollections", "SDGTesting",
            "SDGLogicTestUtilities"
            ]),

        // @documentation(SDGBinaryData)
        /// Extensions related to raw binary data.
        .target(name: "SDGBinaryData", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections"
            ]),

        // @documentation(SDGText)
        /// Extensions related to text and Unicode.
        .target(name: "SDGText", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections"
            ]),

        // @documentation(SDGPersistence)
        /// Preferences and simplified file system interactions.
        .target(name: "SDGPersistence", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGCollections",
            "SDGText"
            ], swiftSettings: [
                .define("DEBUG_DOMAINS", .when(configuration: .debug)),
                .define("PREFERENCE_WARNINGS", .when(configuration: .debug))
            ]),
        // @documentation(SDGPersistenceTestUtilities)
        /// Utilities for testing code which uses `SDGPersistence`.
        .target(name: "SDGPersistenceTestUtilities", dependencies: [
            "SDGPersistence", "SDGTesting",
            "SDGControlFlow",
            "SDGLogic",
            "SDGCollections",
            "SDGText",
            "SDGLocalization",
            "SDGCalendar",
            "SDGCornerstoneLocalizations"
            ]),

        // @documentation(SDGRandomization)
        /// Randomization tools.
        .target(name: "SDGRandomization", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics"
            ]),
        // @documentation(SDGRandomizationTestUtilities)
        /// Utilities for testing code which uses `SDGRandomization`.
        .target(name: "SDGRandomizationTestUtilities", dependencies: [
            "SDGRandomization", "SDGTesting"
            ]),

        // @documentation(SDGLocalization)
        /// Localization tools and locale information.
        .target(name: "SDGLocalization", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections",
            "SDGText",
            "SDGPersistence"
            ]),
        // @documentation(SDGLocalizationTestUtilities)
        /// Utilities for testing code which uses `SDGLocalization`.
        .target(name: "SDGLocalizationTestUtilities", dependencies: [
            "SDGLocalization", "SDGTesting",
            "SDGPersistenceTestUtilities"
            ]),

        // @documentation(SDGGeometry)
        /// Extensions related to geometry.
        .target(name: "SDGGeometry", dependencies: [
            "SDGControlFlow",
            "SDGMathematics"
            ]),
        // @documentation(SDGGeometryTestUtilities)
        /// Utilities for testing code which uses `SDGGeometry`.
        .target(name: "SDGGeometryTestUtilities", dependencies: [
            "SDGGeometry", "SDGTesting",
            "SDGMathematicsTestUtilities"
            ]),

        // @documentation(SDGCalendar)
        /// Tools for working with human calendar systems.
        .target(name: "SDGCalendar", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections",
            "SDGText",
            "SDGLocalization",
            "SDGCornerstoneLocalizations"
            ]),

        // @documentation(SDGPrecisionMathematics)
        /// Arbitrary‐precision number types.
        .target(name: "SDGPrecisionMathematics", dependencies: [
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections",
            "SDGBinaryData",
            "SDGText",
            "SDGLocalization",
            "SDGCornerstoneLocalizations"
            ]),

        // @documentation(SDGConcurrency)
        /// Concurrency and threading tools.
        .target(name: "SDGConcurrency", dependencies: [
            "SDGControlFlow",
            "SDGLogic"
            ]),

        // @documentation(SDGExternalProcess)
        /// Tools for running external processes and shell commands.
        .target(name: "SDGExternalProcess", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGPersistence",
            "SDGLocalization"
            ]),

        // @documentation(SDGTesting)
        /// Miscellaneous test utilities.
        .target(name: "SDGTesting", dependencies: [
            "SDGControlFlow",
            "SDGMathematics",
            "SDGLocalization",
            "SDGCornerstoneLocalizations"
            ]),

        // @documentation(SDGXCTestUtilities)
        /// Additional test utilities which require `XCTest`.
        .target(name: "SDGXCTestUtilities", dependencies: [
            "SDGTesting",
            "SDGLogic",
            "SDGPersistence"
            ]),

        // Internal utilities.

        .target(name: "SDGCornerstoneLocalizations", dependencies: [
            "SDGControlFlow",
            "SDGLocalization"
            ]),

        // Internal tests.

        .testTarget(name: "SDGControlFlowTests", dependencies: [
            "SDGControlFlow", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGLogicTests", dependencies: [
            "SDGLogicTestUtilities", "SDGXCTestUtilities",
            "SDGMathematicsTestUtilities"
            ]),
        .testTarget(name: "SDGBinaryDataTests", dependencies: [
            "SDGBinaryData", "SDGXCTestUtilities",
            "SDGCornerstoneLocalizations",
            "SDGMathematicsTestUtilities",
            "SDGLocalizationTestUtilities"
            ]),
        .testTarget(name: "SDGMathematicsTests", dependencies: [
            "SDGMathematicsTestUtilities", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGCollectionsTests", dependencies: [
            "SDGCollectionsTestUtilities", "SDGXCTestUtilities",
            "SDGMathematics",
            "SDGCornerstoneLocalizations",
            "SDGLocalizationTestUtilities"
            ]),
        .testTarget(name: "SDGTextTests", dependencies: [
            "SDGText", "SDGXCTestUtilities",
            "SDGCornerstoneLocalizations",
            "SDGMathematicsTestUtilities",
            "SDGCollectionsTestUtilities",
            "SDGPersistenceTestUtilities",
            "SDGLocalizationTestUtilities"
            ]),
        .testTarget(name: "SDGPersistenceTests", dependencies: [
            "SDGPersistenceTestUtilities", "SDGXCTestUtilities",
            "SDGCollections",
            "SDGText",
            "SDGCornerstoneLocalizations",
            "SDGExternalProcess",
            "SDGLocalizationTestUtilities"
            ]),
        .testTarget(name: "SDGRandomizationTests", dependencies: [
            "SDGRandomizationTestUtilities", "SDGXCTestUtilities",
            "SDGLogic",
            "SDGMathematics"
            ]),
        .testTarget(name: "SDGLocalizationTests", dependencies: [
            "SDGLocalizationTestUtilities", "SDGXCTestUtilities",
            "SDGLogic",
            "SDGCollections",
            "SDGPrecisionMathematics",
            "SDGCornerstoneLocalizations",
            "SDGPersistenceTestUtilities"
            ]),
        .testTarget(name: "SDGGeometryTests", dependencies: [
            "SDGGeometryTestUtilities", "SDGXCTestUtilities",
            "SDGMathematicsTestUtilities"
            ]),
        .testTarget(name: "SDGCalendarTests", dependencies: [
            "SDGCalendar", "SDGXCTestUtilities",
            "SDGCornerstoneLocalizations",
            "SDGMathematicsTestUtilities",
            "SDGPersistenceTestUtilities",
            "SDGLocalizationTestUtilities"
            ]),
        .testTarget(name: "SDGPrecisionMathematicsTests", dependencies: [
            "SDGPrecisionMathematics", "SDGXCTestUtilities",
            "SDGBinaryData",
            "SDGCornerstoneLocalizations",
            "SDGMathematicsTestUtilities",
            "SDGPersistenceTestUtilities",
            "SDGLocalizationTestUtilities"
            ]),
        .testTarget(name: "SDGConcurrencyTests", dependencies: [
            "SDGConcurrency", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGExternalProcessTests", dependencies: [
            "SDGExternalProcess", "SDGXCTestUtilities",
            "SDGLogic"
            ]),
        .testTarget(name: "SDGCornerstoneDocumentationExampleTests", dependencies: [
            "SDGPersistenceTestUtilities",
            "SDGXCTestUtilities"
        ])
    ]
)
