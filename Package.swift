// swift-tools-version:4.0

/*
 Package.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

let package = Package(
    name: "SDGCornerstone",
    products: [
        // The entire package.

        .library(name: "SDGCornerstone", targets: ["SDGCornerstone"]),
        .library(name: "SDGCornerstoneTestUtlities", targets: ["SDGCornerstoneTestUtilities"]),

        // Individual component modules.

        .library(name: "SDGControlFlow", targets: ["SDGControlFlow"]),

        .library(name: "SDGLogic", targets: ["SDGLogic"]),
        .library(name: "SDGLogicTestUtilities", targets: ["SDGLogicTestUtilities"]),

        .library(name: "SDGMathematics", targets: ["SDGMathematics"]),
        .library(name: "SDGMathematicsTestUtilities", targets: ["SDGMathematicsTestUtilities"]),

        .library(name: "SDGCollections", targets: ["SDGCollections"]),
        .library(name: "SDGCollectionsTestUtilities", targets: ["SDGCollectionsTestUtilities"]),

        .library(name: "SDGBinaryData", targets: ["SDGBinaryData"]),

        .library(name: "SDGText", targets: ["SDGText"]),

        .library(name: "SDGPersistence", targets: ["SDGPersistence"]),
        .library(name: "SDGPersistenceTestUtilities", targets: ["SDGPersistenceTestUtilities"]),

        .library(name: "SDGRandomization", targets: ["SDGRandomization"]),
        .library(name: "SDGRandomizationTestUtilities", targets: ["SDGRandomizationTestUtilities"]),

        .library(name: "SDGLocalization", targets: ["SDGLocalization"]),
        .library(name: "SDGLocalizationTestUtilities", targets: ["SDGLocalizationTestUtilities"]),

        .library(name: "SDGGeometry", targets: ["SDGGeometry"]),

        .library(name: "SDGCalendar", targets: ["SDGCalendar"]),

        .library(name: "SDGPrecisionMathematics", targets: ["SDGPrecisionMathematics"]),

        .library(name: "SDGConcurrency", targets: ["SDGConcurrency"]),

        .library(name: "SDGExternalProcess", targets: ["SDGExternalProcess"]),

        .library(name: "SDGTesting", targets: ["SDGTesting"]),
    ],
    targets: [
        // The entire package.

        .target(name: "SDGCornerstone", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections",
            "SDGBinaryData",
            "SDGText",
            "SDGPersistence",
            "SDGRandomization",
            "SDGLocalization",
            "SDGGeometry",
            "SDGCalendar",
            "SDGPrecisionMathematics",
            "SDGConcurrency",
            "SDGExternalProcess",
            ]),
        .target(name: "SDGCornerstoneTestUtilities", dependencies: [
            "SDGLogicTestUtilities",
            "SDGMathematicsTestUtilities",
            "SDGCollectionsTestUtilities",
            "SDGPersistenceTestUtilities",
            "SDGRandomizationTestUtilities",
            "SDGLocalizationTestUtilities",

            "SDGCornerstone",
            "SDGTesting"
            ]),
        .target(name: "SDGXCTestUtilities", dependencies: [
            "SDGTesting",
            "SDGLogic",
            "SDGPersistence"
            ]),

        // Individual component modules.

        .target(name: "SDGControlFlow"),

        .target(name: "SDGLogic", dependencies: []),
        .target(name: "SDGLogicTestUtilities", dependencies: ["SDGLogic", "SDGTesting"]),

        .target(name: "SDGMathematics", dependencies: [
            "SDGControlFlow",
            "SDGLogic"
            ]),
        .target(name: "SDGMathematicsTestUtilities", dependencies: [
            "SDGMathematics", "SDGTesting",
            "SDGLogicTestUtilities",
            "SDGCollectionsTestUtilities",
            "SDGPersistenceTestUtilities"
            ]),

        .target(name: "SDGCollections", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics"
            ]),
        .target(name: "SDGCollectionsTestUtilities", dependencies: [
            "SDGCollections", "SDGTesting",
            "SDGLogicTestUtilities"
            ]),

        .target(name: "SDGBinaryData", dependencies: [
            "SDGControlFlow",
            "SDGMathematics",
            "SDGCollections"
            ]),

        .target(name: "SDGText", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections"
            ]),

        .target(name: "SDGPersistence", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGCollections",
            "SDGText"
            ]),
        .target(name: "SDGPersistenceTestUtilities", dependencies: [
            "SDGPersistence", "SDGTesting",
            "SDGControlFlow",
            "SDGLogic",
            "SDGText",
            "SDGCollections",
            "SDGLocalization",
            "SDGCalendar",
            "SDGCornerstoneLocalizations"
            ]),

        .target(name: "SDGRandomization", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics"
            ]),
        .target(name: "SDGRandomizationTestUtilities", dependencies: [
            "SDGRandomization", "SDGTesting"
            ]),

        .target(name: "SDGLocalization", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections",
            "SDGText",
            "SDGPersistence",
            "SDGRandomization"
            ]),
        .target(name: "SDGLocalizationTestUtilities", dependencies: [
            "SDGLocalization", "SDGTesting",
            "SDGPersistenceTestUtilities"
            ]),

        .target(name: "SDGGeometry", dependencies: [
            "SDGControlFlow",
            "SDGMathematics"
            ]),

        .target(name: "SDGCalendar", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections",
            "SDGText",
            "SDGLocalization",
            "SDGCornerstoneLocalizations"
            ]),

        .target(name: "SDGPrecisionMathematics", dependencies: [
            "SDGLogic",
            "SDGMathematics",
            "SDGCollections",
            "SDGBinaryData",
            "SDGRandomization",
            "SDGLocalization",
            "SDGCornerstoneLocalizations"
            ]),

        .target(name: "SDGConcurrency", dependencies: [
            "SDGLogic"
            ]),

        .target(name: "SDGExternalProcess", dependencies: [
            "SDGLogic",
            "SDGPersistence",
            "SDGLocalization"
            ]),

        .target(name: "SDGTesting", dependencies: [
            "SDGMathematics",
            "SDGLocalization",
            "SDGCornerstoneLocalizations"
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
            "SDGMathematicsTestUtilities"
            ]),
        .testTarget(name: "SDGMathematicsTests", dependencies: [
            "SDGMathematicsTestUtilities", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGCollectionsTests", dependencies: [
            "SDGCollectionsTestUtilities", "SDGXCTestUtilities",
            "SDGMathematics"
            ]),
        .testTarget(name: "SDGTextTests", dependencies: [
            "SDGText", "SDGXCTestUtilities",
            "SDGMathematicsTestUtilities",
            "SDGCollectionsTestUtilities",
            "SDGPersistenceTestUtilities"
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
            "SDGPrecisionMathematics",
            "SDGCornerstoneLocalizations"
            ]),
        .testTarget(name: "SDGGeometryTests", dependencies: [
            "SDGGeometry", "SDGXCTestUtilities",
            "SDGMathematicsTestUtilities"
            ]),
        .testTarget(name: "SDGCalendarTests", dependencies: [
            "SDGCalendar", "SDGXCTestUtilities",
            "SDGMathematicsTestUtilities",
            "SDGPersistenceTestUtilities"
            ]),
        .testTarget(name: "SDGPrecisionMathematicsTests", dependencies: [
            "SDGPrecisionMathematics", "SDGXCTestUtilities",
            "SDGBinaryData",
            "SDGMathematicsTestUtilities",
            "SDGPersistenceTestUtilities"
            ]),
        .testTarget(name: "SDGConcurrencyTests", dependencies: [
            "SDGConcurrency", "SDGXCTestUtilities",
            ]),
        .testTarget(name: "SDGExternalProcessTests", dependencies: [
            "SDGExternalProcess", "SDGXCTestUtilities",
            "SDGLogic"
            ]),
        .testTarget(name: "DocumentationExampleTests", dependencies: [
            "SDGCornerstone", "SDGXCTestUtilities",
            "SDGPersistenceTestUtilities"
        ]),

        // To run these tests, uncomment the following and run the executable in the release configuration.
        /*.target(name: "performance‐tests", dependencies: [
            "SDGTesting",

            "SDGText",
            "SDGPrecisionMathematics"
            ])*/
    ]
)
