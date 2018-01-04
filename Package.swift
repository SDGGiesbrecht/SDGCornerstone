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

let library = "SDGCornerstone"
let tests = library + "Tests"

let package = Package(
    name: library,
    products: [
        .library(name: library, targets: [library])
    ],
    targets: [
        .target(name: library, dependencies: []),
        .testTarget(name: tests, dependencies: [.targetItem(name: library)])
    ]
)
