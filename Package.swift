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

        .library(name: "SDGLogic", targets: ["SDGLogic"]),
        .library(name: "SDGLogicTestUtilities", targets: ["SDGLogicTestUtilities"]),

        .library(name: "SDGTesting", targets: ["SDGTesting"]),

        // Core subsets.

        .library(name: "SDGLogicCore", targets: ["SDGLogicCore"])
    ],
    targets: [
        // The entire package.

        .target(name: "SDGCornerstone", dependencies: [
            "SDGLogic"
        ]),
        .target(name: "SDGCornerstoneTestUtilities", dependencies: [
            "SDGLogicTestUtilities",

            "SDGCornerstone",
            "SDGTesting"
            ]),
        .target(name: "SDGXCTestUtilities", dependencies: ["SDGTesting", "SDGCornerstone" /* [_Warning: Do not need the whole thing._] */]),

        // Individual component modules.

        .target(name: "SDGLogic", dependencies: [
            "SDGLogicCore"
        ]),
        .target(name: "SDGLogicTestUtilities", dependencies: ["SDGLogic", "SDGTesting"]),

        .target(name: "SDGTesting", dependencies: []),

        // Core subsets.

        .target(name: "SDGLogicCore"),

        // Internal tests.

        .testTarget(name: "SDGCornerstoneTests", dependencies: ["SDGCornerstoneTestUtilities", "SDGXCTestUtilities"]),

        .testTarget(name: "SDGLogicTests", dependencies: ["SDGLogicTestUtilities", "SDGXCTestUtilities"])
    ]
)
