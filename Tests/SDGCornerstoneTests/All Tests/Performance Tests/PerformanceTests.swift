/*
 PerformanceTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if os(macOS)

    import XCTest
    import Foundation

    import SDGCornerstone

    class PerformanceTests : TestCase {

        func testLiteralScalarSearch() {
            var text = "Blah blah blah..."

            lock("Literal Scalar Search", to: 0.8) {
                for _ in 1 ... 100_000 {
                    _ = text.scalars.firstMatch(for: "blah".scalars)
                }
            }
        }

        func testLineParsing() {

            var text = ""
            for _ in 1 ... 10_000 {
                text.append("Blah blah blah...\n")
            }

            lock("Line Parsing", to: 0.6) {
                _ = text.lines.map({ String($0.line) })
            }

            lock("Lazy Line Parsing", to: 0.4) {
                for _ in 1 ... 10_000 {
                    _ = text.lines.first
                    _ = text.lines.last
                }
            }
        }
    }

#endif
