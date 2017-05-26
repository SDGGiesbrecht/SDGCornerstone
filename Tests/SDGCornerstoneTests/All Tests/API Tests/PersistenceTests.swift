/*
 PersistenceTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

class PersistenceTests : XCTestCase {

    func testPreferences() {
        let testKey = "SDGTestKey"
        let testDomain = "ca.solideogloria.SDGCornerstone.Tests"
        let preferences = Preferences.preferences(forDomain: testDomain)

        preferences[testKey].value = nil
        XCTAssert(preferences[testKey].value == nil, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")

        preferences[testKey].value = true
        XCTAssert(preferences[testKey].value as? Bool == true, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")

        preferences[testKey].value = 10
        XCTAssert(preferences[testKey].value as? Int == 10, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ 10")

        preferences[testKey].value = "A"
        XCTAssert(preferences[testKey].value as? String == "A", "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ A")

        preferences[testKey].value = nil
        XCTAssert(preferences[testKey].value == nil, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")

        preferences[testKey].value = true
        // [_Warning: This should use centralized functions._]
        var shell = Process()
        shell.launchPath = "/usr/bin/env"
        shell.arguments = ["defaults", "read", testDomain + ".debug", testKey]
        let pipe = Pipe()
        shell.standardOutput = pipe
        shell.launch()
        shell.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: String.Encoding.utf8)!
        XCTAssert(output == "1\n", "Failed to write preferences to disk: \(output) ≠ 1")

        /*
        shell = Process()
        shell.launchPath = "/usr/bin/env"
        shell.arguments = ["defaults", "write", testDomain + ".debug", "SDGExternalTestKey", "-boolean", "YES"]
        shell.launch()
        shell.waitUntilExit()*/
    }

    func testPropertyList() {
        XCTAssert("A".equatableRepresentation ≠ 1.equatableRepresentation)

        XCTAssert(Data().equatableRepresentation == Data().equatableRepresentation)
        XCTAssert("A".equatableRepresentation == "A".equatableRepresentation)
        XCTAssert(true.equatableRepresentation == true.equatableRepresentation)
        XCTAssert(10.equatableRepresentation == 10.equatableRepresentation)
        XCTAssert(0.5.equatableRepresentation == 0.5.equatableRepresentation)
        let date = Date()
        XCTAssert(date.equatableRepresentation == date.equatableRepresentation)
        XCTAssert([1, 2, 3].equatableRepresentation == [1, 2, 3].equatableRepresentation)
        XCTAssert(["1": 1, "2": 2, "3": 3].equatableRepresentation == ["1": 1, "2": 2, "3": 3].equatableRepresentation)

    }

    static var allTests: [(String, (PersistenceTests) -> () throws -> Void)] {
        return [
            ("testPreferences", testPreferences),
            ("testPropertyList", testPropertyList)
        ]
    }
}
