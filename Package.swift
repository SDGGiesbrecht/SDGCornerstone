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

        .library(name: "SDGProcessProperties", targets: ["SDGProcessProperties"]),

        .library(name: "SDGControlFlow", targets: ["SDGControlFlow"]),

        .library(name: "SDGLogic", targets: ["SDGLogic"]),
        .library(name: "SDGLogicTestUtilities", targets: ["SDGLogicTestUtilities"]),

        .library(name: "SDGBinaryData", targets: ["SDGBinaryData"]),
        .library(name: "SDGBinaryDataTestUtilities", targets: ["SDGBinaryDataTestUtilities"]),

        .library(name: "SDGMathematics", targets: ["SDGMathematics"]),
        .library(name: "SDGMathematicsTestUtilities", targets: ["SDGMathematicsTestUtilities"]),

        .library(name: "SDGCollections", targets: ["SDGCollections"]),
        .library(name: "SDGCollectionsTestUtilities", targets: ["SDGCollectionsTestUtilities"]),

        .library(name: "SDGText", targets: ["SDGText"]),
        .library(name: "SDGTextTestUtilities", targets: ["SDGTextTestUtilities"]),

        .library(name: "SDGPersistence", targets: ["SDGPersistence"]),
        .library(name: "SDGPersistenceTestUtilities", targets: ["SDGPersistenceTestUtilities"]),

        .library(name: "SDGLocalization", targets: ["SDGLocalization"]),
        .library(name: "SDGLocalizationTestUtilities", targets: ["SDGLocalizationTestUtilities"]),

        .library(name: "SDGTesting", targets: ["SDGTesting"]),

        // Core subsets.

        .library(name: "SDGLogicCore", targets: ["SDGLogicCore"]),
        .library(name: "SDGMathematicsCore", targets: ["SDGMathematicsCore"]),
        .library(name: "SDGCollectionsCore", targets: ["SDGCollectionsCore"]),
        .library(name: "SDGTextCore", targets: ["SDGTextCore"])
    ],
    targets: [
        // The entire package.

        .target(name: "SDGCornerstone", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGBinaryData",
            "SDGMathematics",
            "SDGCollections",
            "SDGText",
            "SDGPersistence",
            "SDGLocalization",
            "SDGProcessProperties",

            "SDGCornerstoneLocalizations" // [_Warning: Temporary._]
            ]),
        .target(name: "SDGCornerstoneTestUtilities", dependencies: [
            "SDGLogicTestUtilities",
            "SDGBinaryDataTestUtilities",
            "SDGMathematicsTestUtilities",
            "SDGCollectionsTestUtilities",
            "SDGTextTestUtilities",
            "SDGPersistenceTestUtilities",
            "SDGLocalizationTestUtilities",

            "SDGCornerstone",
            "SDGTesting"
            ]),
        .target(name: "SDGXCTestUtilities", dependencies: [
            "SDGTesting",
            "SDGLogic",
            "SDGProcessProperties"
            ]),

        // Individual component modules.

        .target(name: "SDGControlFlow"),

        .target(name: "SDGProcessProperties", dependencies: ["SDGControlFlow"]),

        .target(name: "SDGLogic", dependencies: ["SDGLogicCore"]),
        .target(name: "SDGLogicTestUtilities", dependencies: ["SDGLogic", "SDGTesting"]),

        .target(name: "SDGBinaryData", dependencies: ["SDGBinaryDataCore"]),
        .target(name: "SDGBinaryDataTestUtilities", dependencies: ["SDGBinaryData", "SDGTesting"]),

        .target(name: "SDGMathematics", dependencies: ["SDGMathematicsCore"]),
        .target(name: "SDGMathematicsTestUtilities", dependencies: [
            "SDGMathematics", "SDGTesting",
            "SDGLogicTestUtilities"
            ]),

        .target(name: "SDGCollections", dependencies: ["SDGCollectionsCore"]),
        .target(name: "SDGCollectionsTestUtilities", dependencies: ["SDGCollections", "SDGTesting"]),

        .target(name: "SDGText", dependencies: ["SDGTextCore"]),
        .target(name: "SDGTextTestUtilities", dependencies: ["SDGText", "SDGTesting"]),

        .target(name: "SDGPersistence", dependencies: [
            "SDGControlFlow",
            "SDGLogicCore",
            "SDGCollectionsCore",
            "SDGTextCore",
            "SDGProcessProperties"
            ]),
        .target(name: "SDGPersistenceTestUtilities", dependencies: ["SDGPersistence", "SDGTesting"]),

        .target(name: "SDGLocalization", dependencies: [
            "SDGControlFlow",
            "SDGLogicCore",
            "SDGMathematicsCore",
            "SDGTextCore",
            "SDGPersistence"
            ]),
        .target(name: "SDGLocalizationTestUtilities", dependencies: ["SDGLocalization", "SDGTesting"]),

        .target(name: "SDGTesting", dependencies: [
            "SDGMathematicsCore",
            ]),

        // Core subsets.

        .target(name: "SDGLogicCore"),
        .target(name: "SDGBinaryDataCore", dependencies: [
            "SDGControlFlow"
            ]),
        .target(name: "SDGMathematicsCore", dependencies: [
            "SDGControlFlow",
            "SDGLogicCore",
            "SDGBinaryDataCore"
            ]),
        .target(name: "SDGCollectionsCore", dependencies: [
            "SDGControlFlow",
            "SDGLogicCore",
            "SDGMathematicsCore"
            ]),
        .target(name: "SDGTextCore", dependencies: [
            "SDGCollectionsCore"
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
            "SDGBinaryDataTestUtilities", "SDGXCTestUtilities"
            ]),
        .testTarget(name: "SDGMathematicsTests", dependencies: [
            "SDGMathematicsTestUtilities", "SDGXCTestUtilities",
            "SDGBinaryDataTestUtilities"
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
        .testTarget(name: "SDGLocalizationTests", dependencies: [
            "SDGLocalizationTestUtilities", "SDGXCTestUtilities",
            ]),
        .testTarget(name: "SDGProcessPropertiesTests", dependencies: [
            "SDGProcessProperties", "SDGXCTestUtilities",
            "SDGLogic"
            ]),

        .target(name: "performance‐tests", dependencies: [
            "SDGTesting",

            "SDGTextCore"
            ])
    ]
)
