/*
 SDGExternalProcessAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
            try Shell.default.run(command: ["/no/such/process"]).get()
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
            try Shell.default.run(command: command).get()
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        command = ["pwd"]
        do {
            try Shell.default.run(command: command, in: URL(fileURLWithPath: "/"), with: [:]).get()
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        let message = "Hello, world!"
        command = ["echo", message]
        do {
            let result = try Shell.default.run(command: command).get()
            XCTAssertEqual(result, message)
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        let nonexistentCommand = "no‐such‐command"
        let result = Shell.default.run(command: [nonexistentCommand])
        switch result {
        case .success(let output):
            XCTFail("Should have failed: \(output)")
        case .failure(let error):
            switch error {
            case .foundationError(let error):
                XCTFail(error.localizedDescription)
            case .processError(code: _, output: let output):
                XCTAssert(output.contains("not found"), "Unexpected error: \(command) → \(error)")
            }
        }

        let metacharacters = "(...)"
        command = ["echo", Shell.quote(metacharacters)]
        do {
            let result = try Shell.default.run(command: command).get()
            XCTAssertEqual(result, metacharacters)
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        let automatic = "Hello, world!"
        command = ["echo", Shell.quote(automatic)]
        do {
            let result = try Shell.default.run(command: command).get()
            XCTAssert(¬result.contains("\u{22}"))
        } catch {
            XCTFail("Unexpected error: \(command) → \(error)")
        }

        _ = "\(Shell.default)"
        #endif
    }
}
