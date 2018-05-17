/*
 SDGExternalProcessAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGExternalProcess

import SDGXCTestUtilities

class SDGExternalProcessAPITests : TestCase {

    func testExternalProcess() {
        #if !(os(iOS) || os(watchOS) || os(tvOS))

        XCTAssertNil(ExternalProcess(searching: [
            "/no/such/file",
            "/tmp", // Directory
            "/.file" // Not executable
            ].map({ URL(fileURLWithPath: $0) }), commandName: nil, validate: { (_: ExternalProcess) in true }), "Failed to reject non‐executables.")
        XCTAssertEqual(ExternalProcess(searching: [
            "/no/such/file",
            "/tmp", // Directory
            "/.file" // Not executable
            ].map({ URL(fileURLWithPath: $0) }), commandName: "swift", validate: { _ in true })?.executable.lastPathComponent, "swift", "Failed to find with “which”.")
        XCTAssertNil(ExternalProcess(searching: [
            "/no/such/file",
            "/tmp", // Directory
            "/.file" // Not executable
            ].map({ URL(fileURLWithPath: $0) }), commandName: "swift", validate: { _ in false }), "Failed to reject the executable according to custom validation.")
        #endif
    }

    func testExternalProcessError() {
        #if !(os(iOS) || os(watchOS) || os(tvOS))
        do {
            try Shell.default.run(command: ["/no/such/process"])
            XCTFail("Process should have thrown an error.")
        } catch {
            _ = String(describing: error)
        }
        #endif
    }

    func testShell() {

        #if !(os(iOS) || os(watchOS) || os(tvOS))

        var command = ["ls"]
        do {
            try Shell.default.run(command: command)
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        command = ["pwd"]
        do {
            try Shell.default.run(command: command, in: URL(fileURLWithPath: "/"), with: [:])
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        let message = "Hello, world!"
        command = ["echo", message]
        do {
            let result = try Shell.default.run(command: command)
            XCTAssertEqual(result, message)
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        let nonexistentCommand = "no‐such‐command"
        let threw = expectation(description: "Error thrown for unidentified command.")
        do {
            try Shell.default.run(command: [nonexistentCommand])
        } catch let error as ExternalProcess.Error {
            XCTAssert(error.output.contains("not found"), "Unexpected error: \(command) → \(error)")
            threw.fulfill()
        } catch {
            XCTFail("Wrong error type.")
        }
        waitForExpectations(timeout: 0)

        let metacharacters = "(...)"
        command = ["echo", Shell.quote(metacharacters)]
        do {
            let result = try Shell.default.run(command: command)
            XCTAssertEqual(result, metacharacters)
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        let automatic = "Hello, world!"
        command = ["echo", Shell.quote(automatic)]
        do {
            let result = try Shell.default.run(command: command)
            XCTAssert(¬result.contains("\u{22}"))
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        _ = "\(Shell.default)"
        #endif
    }
}
