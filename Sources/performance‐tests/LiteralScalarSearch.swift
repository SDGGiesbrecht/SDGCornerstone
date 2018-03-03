/*
 LiteralScalarSearch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGTesting

import SDGTextCore

func testLiteralScalarSearch() {
    var text = "Blah blah blah..."

    limit("Literal Scalar Search", to: 0.9) {
        for _ in 1 ... 1_100_000 {
            _ = text.scalars.firstMatch(for: "blah".scalars)
        }
    }
}
