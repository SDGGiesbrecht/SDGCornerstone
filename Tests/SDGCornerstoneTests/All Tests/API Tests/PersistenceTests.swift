/*
 PersistenceTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

import SDGXCTestUtilities

class PersistenceTests : TestCase {

    func testCodable() {
        XCTAssertRecodes("àbçđę..." as StrictString, equivalentFormats: ["[\u{22}àbçđę...\u{22}]", "[\u{22}\u{E0}b\u{E7}đ\u{119}\u{2026}\u{22}]"])
        XCTAssertRecodes(SemanticMarkup("àbçđę...").superscripted(), equivalentFormats: ["[\u{22}\u{107000}àbçđę...\u{107001}\u{22}]", "[\u{22}\u{107000}\u{E0}b\u{E7}đ\u{119}\u{2026}\u{107001}\u{22}]"])

        #if !(os(iOS) || os(watchOS) || os(tvOS))
        XCTAssertRecodes(0.5 as Float80, equivalentFormats: ["[0.5]"])
        #endif
        XCTAssertRecodes("12 345" as WholeNumber, equivalentFormats: ["[\u{22}12 345\u{22}]"])
        XCTAssertRecodes("−12 345" as Integer, equivalentFormats: ["[\u{22}−12 345\u{22}]"])
        XCTAssertRecodes("−12 345,678 9" as RationalNumber, equivalentFormats: ["[[\u{22}−123 443 211\u{22},\u{22}10 000\u{22}]]"])

        XCTAssertRecodes(0.5.radians, equivalentFormats: ["[0.5]"])
        XCTAssertRecodes(7.days, equivalentFormats: ["[[1814400,259200]]"])

        XCTAssertRecodes(GregorianYear(1234), equivalentFormats: ["[1234]"])
        XCTAssertRecodes(GregorianMonth.january, equivalentFormats: ["[1]"])
        XCTAssertRecodes(GregorianDay(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(GregorianWeekday.sunday, equivalentFormats: ["[1]"])
        XCTAssertRecodes(GregorianHour(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(GregorianMinute(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(GregorianSecond(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(HebrewYear(1234), equivalentFormats: ["[1234]"])
        XCTAssertRecodes(HebrewMonth.tishrei, equivalentFormats: ["[\u{22}1\u{22}]"])
        XCTAssertRecodes(HebrewMonth.adar, equivalentFormats: ["[\u{22}6\u{22}]"])
        XCTAssertRecodes(HebrewMonth.adarI, equivalentFormats: ["[\u{22}6א\u{22}]"])
        XCTAssertRecodes(HebrewMonth.adarII, equivalentFormats: ["[\u{22}6ב\u{22}]"])
        XCTAssertRecodes(HebrewMonth.elul, equivalentFormats: ["[\u{22}12\u{22}]"])
        XCTAssertRecodes(HebrewDay(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(HebrewWeekday.sunday, equivalentFormats: ["[1]"])
        XCTAssertRecodes(HebrewHour(12), equivalentFormats: ["[12]"])
        XCTAssertRecodes(HebrewPart(124), equivalentFormats: ["[124]"])

        XCTAssertRecodes(HebrewMonthAndYear(month: .tishrei, year: 2345), equivalentFormats: ["[[\u{22}1\u{22},2345]]"])

        let hebrew = CalendarDate(hebrew: HebrewMonth.tishrei, 23, 3456, at: 7, part: 890)
        XCTAssertRecodes(hebrew, equivalentFormats: ["[[\u{22}עברי\u{22},\u{22}[[3456,\u{5C}\u{22}1\u{5C}\u{22},23,7,890.0]]\u{22},[217935793900.0,259200]]]"])
        XCTAssertRecodes(CalendarDate(gregorian: .january, 23, 3456, at: 7, 8, 9), equivalentFormats: ["[[\u{22}gregoriano\u{22},\u{22}[[3456,1,23,7,8,9.0]]\u{22},[138059393067.0,259200]]]"])
        XCTAssertRecodes(CalendarDate(Date(timeIntervalSinceReferenceDate: 123456789)), equivalentFormats: ["[[\u{22}Foundation\u{22},\u{22}[123456789]\u{22},[678105567.0,259200]]]"])
        XCTAssertRecodes(hebrew + (12345 as FloatMax).days, equivalentFormats: ["[[\u{22}Δ\u{22},\u{22}[[[3199824000.0,259200],[\u{5C}\u{22}עברי\u{5C}\u{22},\u{5C}\u{22}[[3456,\u{5C}\u{5C}\u{5C}\u{22}1\u{5C}\u{5C}\u{5C}\u{22},23,7,890.0]]\u{5C}\u{22},[217935793900.0,259200]]]]\u{22},[214735969900.0,259200]]]"])

        // Unregistered definitions.
        DateExampleTests.testCustomDate()

        // Expected failures.
        XCTAssertThrows(whileDecoding: "[600]", as: GregorianHour.self) // Invalid raw value.
        XCTAssertThrows(whileDecoding: "[120]", as: GregorianMonth.self) // Invalid raw value.
        XCTAssertThrows(whileDecoding: "[\u{22}12c45\u{22}]", as: WholeNumber.self) // Invalid string.
        XCTAssertThrows(whileDecoding: "[[\u{22}gregoriano\u{22},\u{22}[]\u{22},[138059393067.0,259200]]]", as: CalendarDate.self) // Empty container array.
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
        let preferences = PreferenceSet.preferences(for: testDomain)

        preferences[testKey].value.set(to: true)
        preferences[testKey].value.set(to: nil)
        XCTAssertNil(preferences[testKey].value.as(Bool.self))

        preferences[testKey].value.set(to: true)
        XCTAssertEqual(preferences[testKey].value.as(Bool.self), true)

        preferences[testKey].value.set(to: 10)
        XCTAssertEqual(preferences[testKey].value.as(Int.self), 10)

        preferences[testKey].value.set(to: "A")
        XCTAssertEqual(preferences[testKey].value.as(String.self), "A")
        preferences[testKey].value.set(to: nil)
        XCTAssertNil(preferences[testKey].value.as(String.self))

        preferences[testKey].value.set(to: true)
        #if os(macOS)
            do {let output = try Shell.default.run(command: ["defaults", "read", testDomainExternalName, testKey], silently: true)
                XCTAssertEqual(output, "1", "Failed to write preferences to disk.")
            } catch let error {
                XCTFail("Unexpected error: \((error as? Shell.Error)?.description ?? "\(error)")")
            }
        #elseif os(Linux)
            let url = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(".config/\(testDomainExternalName).plist")
            do {
                let data = try Data(from: url)
                let decoded = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
                guard let preferences = decoded as? [String: Any] else {
                    XCTFail("Loading written preference resulted in an unexpected type: \(type(of: decoded))")
                    return
                }
                XCTAssertEqual(preferences[testKey] as? Bool, true, "Failed to write preferences to disk.")
            } catch let error {
                XCTFail("An error occurred while verifying write test: \(error)")
            }
        #endif

        let externalTestKey = "SDGExternalTestKey"
        preferences[externalTestKey].value.set(to: nil)

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
                try data.save(to: url)
            } catch let error {
                XCTFail("An error occurred while setting up read test: \(error)")
            }
        #endif

        let causeSynchronization = "CauseSynchronization"
        preferences[testKey].value.set(to: causeSynchronization)
        XCTAssertEqual(preferences[testKey].value.as(String.self), causeSynchronization)
        #if !(os(iOS) || os(watchOS) || os(tvOS))
            // iOS and tvOS could not externally write this to the disk in the first place (see #if statement above).

            XCTAssertEqual(preferences[externalTestKey].value.as(String.self), stringValue, "Failed to read preferences from disk.")
        #endif

        preferences.reset()
        XCTAssertNil(preferences[testKey].value.as(String.self))
        XCTAssertNil(preferences[externalTestKey].value.as(String.self))

        PreferenceSet.applicationPreferences.reset()
        XCTAssertNil(PreferenceSet.applicationPreferences[testKey].value.as(String.self))
        PreferenceSet.applicationPreferences[testKey].value.set(to: true)
        XCTAssertEqual(PreferenceSet.applicationPreferences[testKey].value.as(Bool.self), true)
        PreferenceSet.applicationPreferences.reset()
    }

    func testURL() {
        let root = URL(fileURLWithPath: "/")
        let users = URL(fileURLWithPath: "/Users")
        let johnDoe = URL(fileURLWithPath: "/Users/John Doe")

        XCTAssert(root < users)
        XCTAssert(users.is(in: root))
        XCTAssert(root.is(in: root))
        XCTAssert(users.is(in: users))
        XCTAssert(johnDoe.is(in: users))

        XCTAssertEqual(users.path(relativeTo: root), "Users")
        XCTAssertEqual(users.path(relativeTo: johnDoe), "/Users")
        XCTAssertEqual(johnDoe.path(relativeTo: users), "John Doe")
    }

    static var allTests: [(String, (PersistenceTests) -> () throws -> Void)] {
        return [
            ("testCodable", testCodable),
            ("testFileConvertible", testFileConvertible),
            ("testFileManager", testFileManager),
            ("testPreferences", testPreferences),
            ("testURL", testURL)
        ]
    }
}
