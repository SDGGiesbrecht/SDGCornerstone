/*
 LocalizationTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstone

class LocalizationTests : XCTestCase {

    func testLocalization() {
        XCTAssert(LocalizationExample(exactly: "fr")?.code == "fr")
        XCTAssert(LocalizationExample(exactly: "en\u{2D}GB") == .englishUnitedKingdom)
        XCTAssert(LocalizationExample(exactly: "en\u{2D}") == nil)
        XCTAssert(LocalizationExample(reasonableMatchFor: "en\u{2D}US") == .englishUnitedKingdom, "en\u{2D}US → \(String(describing: LocalizationExample(reasonableMatchFor: "en\u{2D}US"))) ≠ en\u{2D}GB")
        XCTAssert(LocalizationExample(reasonableMatchFor: "fr\u{2D}FR") == .français, "fr\u{2D}FR → \(String(describing: LocalizationExample(reasonableMatchFor: "fr\u{2D}FR"))) ≠ fr")
    }

    static var allTests: [(String, (LocalizationTests) -> () throws -> Void)] {
        return [
            ("testLocalization", testLocalization)
        ]
    }
}
