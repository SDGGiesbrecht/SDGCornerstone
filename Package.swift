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

        .library(name: "SDGBinaryData", targets: ["SDGBinaryData"]),
        .library(name: "SDGBinaryDataTestUtilities", targets: ["SDGBinaryDataTestUtilities"]),

        .library(name: "SDGMathematics", targets: ["SDGMathematics"]),
        .library(name: "SDGMathematicsTestUtilities", targets: ["SDGMathematicsTestUtilities"]),

        .library(name: "SDGPersistence", targets: ["SDGPersistence"]),
        .library(name: "SDGPersistenceTestUtilities", targets: ["SDGPersistenceTestUtilities"]),

        .library(name: "SDGTesting", targets: ["SDGTesting"]),

        // Core subsets.

        .library(name: "SDGLogicCore", targets: ["SDGLogicCore"]),
        .library(name: "SDGMathematicsCore", targets: ["SDGMathematicsCore"]),

        // Process properties.

        .library(name: "SDGProcessProperties", targets: ["SDGProcessProperties"])
    ],
    targets: [
        // The entire package.

        .target(name: "SDGCornerstone", dependencies: [
            "SDGControlFlow",
            "SDGLogic",
            "SDGBinaryData",
            "SDGMathematics",
            "SDGPersistence",
            "SDGProcessProperties"
            ]),
        .target(name: "SDGCornerstoneTestUtilities", dependencies: [
            "SDGLogicTestUtilities",
            "SDGBinaryDataTestUtilities",
            "SDGMathematicsTestUtilities",
            "SDGPersistenceTestUtilities",

            "SDGCornerstone",
            "SDGTesting"
            ]),
        .target(name: "SDGXCTestUtilities", dependencies: [
            "SDGTesting",
            "SDGLogic",
            "SDGProcessProperties"
            ]),

        // Individual component modules.

        .target(name: "SDGControlFlow", dependencies: []),

        .target(name: "SDGLogic", dependencies: ["SDGLogicCore"]),
        .target(name: "SDGLogicTestUtilities", dependencies: ["SDGLogic", "SDGTesting"]),

        .target(name: "SDGBinaryData", dependencies: ["SDGBinaryDataCore"]),
        .target(name: "SDGBinaryDataTestUtilities", dependencies: ["SDGBinaryData", "SDGTesting"]),

        .target(name: "SDGMathematics", dependencies: ["SDGMathematicsCore"]),
        .target(name: "SDGMathematicsTestUtilities", dependencies: [
            "SDGMathematics", "SDGTesting",
            "SDGLogicTestUtilities"
            ]),

        .target(name: "SDGPersistence"),
        .target(name: "SDGPersistenceTestUtilities", dependencies: ["SDGPersistence", "SDGTesting"]),

        .target(name: "SDGProcessProperties"),

        .target(name: "SDGTesting", dependencies: []),

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
        .testTarget(name: "SDGPersistenceTests", dependencies: [
            "SDGPersistence", "SDGXCTestUtilities",
            ]),
        .testTarget(name: "SDGProcessPropertiesTests", dependencies: [
            "SDGProcessProperties", "SDGXCTestUtilities",
            "SDGLogic"
            ])
    ]
)
