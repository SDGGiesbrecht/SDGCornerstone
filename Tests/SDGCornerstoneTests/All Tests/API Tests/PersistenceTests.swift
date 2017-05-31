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
        XCTAssert(preferences[testKey].value?.as(Bool.self) == true, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")

        preferences[testKey].value = 10
        XCTAssert(preferences[testKey].value?.as(Int.self) == 10, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ 10")

        preferences[testKey].value = "A"
        XCTAssert(preferences[testKey].value?.as(String.self) == "A", "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ A")

        preferences[testKey].value = nil
        XCTAssert(preferences[testKey].value == nil, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")

        preferences[testKey].value = true
        #if os(macOS)
            do {
                let output = try Shell.default.run(command: ["defaults", "read", testDomainExternalName, testKey], silently: true)
                XCTAssert(output == "1", "Failed to write preferences to disk: \(output) ≠ 1")
            } catch let error {
                XCTFail("Unexpected error: \((error as? Shell.Error)?.description ?? "\(error)")")
            }
        #elseif os(Linux)
            let url = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(".config/\(testDomainExternalName).plist")
            do {
                let data = try Data(contentsOf: url)
                let preferences = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: PropertyListValue] ?? [:]
                XCTAssert(preferences[testKey]?.as(Bool.self) == true, "Failed to write preferences to disk: \(String(describing: preferences[testKey])) ≠ true")
            } catch let error {
                XCTFail("An error occurred while verifying write test: \(error)")
            }
        #endif

        let externalTestKey = "SDGExternalTestKey"
        preferences[externalTestKey].value = nil

        let stringValue = "value"
        #if os(macOS)
            do {
                try Shell.default.run(command: ["defaults", "write", testDomainExternalName, externalTestKey, "\u{2D}string", stringValue], silently: true)
            } catch let error {
                XCTFail("Unexpected error: \((error as? Shell.Error)?.description ?? "\(error)")")
            }
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
        XCTAssert(preferences[testKey].value?.as(String.self) == causeSynchronization, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ \(causeSynchronization)")
        #if !(os(iOS) || os(watchOS) || os(tvOS))
            // iOS and tvOS could not externally write this to the disk in the first place (see #if statement above).

            XCTAssert(preferences[externalTestKey].value?.as(String.self) == stringValue, "Failed to read preferences from disk: \(String(describing: preferences[externalTestKey].value)) ≠ \(stringValue)")
        #endif

        preferences.reset()
        XCTAssert(preferences[testKey].value == nil, "Unexpected value: \(String(describing: preferences[testKey].value)) ≠ nil")
        XCTAssert(preferences[externalTestKey].value == nil, "Unexpected value: \(String(describing: preferences[externalTestKey].value)) ≠ nil")

        Preferences.applicationPreferences.reset()
        XCTAssert(Preferences.applicationPreferences[testKey].value == nil, "Unexpected value: \(String(describing: Preferences.applicationPreferences[testKey].value)) ≠ nil")
        Preferences.applicationPreferences[testKey].value = true
        XCTAssert(Preferences.applicationPreferences[testKey].value?.as(Bool.self) == true, "Unexpected value: \(String(describing: Preferences.applicationPreferences[testKey].value)) ≠ true")
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
        XCTAssert(value.as(Bool.self) == false, "Failed cast: \(value) (\(type(of: value))) ≠ false")
        value = NSNumber(value: true)
        XCTAssert(value.as(Bool.self) == true, "Failed cast: \(value) (\(type(of: value))) ≠ true")

        value = 2
        XCTAssert(value.as(Int.self) == 2, "Failed cast: \(value) (\(type(of: value))) ≠ 2")
        value = NSNumber(value: 3)
        XCTAssert(value.as(Int.self) == 3, "Failed cast: \(value) (\(type(of: value))) ≠ 3")

        value = 4 as UInt
        XCTAssert(value.as(UInt.self) == 4, "Failed cast: \(value) (\(type(of: value))) ≠ 4")
        value = NSNumber(value: 5)
        XCTAssert(value.as(UInt.self) == 5, "Failed cast: \(value) (\(type(of: value))) ≠ 5")

        value = 6 as Int64
        XCTAssert(value.as(Int64.self) == 6, "Failed cast: \(value) (\(type(of: value))) ≠ 6")
        value = NSNumber(value: 7)
        XCTAssert(value.as(Int64.self) == 7, "Failed cast: \(value) (\(type(of: value))) ≠ 7")

        value = 8 as UInt64
        XCTAssert(value.as(UInt64.self) == 8, "Failed cast: \(value) (\(type(of: value))) ≠ 8")
        value = NSNumber(value: 9)
        XCTAssert(value.as(UInt64.self) == 9, "Failed cast: \(value) (\(type(of: value))) ≠ 9")

        value = 10 as Int32
        XCTAssert(value.as(Int32.self) == 10, "Failed cast: \(value) (\(type(of: value))) ≠ 10")
        value = NSNumber(value: 11)
        XCTAssert(value.as(Int32.self) == 11, "Failed cast: \(value) (\(type(of: value))) ≠ 11")

        value = 12 as UInt32
        XCTAssert(value.as(UInt32.self) == 12, "Failed cast: \(value) (\(type(of: value))) ≠ 12")
        value = NSNumber(value: 13)
        XCTAssert(value.as(UInt32.self) == 13, "Failed cast: \(value) (\(type(of: value))) ≠ 13")

        value = 14 as Int16
        XCTAssert(value.as(Int16.self) == 14, "Failed cast: \(value) (\(type(of: value))) ≠ 14")
        value = NSNumber(value: 15)
        XCTAssert(value.as(Int16.self) == 15, "Failed cast: \(value) (\(type(of: value))) ≠ 15")

        value = 16 as UInt16
        XCTAssert(value.as(UInt16.self) == 16, "Failed cast: \(value) (\(type(of: value))) ≠ 16")
        value = NSNumber(value: 17)
        XCTAssert(value.as(UInt16.self) == 17, "Failed cast: \(value) (\(type(of: value))) ≠ 17")

        value = 18 as Int8
        XCTAssert(value.as(Int8.self) == 18, "Failed cast: \(value) (\(type(of: value))) ≠ 18")
        value = NSNumber(value: 19)
        XCTAssert(value.as(Int8.self) == 19, "Failed cast: \(value) (\(type(of: value))) ≠ 19")

        value = 20 as UInt8
        XCTAssert(value.as(UInt8.self) == 20, "Failed cast: \(value) (\(type(of: value))) ≠ 20")
        value = NSNumber(value: 21)
        XCTAssert(value.as(UInt8.self) == 21, "Failed cast: \(value) (\(type(of: value))) ≠ 21")

        value = 0.5
        XCTAssert(value.as(Double.self) == 0.5, "Failed cast: \(value) (\(type(of: value))) ≠ 0.5")
        value = NSNumber(value: 0.25)
        XCTAssert(value.as(Double.self) == 0.25, "Failed cast: \(value) (\(type(of: value))) ≠ 0.25")

        value = 0.125 as Float
        XCTAssert(value.as(Float.self) == 0.125, "Failed cast: \(value) (\(type(of: value))) ≠ 0.125")
        value = NSNumber(value: 1)
        XCTAssert(value.as(Float.self) == 1, "Failed cast: \(value) (\(type(of: value))) ≠ 0.625")

        value = NSNumber(value: 22)
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 22), "Failed cast: \(value) (\(type(of: value))) ≠ 22")
        value = false
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: false), "Failed cast: \(value) (\(type(of: value))) ≠ false")
        value = 23
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 23), "Failed cast: \(value) (\(type(of: value))) ≠ 23")
        value = 24 as UInt
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 24), "Failed cast: \(value) (\(type(of: value))) ≠ 24")
        value = 25 as Int64
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 25), "Failed cast: \(value) (\(type(of: value))) ≠ 25")
        value = 26 as UInt64
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 26), "Failed cast: \(value) (\(type(of: value))) ≠ 26")
        value = 27 as Int32
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 27), "Failed cast: \(value) (\(type(of: value))) ≠ 27")
        value = 28 as UInt32
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 28), "Failed cast: \(value) (\(type(of: value))) ≠ 28")
        value = 29 as Int16
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 29), "Failed cast: \(value) (\(type(of: value))) ≠ 29")
        value = 30 as UInt16
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 30), "Failed cast: \(value) (\(type(of: value))) ≠ 30")
        value = 31 as Int8
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 31), "Failed cast: \(value) (\(type(of: value))) ≠ 31")
        value = 32 as UInt8
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 32), "Failed cast: \(value) (\(type(of: value))) ≠ 32")
        value = 64 as Double
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 64), "Failed cast: \(value) (\(type(of: value))) ≠ 64")
        value = 128 as Float
        XCTAssert(value.as(NSNumber.self) == NSNumber(value: 128), "Failed cast: \(value) (\(type(of: value))) ≠ 128")

        value = "A"
        XCTAssert(value.as(String.self) == "A", "Failed cast: \(value) (\(type(of: value))) ≠ A")
        value = NSString(string: "B")
        XCTAssert(value.as(String.self) == "B", "Failed cast: \(value) (\(type(of: value))) ≠ B")

        value = NSString(string: "C")
        XCTAssert(value.as(NSString.self) == NSString(string: "C"), "Failed cast: \(value) (\(type(of: value))) ≠ C")
        value = "D"
        XCTAssert(value.as(NSString.self) == NSString(string: "D"), "Failed cast: \(value) (\(type(of: value))) ≠ D")

        let dateOne = Date(timeIntervalSinceReferenceDate: 4)
        let dateTwo = Date(timeIntervalSinceReferenceDate: 5)
        value = dateOne
        XCTAssert(value.as(Date.self) == dateOne, "Failed cast: \(value) (\(type(of: value))) ≠ \(dateOne)")
        value = NSDate(timeIntervalSinceReferenceDate: dateTwo.timeIntervalSinceReferenceDate)
        XCTAssert(value.as(Date.self) == dateTwo, "Failed cast: \(value) (\(type(of: value))) ≠ \(dateTwo)")

        let dateThree = NSDate(timeIntervalSinceReferenceDate: 6)
        let dateFour = NSDate(timeIntervalSinceReferenceDate: 7)
        value = dateThree
        XCTAssert(value.as(NSDate.self) == dateThree, "Failed cast: \(value) (\(type(of: value))) ≠ \(dateThree)")
        value = Date(timeIntervalSinceReferenceDate: dateFour.timeIntervalSinceReferenceDate)
        XCTAssert(value.as(NSDate.self) == dateFour, "Failed cast: \(value) (\(type(of: value))) ≠ \(dateFour)")

        let dataOne = Data(bytes: [1, 2, 3])
        let dataTwo = Data(bytes: [4, 5, 6])
        value = dataOne
        XCTAssert(value.as(Data.self) == dataOne, "Failed cast: \(value) (\(type(of: value))) ≠ \(dataOne)")
        value = NSData(data: dataTwo)
        XCTAssert(value.as(Data.self) == dataTwo, "Failed cast: \(value) (\(type(of: value))) ≠ \(dataTwo)")

        let dataThree = NSData(data: Data(bytes: [7, 8, 9]))
        let dataFour = NSData(data: Data(bytes: [10, 11, 12]))
        value = dataThree
        XCTAssert(value.as(NSData.self) == dataThree, "Failed cast: \(value) (\(type(of: value))) ≠ \(dataThree)")
        value = dataFour.subdata(with: NSRange(location: 0, length: dataFour.length))
        XCTAssert(value.as(NSData.self) == dataFour, "Failed cast: \(value) (\(type(of: value))) ≠ \(dataFour)")

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
        XCTAssert(value.as([String: PropertyListValue].self) ≠ nil, "Failed cast: \(value) (\(type(of: value))) == nil")
        XCTAssert(value.asDictionary(of: Int.self)?["6"] == 6, "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryTwo)")
        value = true
        XCTAssert(value.as([String: PropertyListValue].self) == nil, "Unexpected cast: \(value) (\(type(of: value))) ≠ nil")

        let dictionaryThree: [NSString: PropertyListValue] = [NSString(string: "1"): 1, NSString(string: "2"): 2, NSString(string: "3"): 3]
        let dictionaryFour: [NSString: PropertyListValue] = [NSString(string: "4"): 4, NSString(string: "5"): 5, NSString(string: "6"): 6]
        value = dictionaryThree
        XCTAssert(value.asDictionary(of: Int.self)?["3"] == 3, "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryThree)")
        value = NSDictionary(dictionary: dictionaryFour)
        XCTAssert(value.as([String: PropertyListValue].self) ≠ nil, "Failed cast: \(value) (\(type(of: value))) == nil")
        XCTAssert(value.asDictionary(of: Int.self)?["6"] == 6, "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryFour)")
        value = true
        XCTAssert(value.as([String: PropertyListValue].self) == nil, "Unexpected cast: \(value) (\(type(of: value))) ≠ nil")

        arrayOne = [1, 2.0, "3"]
        arrayTwo = [4, 5.0, "6"]
        value = arrayOne
        XCTAssert(value.as([PropertyListValue].self)?.contains(where: { $0.equatableRepresentation == 1.equatableRepresentation }) == true, "Failed cast: \(value) (\(type(of: value))) ≠ \(arrayOne)")
        value = NSArray(array: arrayTwo)
        XCTAssert(value.as([PropertyListValue].self)?.contains(where: { $0.equatableRepresentation == 4.equatableRepresentation }) == true, "Failed cast: \(value) (\(type(of: value))) ≠ \(arrayTwo)")

        value = arrayOne
        XCTAssert(value.as(NSArray.self)?.count == 3, "Failed cast: \(value) (\(type(of: value))) ≠ \(arrayOne)")
        value = NSArray(array: arrayTwo)
        XCTAssert(value.as(NSArray.self)?.count == 3, "Failed cast: \(value) (\(type(of: value))) ≠ \(arrayTwo)")

        dictionaryOne = ["1": 1, "2": 2.0, "3": "3"]
        dictionaryTwo = ["4": 4, "5": 5.0, "6": "6", "7": 7 as UInt, "8": 8 as Int64, "9": 9 as UInt64, "10": 10 as Int32, "11": 11 as UInt32, "12": 12 as Int16, "13": 13 as UInt16, "14": 14 as Int8, "15": 15 as UInt8, "16": 16.0 as Float, "17": NSDate(), "18": NSData(), "19": [NSString()], "20": [NSString(): NSString()], "21": NSArray(array: arrayTwo)]
        value = dictionaryOne
        XCTAssert(value.as([String: PropertyListValue].self)?["3"]?.as(String.self) == "3", "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryOne)")
        value = NSDictionary(dictionary: dictionaryTwo)
        XCTAssert(value.as([String: PropertyListValue].self) ≠ nil, "Failed cast: \(value) (\(type(of: value))) == nil")
        XCTAssert(value.as([String: PropertyListValue].self)?["6"]?.as(String.self) == "6", "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryTwo)")
        value = true
        XCTAssert(value.as([String: PropertyListValue].self) == nil, "Unexpected cast: \(value) (\(type(of: value))) ≠ nil")

        value = dictionaryOne
        XCTAssert((value.as(NSDictionary.self)?["3"] as? PropertyListValue)?.as(String.self) == "3", "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryOne)")
        value = NSDictionary(dictionary: dictionaryTwo)
        XCTAssert(value.as(NSDictionary.self) ≠ nil, "Failed cast: \(value) (\(type(of: value))) == nil")
        XCTAssert((value.as(NSDictionary.self)?["6"] as? PropertyListValue)?.as(String.self) == "6", "Failed cast: \(value) (\(type(of: value))) ≠ \(dictionaryTwo)")
        value = true
        XCTAssert(value.as(NSDictionary.self) == nil, "Unexpected cast: \(value) (\(type(of: value))) ≠ nil")
    }

    static var allTests: [(String, (PersistenceTests) -> () throws -> Void)] {
        return [
            ("testPreferences", testPreferences),
            ("testPropertyList", testPropertyList)
        ]
    }
}
