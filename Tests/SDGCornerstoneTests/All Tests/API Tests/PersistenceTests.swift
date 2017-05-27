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
        let testDomainExternalName = testDomain + ".debug"
        let preferences = Preferences.preferences(forDomain: testDomain)

        preferences[testKey].value = nil
        XCTAssert(preferences[testKey].value == nil, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")

        preferences[testKey].value = true
        XCTAssert(preferences[testKey].value?.asBool == true, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")

        preferences[testKey].value = 10
        XCTAssert(preferences[testKey].value?.asInt == 10, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ 10")

        preferences[testKey].value = "A"
        XCTAssert(preferences[testKey].value?.asString == "A", "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ A")

        preferences[testKey].value = nil
        XCTAssert(preferences[testKey].value == nil, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")

        preferences[testKey].value = true
        #if os(Linux)
            let url = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(".config/\(testDomainExternalName).plist")
            do {
                let data = try Data(contentsOf: url)
                let preferences = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: PropertyListValue] ?? [:]
                XCTAssert(preferences[testKey].asBool == true, "Failed to write preferences to disk: \(String(describing: preferences[testKey])) ≠ true")
            } catch let error {
                XCTFail("An error occurred while verifying write test: \(error)")
            }
        #else
            // [_Warning: This should use centralized functions._]
            var shell = Process()
            shell.launchPath = "/usr/bin/env"
            shell.arguments = ["defaults", "read", testDomainExternalName, testKey]
            let pipe = Pipe()
            shell.standardOutput = pipe
            shell.launch()
            shell.waitUntilExit()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: String.Encoding.utf8)!
            XCTAssert(output == "1\n", "Failed to write preferences to disk: \(output) ≠ 1")
        #endif

        let externalTestKey = "SDGExternalTestKey"
        preferences[externalTestKey].value = nil

        let stringValue = "value"
        #if os(Linux)
            do {
                let data = try PropertyListSerialization.data(fromPropertyList: [externalTestKey: stringValue], format: .xml, options: 0)
                try data.write(to: url, options: [.atomic])
            } catch let error {
                XCTFail("An error occurred while setting up read test: \(error)")
            }
        #else
            // [_Warning: This should use centralized functions._]
            shell = Process()
            shell.launchPath = "/usr/bin/env"
            shell.arguments = ["defaults", "write", testDomainExternalName, externalTestKey, "\u{2D}string", stringValue]
            shell.launch()
            shell.waitUntilExit()
        #endif

        let causeSynchronization = "CauseSynchronization"
        preferences[testKey].value = causeSynchronization
        XCTAssert(preferences[testKey].value?.asString == causeSynchronization)
        XCTAssert(preferences[externalTestKey].value?.asString == stringValue, "Failed to read preferences from disk: \(String(describing: preferences[externalTestKey].value)) ≠ \(stringValue)")

        preferences.reset()
        XCTAssert(preferences[testKey].value == nil)
        XCTAssert(preferences[externalTestKey].value == nil)
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
