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

class PersistenceTests : TestCase {

    func testPreferences() {
        let testKey = "SDGTestKey"
        let testDomain = "ca.solideogloria.SDGCornerstone.Tests.Preferences"
        let testDomainExternalName = testDomain + ".debug"
        let preferences = Preferences.preferences(for: testDomain)

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
        #if os(macOS)
            // [_Workaround: This should use centralized functions._]
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
        #elseif os(Linux)
            let url = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(".config/\(testDomainExternalName).plist")
            do {
                let data = try Data(contentsOf: url)
                let preferences = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: PropertyListValue] ?? [:]
                XCTAssert(preferences[testKey]?.asBool == true, "Failed to write preferences to disk: \(String(describing: preferences[testKey])) ≠ true")
            } catch let error {
                XCTFail("An error occurred while verifying write test: \(error)")
            }
        #endif

        let externalTestKey = "SDGExternalTestKey"
        preferences[externalTestKey].value = nil

        let stringValue = "value"
        #if os(macOS)
            // [_Workaround: This should use centralized functions._]
            shell = Process()
            shell.launchPath = "/usr/bin/env"
            shell.arguments = ["defaults", "write", testDomainExternalName, externalTestKey, "\u{2D}string", stringValue]
            shell.launch()
            shell.waitUntilExit()
        #elseif os(Linux)
            do {
                let data = try PropertyListSerialization.data(fromPropertyList: [externalTestKey: stringValue], format: .xml, options: 0)
                try data.write(to: url, options: [.atomic])
            } catch let error {
                XCTFail("An error occurred while setting up read test: \(error)")
            }
        #endif

        let causeSynchronization = "CauseSynchronization"
        preferences[testKey].value = causeSynchronization
        XCTAssert(preferences[testKey].value?.asString == causeSynchronization, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ \(causeSynchronization)")
        #if !(os(iOS) || os(watchOS) || os(tvOS))
            // iOS and tvOS could not externally write this to the disk in the first place (see #if statement above).

            XCTAssert(preferences[externalTestKey].value?.asString == stringValue, "Failed to read preferences from disk: \(String(describing: preferences[externalTestKey].value)) ≠ \(stringValue)")
        #endif

        preferences.reset()
        XCTAssert(preferences[testKey].value == nil, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")
        XCTAssert(preferences[externalTestKey].value == nil, "Unexpected value: \(String(describing: preferences[externalTestKey].value)) ≠ nil")

        Preferences.applicationPreferences.reset()
        XCTAssert(Preferences.applicationPreferences[testKey].value == nil, "Unexpected value: \(String(describing: Preferences.applicationPreferences[testKey].value)) ≠ nil")
        Preferences.applicationPreferences[testKey].value = true
        XCTAssert(Preferences.applicationPreferences[testKey].value?.asBool == true, "Unexpected value: \(String(describing: Preferences.applicationPreferences[testKey].value)) ≠ true")
        Preferences.applicationPreferences.reset()
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

        var value: PropertyListValue = false
        XCTAssert(value.asBool == false, "Failed cast: \(value) (\(type(of: value))) ≠ false")
        value = NSNumber(value: true)
        XCTAssert(value.asBool == true, "Failed cast: \(value) (\(type(of: value))) ≠ true")

        value = 2
        XCTAssert(value.asInt == 2, "Failed cast: \(value) (\(type(of: value))) ≠ 2")
        value = NSNumber(value: 3)
        XCTAssert(value.asInt == 3, "Failed cast: \(value) (\(type(of: value))) ≠ 3")

        value = 0.5
        XCTAssert(value.asDouble == 0.5, "Failed cast: \(value) (\(type(of: value))) ≠ 0.5")
        value = NSNumber(value: 0.25)
        XCTAssert(value.asDouble == 0.25, "Failed cast: \(value) (\(type(of: value))) ≠ 0.25")

        value = "A"
        XCTAssert(value.asString == "A", "Failed cast: \(value) (\(type(of: value))) ≠ A")
        value = NSString(string: "B")
        XCTAssert(value.asString == "B", "Failed cast: \(value) (\(type(of: value))) ≠ B")

        let dateOne = Date(timeIntervalSinceReferenceDate: 4)
        let dateTwo = Date(timeIntervalSinceReferenceDate: 5)
        value = dateOne
        XCTAssert(value.asDate == dateOne, "Failed cast: \(value) (\(type(of: value))) ≠ \(dateOne)")
        value = NSDate(timeIntervalSinceReferenceDate: dateTwo.timeIntervalSinceReferenceDate)
        XCTAssert(value.asDate == dateTwo, "Failed cast: \(value) (\(type(of: value))) ≠ \(dateTwo)")

        let dataOne = Data(bytes: [1, 2, 3])
        let dataTwo = Data(bytes: [4, 5, 6])
        value = dataOne
        XCTAssert(value.asData == dataOne, "Failed cast: \(value) (\(type(of: value))) ≠ \(dataOne)")
        value = NSData(data: dataTwo)
        XCTAssert(value.asData == dataTwo, "Failed cast: \(value) (\(type(of: value))) ≠ \(dataTwo)")

        var arrayOne: [PropertyListValue] = [−1, −2, −3]
        var arrayTwo: [PropertyListValue] = [−4, −5, −6]
        value = arrayOne
        XCTAssert(value.asArray(of: Int.self)?.contains(−1) == true, "Failed cast: \(value) (\(type(of: value))) ≠ \(arrayOne)")
        value = NSArray(array: arrayTwo)
        XCTAssert(value.asArray(of: Int.self)?.contains(−4) == true, "Failed cast: \(value) (\(type(of: value))) ≠ \(arrayTwo)")

        var dictionaryOne: [String: PropertyListValue] = ["1": 1, "2": 2, "3": 3]
        var dictionaryTwo: [String: PropertyListValue] = ["4": 4, "5": 5, "6": 6]
        value = dictionaryOne
        XCTAssert(value.asDictionary(of: Int.self)?["3"] == 3, "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryOne)")
        value = NSDictionary(dictionary: dictionaryTwo)
        XCTAssert(value.asDictionary ≠ nil, "Failed cast: \(value) (\(type(of: value))) == nil")
        XCTAssert(value.asDictionary(of: Int.self)?["6"] == 6, "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryTwo)")
        value = true
        XCTAssert(value.asDictionary == nil, "Unexpected cast: \(value) (\(type(of: value))) ≠ nil")

        arrayOne = [1, 2.0, "3"]
        arrayTwo = [4, 5.0, "6"]
        value = arrayOne
        XCTAssert(value.asArray?.contains(where: { $0.equatableRepresentation == 1.equatableRepresentation }) == true, "Failed cast: \(value) (\(type(of: value))) ≠ \(arrayOne)")
        value = NSArray(array: arrayTwo)
        XCTAssert(value.asArray?.contains(where: { $0.equatableRepresentation == 4.equatableRepresentation }) == true, "Failed cast: \(value) (\(type(of: value))) ≠ \(arrayTwo)")

        dictionaryOne = ["1": 1, "2": 2.0, "3": "3"]
        dictionaryTwo = ["4": 4, "5": 5.0, "6": "6", "7": 7 as UInt, "8": 8 as Int64, "9": 9 as UInt64, "10": 10 as Int32, "11": 11 as UInt32, "12": 12 as Int16, "13": 13 as UInt16, "14": 14 as Int8, "15": 15 as UInt8, "16": 16.0 as Float, "17": NSDate(), "18": NSData(), "19": [NSString()], "20": [NSString(): NSString()], "21": NSArray(array: arrayTwo)]
        value = dictionaryOne
        XCTAssert(value.asDictionary?["3"]?.asString == "3", "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryOne)")
        value = NSDictionary(dictionary: dictionaryTwo)
        XCTAssert(value.asDictionary ≠ nil, "Failed cast: \(value) (\(type(of: value))) == nil")
        XCTAssert(value.asDictionary?["6"]?.asString == "6", "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryTwo)")
        value = true
        XCTAssert(value.asDictionary == nil, "Unexpected cast: \(value) (\(type(of: value))) ≠ nil")
    }

    static var allTests: [(String, (PersistenceTests) -> () throws -> Void)] {
        return [
            ("testPreferences", testPreferences),
            ("testPropertyList", testPropertyList)
        ]
    }
}
