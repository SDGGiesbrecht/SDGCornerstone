/*
 SDGPersistenceAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGText
import SDGExternalProcess
import SDGCornerstoneLocalizations

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class SDGPersistenceAPITests : TestCase {

    func testFileConvertible() {
        setTestSpecificationDirectory(to: testSpecificationDirectory())
        testFileConvertibleConformance(of: Data([0x10, 0x20, 0x30]), uniqueTestName: "Binary Data")
        testFileConvertibleConformance(of: "Hello, world!", uniqueTestName: "Hello")
    }

    func testFileManager() throws {
        let destination = FileManager.default.url(in: .applicationSupport, at: "Subdirectory")
        try FileManager.default.withTemporaryDirectory(appropriateFor: destination) { temporaryDirectory in

            let path = "example/path"

            #if os(Linux)
            _ = FileManager.default.url(in: .applicationSupport, at: path)
            #else
            XCTAssert(FileManager.default.url(in: .applicationSupport, at: path).absoluteString.contains("Application%20Support"), "Unexpected support directory.")
            #endif
            XCTAssertNotNil(FileManager.default.url(in: .cache, at: path).absoluteString.scalars.firstMatch(for: AlternativePatterns([LiteralPattern("Cache".scalars), LiteralPattern("cache".scalars)])))
            XCTAssertNotNil(temporaryDirectory.appendingPathComponent(path).absoluteString.scalars.firstMatch(for: AlternativePatterns([LiteralPattern("Temp".scalars), LiteralPattern("temp".scalars), LiteralPattern("tmp".scalars), LiteralPattern("Being%20Saved%20By".scalars)])))

            let directoryName = "Directory"
            let directory = temporaryDirectory.appendingPathComponent(directoryName)
            let file = directory.appendingPathComponent("File.txt")

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

            let sourceDirectory = temporaryDirectory.appendingPathComponent("Source Directory")
            let destinationDirectory = temporaryDirectory.appendingPathComponent("Intermediate Directory/Destination Directory")
            let fileName = "File.txt"
            try fileContents.save(to: sourceDirectory.appendingPathComponent(fileName))
            try FileManager.default.move(sourceDirectory, to: destinationDirectory)
            XCTAssertEqual(try? String(from: destinationDirectory.appendingPathComponent(fileName)), fileContents)
            XCTAssertNil(try? String(from: sourceDirectory.appendingPathComponent(fileName)))
            try? FileManager.default.removeItem(at: temporaryDirectory)
            try fileContents.save(to: sourceDirectory.appendingPathComponent(fileName))
            try FileManager.default.copy(sourceDirectory, to: destinationDirectory)
            XCTAssertEqual(try? String(from: destinationDirectory.appendingPathComponent(fileName)), fileContents)
            XCTAssertEqual(try? String(from: sourceDirectory.appendingPathComponent(fileName)), fileContents)

            let thisFile = URL(fileURLWithPath: #file)
            XCTAssert(try FileManager.default.deepFileEnumeration(in: thisFile.deletingLastPathComponent().deletingLastPathComponent()).contains(thisFile), "Failed to enumerate files.")
        }
    }

    struct LosslessStirngConvertibleExample : CodableViaLosslessStringConvertible, Equatable {
        var value: String
        init(_ value: String) {
            self.value = value
        }
        var description: String {
            return value
        }
    }
    func testLosslessStringConvertible() {
        testCodableConformance(of: LosslessStirngConvertibleExample("Example"), uniqueTestName: "Example")
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
        do {
            let output = try Shell.default.run(command: ["defaults", "read", testDomainExternalName, testKey]).get()
            XCTAssertEqual(output, "1", "Failed to write preferences to disk.")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        #endif

        let externalTestKey = "SDGExternalTestKey"
        preferences[externalTestKey].value.set(to: nil)

        let stringValue = "value"
        #if os(macOS)
        do {
            try Shell.default.run(command: ["defaults", "write", testDomainExternalName, externalTestKey, "\u{2D}string", stringValue])
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        #endif

        let causeSynchronization = "CauseSynchronization"
        preferences[testKey].value.set(to: causeSynchronization)
        XCTAssertEqual(preferences[testKey].value.as(String.self), causeSynchronization)
        #if os(macOS)
        // Only macOS can externally write this to the disk in the first place (see #if statement above).
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

        var mock = Preference.mock()
        mock.set(to: true)
        XCTAssertEqual(mock.as(Bool.self), true)
        XCTAssertNil(mock.as(String.self))
        testCustomStringConvertibleConformance(of: mock, localizations: InterfaceLocalization.self, uniqueTestName: "true", overwriteSpecificationInsteadOfFailing: false)
    }

    func testSpecification() {
        let specifications = testSpecificationDirectory().appendingPathComponent("Specification")

        let new = specifications.appendingPathComponent("New.txt")
        try? FileManager.default.removeItem(at: new)
        compare("New!", against: new, overwriteSpecificationInsteadOfFailing: false)
        try? FileManager.default.removeItem(at: new)

        compare("Overwritten.", against: specifications.appendingPathComponent("Overwrite.txt"), overwriteSpecificationInsteadOfFailing: true)
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
}
