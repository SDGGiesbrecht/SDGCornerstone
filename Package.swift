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

extension Array where Element == Target {
    static func target(name: String, dependencies: [Target.Dependency] = [], tests: Bool) -> [Target] {
        var group: [Target] = [
            .target(name: name, dependencies: dependencies)
        ]
        if tests {
            group += [.testTarget(name: name + "Tests", dependencies: [.targetItem(name: name)])]
        }
        return group
    }
}

let package = Package(
    name: "SDGCornerstone",
    products: [
        .library(name: "SDGCornerstone", targets: [
            "SDGCornerstone",

            "SDGLogic", "SDGLogicCore"
            ])
    ],
    targets: Array(([
        .target(name: "SDGCornerstone", dependencies: [
            "SDGLogic"
        ], tests: true),

        .target(name: "SDGLogic", dependencies: [
            "SDGLogicCore"
            ], tests: true),

        .target(name: "SDGLogicCore", tests: false)
    ] as [[Target]]).joined())
)
