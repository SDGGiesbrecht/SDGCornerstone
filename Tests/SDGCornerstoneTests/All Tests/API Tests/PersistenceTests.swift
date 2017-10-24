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

    func testCodable() {
        XCTAssertRecodes(0.5 as Float80, equivalentFormats: ["[\u{22}0.5\u{22}]"])
        XCTAssertRecodes("12 345" as Integer, equivalentFormats: ["[\u{22}12 345\u{22}]"])
        XCTAssertRecodes("−12 345" as Integer, equivalentFormats: ["[\u{22}−12 345\u{22}]"])
        XCTAssertRecodes("àbçđę..." as StrictString, equivalentFormats: ["[\u{22}àbçđę...\u{22}]", "[\u{22}\u{E0}b\u{E7}đ\u{119}\u{2026}\u{22}]"])
        XCTAssertRecodes("−12 345,678 9" as RationalNumber, equivalentFormats: ["[[\u{22}−123 443 211\u{22},\u{22}10 000\u{22}]]"])

        XCTAssertRecodes(Double.π.radians, equivalentFormats: ["[3.141592653589793]"])
        XCTAssertRecodes(7.days, equivalentFormats: ["[[1814400,259200]]"])

        XCTAssertRecodes(GregorianYear(1234), equivalentFormats: ["[1234]"])
        XCTAssertRecodes(GregorianMonth.january, equivalentFormats: ["[1]"])
        XCTAssertRecodes(GregorianDay(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(GregorianWeekday.sunday, equivalentFormats: ["[1]"])
        XCTAssertRecodes(GregorianHour(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(GregorianMinute(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(GregorianSecond(12), equivalentFormats: ["[\u{22}12\u{22}]"])
        XCTAssertRecodes(HebrewYear(1234), equivalentFormats: ["[1234]"])
        XCTAssertRecodes(HebrewDay(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(HebrewWeekday.sunday, equivalentFormats: ["[1]"])
        XCTAssertRecodes(HebrewHour(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(HebrewPart(124), equivalentFormats: ["[\u{22}124\u{22}]"])
    }

    func testFileConvertible() {
        func runTests<T : FileConvertible>(_ instance: T) where T : Equatable {
            XCTAssertEqual((try? T(file: instance.file, origin: nil)), instance)

            let url = FileManager.default.url(in: .temporary, at: "\(type(of: instance))")
            defer {
                FileManager.default.delete(.temporary)
                if let shouldNotExist = try? T(from: url) {
                    XCTFail("Failed to delete \(url)")
                }
            }

            do {
                try instance.save(to: url)
                let reloaded = try T(from: url)
                XCTAssertEqual(reloaded, instance, "The loaded file does not match the saved file.")
            } catch let error {
                XCTFail("An error occured saving and loading: \(error)")
            }
        }
        runTests(Data([0x10, 0x20, 0x30]))
        runTests("Hello, world!")
        runTests(StrictString("Hello, world!"))
        runTests(PropertyList.dictionary(["Key": "Value"]))
        runTests(PropertyList.array(["Element"]))

        XCTAssertNil((try? PropertyList(file: Data(), origin: nil)))
    }

    func testFileManager() {
        defer { FileManager.default.delete(.temporary) }

        let path = "example/path"
        XCTAssertEqual(FileManager.default.url(in: .temporary, at: path), FileManager.default.url(in: .temporary, at: path), "Differing temporary directories provided.")

        XCTAssert(FileManager.default.url(in: .applicationSupport, at: path).absoluteString.contains("Application%20Support"), "Unexpected support directory.")
        XCTAssertNotNil(FileManager.default.url(in: .cache, at: path).absoluteString.scalars.firstMatch(for: AlternativePatterns([LiteralPattern("Cache".scalars), LiteralPattern("cache".scalars)])))
        XCTAssertNotNil(FileManager.default.url(in: .temporary, at: path).absoluteString.scalars.firstMatch(for: AlternativePatterns([LiteralPattern("Temp".scalars), LiteralPattern("temp".scalars), LiteralPattern("tmp".scalars), LiteralPattern("Being%20Saved%20By".scalars)])))

        let directoryName = "Directory"
        let directory = FileManager.default.url(in: .temporary, at: directoryName)
        let file = directory.appendingPathComponent("File.txt")
        do {
            try FileManager.default.do(in: directory) {
                // When the directory does not exist yet.
                XCTAssertEqual(URL(fileURLWithPath: FileManager.default.currentDirectoryPath).lastPathComponent, directoryName)
            }

            let fileContents = "File"
            try fileContents.save(to: file)

            try FileManager.default.do(in: directory) {
                // When the directory already exists.
                XCTAssertEqual(URL(fileURLWithPath: FileManager.default.currentDirectoryPath).lastPathComponent, directoryName)
            }

            XCTAssertEqual(try? String(from: file), fileContents) // Directory not overwritten.
        } catch let error {
            XCTFail("\(error)")
        }

        do {
            let sourceDirectory = FileManager.default.url(in: .temporary, at: "Source Directory")
            let destinationDirectory = FileManager.default.url(in: .temporary, at: "/Intermediate Directory/Destination Directory")

            let fileContents = "File"
            let fileName = "File.txt"
            try fileContents.save(to: sourceDirectory.appendingPathComponent(fileName))

            try FileManager.default.move(sourceDirectory, to: destinationDirectory)
            XCTAssertEqual(try? String(from: destinationDirectory.appendingPathComponent(fileName)), fileContents)
            XCTAssertNil(try? String(from: sourceDirectory.appendingPathComponent(fileName)))

            FileManager.default.delete(.temporary)
            try fileContents.save(to: sourceDirectory.appendingPathComponent(fileName))

            try FileManager.default.copy(sourceDirectory, to: destinationDirectory)
            XCTAssertEqual(try? String(from: destinationDirectory.appendingPathComponent(fileName)), fileContents)
            XCTAssertEqual(try? String(from: sourceDirectory.appendingPathComponent(fileName)), fileContents)

        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testPreferences() {
        let testKey = "SDGTestKey"
        let testDomain = "ca.solideogloria.SDGCornerstone.Tests.Preferences"
        let testDomainExternalName = testDomain + ".debug"
        let preferences = Preferences.preferences(for: testDomain)

        preferences[testKey].value = nil
        XCTAssertNil(preferences[testKey].value)

        preferences[testKey].value = true
        XCTAssertEqual(preferences[testKey].value?.as(Bool.self), true)

        preferences[testKey].value = 10
        XCTAssertEqual(preferences[testKey].value?.as(Int.self), 10)

        preferences[testKey].value = "A"
        XCTAssertEqual(preferences[testKey].value?.as(String.self), "A")

        preferences[testKey].value = nil
        XCTAssertNil(preferences[testKey].value)

        preferences[testKey].value = true
        #if os(macOS)
            do {let output = try Shell.default.run(command: ["defaults", "read", testDomainExternalName, testKey], silently: true)
                XCTAssertEqual(output, "1", "Failed to write preferences to disk.")
            } catch let error {
                XCTFail("Unexpected error: \((error as? Shell.Error)?.description ?? "\(error)")")
            }
        #elseif os(Linux)
            let url = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(".config/\(testDomainExternalName).plist")
            do {
                let propertyList = try PropertyList(from: url)
                switch propertyList {
                case .dictionary(let preferences):
                    XCTAssertEqual(preferences[testKey]?.as(Bool.self), true, "Failed to write preferences to disk.")
                default:
                    XCTFail("An error occurred while verifying write test: The property list file is not a dictionary.")
                }
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
                let propertyList = PropertyList.dictionary([externalTestKey: stringValue])
                try propertyList.save(to: url)
            } catch let error {
                XCTFail("An error occurred while setting up read test: \(error)")
            }
        #endif

        let causeSynchronization = "CauseSynchronization"
        preferences[testKey].value = causeSynchronization
        XCTAssertEqual(preferences[testKey].value?.as(String.self), causeSynchronization)
        #if !(os(iOS) || os(watchOS) || os(tvOS))
            // iOS and tvOS could not externally write this to the disk in the first place (see #if statement above).

            XCTAssertEqual(preferences[externalTestKey].value?.as(String.self), stringValue, "Failed to read preferences from disk.")
        #endif

        preferences.reset()
        XCTAssertNil(preferences[testKey].value)
        XCTAssertNil(preferences[externalTestKey].value)

        Preferences.applicationPreferences.reset()
        XCTAssertNil(Preferences.applicationPreferences[testKey].value)
        Preferences.applicationPreferences[testKey].value = true
        XCTAssertEqual(Preferences.applicationPreferences[testKey].value?.as(Bool.self), true)
        Preferences.applicationPreferences.reset()
    }

    func testPropertyList() {
        XCTAssertNotEqual("A".equatableRepresentation, 1.equatableRepresentation)

        XCTAssertEqual(Data().equatableRepresentation, Data().equatableRepresentation)
        XCTAssertEqual("A".equatableRepresentation, "A".equatableRepresentation)
        XCTAssertEqual(true.equatableRepresentation, true.equatableRepresentation)
        XCTAssertEqual(10.equatableRepresentation, 10.equatableRepresentation)
        XCTAssertEqual(0.5.equatableRepresentation, 0.5.equatableRepresentation)
        let date = Date()
        XCTAssertEqual(date.equatableRepresentation, date.equatableRepresentation)
        XCTAssertEqual([1, 2, 3].equatableRepresentation, [1, 2, 3].equatableRepresentation)
        XCTAssertEqual(["1": 1, "2": 2, "3": 3].equatableRepresentation, ["1": 1, "2": 2, "3": 3].equatableRepresentation)

        var value: PropertyListValue = false
        XCTAssertEqual(value.as(Bool.self), false)
        value = NSNumber(value: true)
        XCTAssertEqual(value.as(Bool.self), true)

        value = 2
        XCTAssertEqual(value.as(Int.self), 2)
        value = NSNumber(value: 3)
        XCTAssertEqual(value.as(Int.self), 3)

        value = 4 as UInt
        XCTAssertEqual(value.as(UInt.self), 4)
        value = NSNumber(value: 5)
        XCTAssertEqual(value.as(UInt.self), 5)

        value = 6 as Int64
        XCTAssertEqual(value.as(Int64.self), 6)
        value = NSNumber(value: 7)
        XCTAssertEqual(value.as(Int64.self), 7)

        value = 8 as UInt64
        XCTAssertEqual(value.as(UInt64.self), 8)
        value = NSNumber(value: 9)
        XCTAssertEqual(value.as(UInt64.self), 9)

        value = 10 as Int32
        XCTAssertEqual(value.as(Int32.self), 10)
        value = NSNumber(value: 11)
        XCTAssertEqual(value.as(Int32.self), 11)

        value = 12 as UInt32
        XCTAssertEqual(value.as(UInt32.self), 12)
        value = NSNumber(value: 13)
        XCTAssertEqual(value.as(UInt32.self), 13)

        value = 14 as Int16
        XCTAssertEqual(value.as(Int16.self), 14)
        value = NSNumber(value: 15)
        XCTAssertEqual(value.as(Int16.self), 15)

        value = 16 as UInt16
        XCTAssertEqual(value.as(UInt16.self), 16)
        value = NSNumber(value: 17)
        XCTAssertEqual(value.as(UInt16.self), 17)

        value = 18 as Int8
        XCTAssertEqual(value.as(Int8.self), 18)
        value = NSNumber(value: 19)
        XCTAssertEqual(value.as(Int8.self), 19)

        value = 20 as UInt8
        XCTAssertEqual(value.as(UInt8.self), 20)
        value = NSNumber(value: 21)
        XCTAssertEqual(value.as(UInt8.self), 21)

        value = 0.5
        XCTAssertEqual(value.as(Double.self), 0.5)
        value = NSNumber(value: 0.25)
        XCTAssertEqual(value.as(Double.self), 0.25)

        value = 0.125 as Float
        XCTAssertEqual(value.as(Float.self), 0.125)
        value = NSNumber(value: 1)
        XCTAssertEqual(value.as(Float.self), 1)

        value = NSNumber(value: 22)
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 22))
        value = false
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: false))
        value = 23
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 23))
        value = 24 as UInt
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 24))
        value = 25 as Int64
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 25))
        value = 26 as UInt64
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 26))
        value = 27 as Int32
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 27))
        value = 28 as UInt32
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 28))
        value = 29 as Int16
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 29))
        value = 30 as UInt16
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 30))
        value = 31 as Int8
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 31))
        value = 32 as UInt8
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 32))
        value = 64 as Double
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 64))
        value = 128 as Float
        XCTAssertEqual(value.as(NSNumber.self), NSNumber(value: 128))

        value = "A"
        XCTAssertEqual(value.as(String.self), "A")
        value = NSString(string: "B")
        XCTAssertEqual(value.as(String.self), "B")

        value = NSString(string: "C")
        XCTAssertEqual(value.as(NSString.self), NSString(string: "C"))
        value = "D"
        XCTAssertEqual(value.as(NSString.self), NSString(string: "D"))

        let dateOne = Date(timeIntervalSinceReferenceDate: 4)
        let dateTwo = Date(timeIntervalSinceReferenceDate: 5)
        value = dateOne
        XCTAssertEqual(value.as(Date.self), dateOne)
        value = NSDate(timeIntervalSinceReferenceDate: dateTwo.timeIntervalSinceReferenceDate)
        XCTAssertEqual(value.as(Date.self), dateTwo)

        let dateThree = NSDate(timeIntervalSinceReferenceDate: 6)
        let dateFour = NSDate(timeIntervalSinceReferenceDate: 7)
        value = dateThree
        XCTAssertEqual(value.as(NSDate.self), dateThree)
        value = Date(timeIntervalSinceReferenceDate: dateFour.timeIntervalSinceReferenceDate)
        XCTAssertEqual(value.as(NSDate.self), dateFour)

        let dataOne = Data(bytes: [1, 2, 3])
        let dataTwo = Data(bytes: [4, 5, 6])
        value = dataOne
        XCTAssertEqual(value.as(Data.self), dataOne)
        value = NSData(data: dataTwo)
        XCTAssertEqual(value.as(Data.self), dataTwo)

        let dataThree = NSData(data: Data(bytes: [7, 8, 9]))
        let dataFour = NSData(data: Data(bytes: [10, 11, 12]))
        value = dataThree
        XCTAssertEqual(value.as(NSData.self), dataThree)
        value = dataFour.subdata(with: NSRange(location: 0, length: dataFour.length))
        XCTAssertEqual(value.as(NSData.self), dataFour)

        var arrayOne: [PropertyListValue] = [−1, −2, −3]
        var arrayTwo: [PropertyListValue] = [−4, −5, −6]
        value = arrayOne
        XCTAssertEqual(value.asArray(of: Int.self)?.contains(−1), true)
        value = NSArray(array: arrayTwo)
        XCTAssertEqual(value.asArray(of: Int.self)?.contains(−4), true)

        var dictionaryOne: [String: PropertyListValue] = ["1": 1, "2": 2, "3": 3]
        var dictionaryTwo: [String: PropertyListValue] = ["4": 4, "5": 5, "6": 6]
        value = dictionaryOne
        XCTAssertEqual(value.asDictionary(of: Int.self)?["3"], 3)
        value = NSDictionary(dictionary: dictionaryTwo)
        XCTAssertNotNil(value.as([String: PropertyListValue].self))
        XCTAssertEqual(value.asDictionary(of: Int.self)?["6"], 6)
        value = true
        XCTAssertNil(value.as([String: PropertyListValue].self))

        let dictionaryThree: [NSString: PropertyListValue] = [NSString(string: "1"): 1, NSString(string: "2"): 2, NSString(string: "3"): 3]
        let dictionaryFour: [NSString: PropertyListValue] = [NSString(string: "4"): 4, NSString(string: "5"): 5, NSString(string: "6"): 6]
        value = dictionaryThree
        XCTAssertEqual(value.asDictionary(of: Int.self)?["3"], 3)
        value = NSDictionary(dictionary: dictionaryFour)
        XCTAssertNotNil(value.as([String: PropertyListValue].self))
        XCTAssertEqual(value.asDictionary(of: Int.self)?["6"], 6)
        value = true
        XCTAssertNil(value.as([String: PropertyListValue].self))

        arrayOne = [1, 2.0, "3"]
        arrayTwo = [4, 5.0, "6"]
        value = arrayOne
        XCTAssertEqual(value.as([PropertyListValue].self)?.contains(where: { $0.equatableRepresentation == 1.equatableRepresentation }), true)
        value = NSArray(array: arrayTwo)
        XCTAssertEqual(value.as([PropertyListValue].self)?.contains(where: { $0.equatableRepresentation == 4.equatableRepresentation }), true)

        value = arrayOne
        XCTAssertEqual(value.as(NSArray.self)?.count, 3)
        value = NSArray(array: arrayTwo)
        XCTAssertEqual(value.as(NSArray.self)?.count, 3)

        dictionaryOne = ["1": 1, "2": 2.0, "3": "3"]
        dictionaryTwo = ["4": 4, "5": 5.0, "6": "6", "7": 7 as UInt, "8": 8 as Int64, "9": 9 as UInt64, "10": 10 as Int32, "11": 11 as UInt32, "12": 12 as Int16, "13": 13 as UInt16, "14": 14 as Int8, "15": 15 as UInt8, "16": 16.0 as Float, "17": NSDate(), "18": NSData(), "19": [NSString()], "20": [NSString(): NSString()], "21": NSArray(array: arrayTwo)]
        value = dictionaryOne
        XCTAssertEqual(value.as([String: PropertyListValue].self)?["3"]?.as(String.self), "3")
        value = NSDictionary(dictionary: dictionaryTwo)
        XCTAssertNotNil(value.as([String: PropertyListValue].self))
        XCTAssertEqual(value.as([String: PropertyListValue].self)?["6"]?.as(String.self), "6")
        value = true
        XCTAssertNil(value.as([String: PropertyListValue].self))

        value = dictionaryOne
        XCTAssertEqual((value.as(NSDictionary.self)?["3"] as? PropertyListValue)?.as(String.self), "3")
        value = NSDictionary(dictionary: dictionaryTwo)
        XCTAssertNotNil(value.as(NSDictionary.self))
        XCTAssertEqual((value.as(NSDictionary.self)?["6"] as? PropertyListValue)?.as(String.self), "6")
        value = true
        XCTAssertNil(value.as(NSDictionary.self))
    }

    static var allTests: [(String, (PersistenceTests) -> () throws -> Void)] {
        return [
            ("testCodable", testCodable),
            ("testFileConvertible", testFileConvertible),
            ("testFileManager", testFileManager),
            ("testPreferences", testPreferences),
            ("testPropertyList", testPropertyList)
        ]
    }
}
