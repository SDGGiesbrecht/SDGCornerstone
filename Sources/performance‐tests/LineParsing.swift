/*
 LineParsing.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGTesting

import SDGText

func testLineParsing() {
    var text = ""
    for _ in 1 ... 10_000 {
        text.append("Blah blah blah...\n")
    }

    limit("Line Parsing", to: 0.2) {
        _ = text.lines.map({ String($0.line) })
    }

    limit("Lazy Line Parsing", to: 0.1) {
        for _ in 1 ... 10_000 {
            _ = text.lines.first
            _ = text.lines.last
        }
    }
}
