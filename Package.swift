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
        .library(name: "SDGTextTestUtilities", targets: ["SDGTextTestUtilities"]),

        .library(name: "SDGPersistence", targets: ["SDGPersistence"]),
        .library(name: "SDGPersistenceTestUtilities", targets: ["SDGPersistenceTestUtilities"]),

        .library(name: "SDGRandomization", targets: ["SDGRandomization"]),
        .library(name: "SDGRandomizationTestUtilities", targets: ["SDGRandomizationTestUtilities"]),

        .library(name: "SDGLocalization", targets: ["SDGLocalization"]),
        .library(name: "SDGLocalizationTestUtilities", targets: ["SDGLocalizationTestUtilities"]),

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

            "SDGCornerstoneLocalizations" // [_Warning: Temporary._]
            ]),
        .target(name: "SDGCornerstoneTestUtilities", dependencies: [
            "SDGLogicTestUtilities",
            "SDGMathematicsTestUtilities",
            "SDGCollectionsTestUtilities",
            "SDGTextTestUtilities",
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
            "SDGLogicTestUtilities"
            ]),

        .target(name: "SDGCollections", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGMathematics"
            ]),
        .target(name: "SDGCollectionsTestUtilities", dependencies: ["SDGCollections", "SDGTesting"]),

        .target(name: "SDGBinaryData", dependencies: []),

        .target(name: "SDGText", dependencies: [
            "SDGControlFlow",
            "SDGCollections"
            ]),
        .target(name: "SDGTextTestUtilities", dependencies: ["SDGText", "SDGTesting"]),

        .target(name: "SDGPersistence", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGCollections",
            "SDGText"
            ]),
        .target(name: "SDGPersistenceTestUtilities", dependencies: ["SDGPersistence", "SDGTesting"]),

        .target(name: "SDGRandomization", dependencies: [
            "SDGControlFlow",
            "SDGMathematics"
            ]),
        .target(name: "SDGRandomizationTestUtilities", dependencies: [
            "SDGRandomization", "SDGTesting"
            ]),

        .target(name: "SDGLocalization", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGText",
            "SDGPersistence",
            "SDGRandomization"
            ]),
        .target(name: "SDGLocalizationTestUtilities", dependencies: ["SDGLocalization", "SDGTesting"]),

        .target(name: "SDGTesting", dependencies: [
            "SDGMathematics",
            ]),

        // Internal utilities.

        .target(name: "SDGCornerstoneLocalizations", dependencies: [
            "SDGControlFlow",
            "SDGLocalization"
            ]),

        // Internal tests.

        .testTarget(name: "SDGCornerstoneTests", dependencies: [
            "SDGCornerstoneTestUtilities", "SDGXCTestUtilities"
            ]),

        .testTarget(name: "SDGControlFlowTests", dependencies: [
            "SDGControlFlow", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGLogicTests", dependencies: [
            "SDGLogicTestUtilities", "SDGXCTestUtilities",
            "SDGMathematicsTestUtilities"
            ]),
        .testTarget(name: "SDGBinaryDataTests", dependencies: [
            "SDGBinaryData", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGMathematicsTests", dependencies: [
            "SDGMathematicsTestUtilities", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGCollectionsTests", dependencies: [
            "SDGCollectionsTestUtilities", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGTextTests", dependencies: [
            "SDGTextTestUtilities", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGPersistenceTests", dependencies: [
            "SDGPersistenceTestUtilities", "SDGXCTestUtilities",
            ]),
        .testTarget(name: "SDGRandomizationTests", dependencies: [
            "SDGRandomizationTestUtilities", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGLocalizationTests", dependencies: [
            "SDGLocalizationTestUtilities", "SDGXCTestUtilities",
            ]),

        .target(name: "performance‐tests", dependencies: [
            "SDGTesting",

            "SDGText"
            ])
    ]
)
