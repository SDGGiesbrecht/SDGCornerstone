/*
 ShellTests.swift

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

class ShellTests : TestCase {

    func testShell() {

        #if !(os(iOS) || os(watchOS) || os(tvOS))

            var command = ["ls"]
            do {
                try Shell.default.run(command: command)
            } catch let error as Shell.Error {
                XCTFail("Unexpected error: \(command) → \(error.description)")
            } catch let error {
                XCTFail("Unexpected error: \(command) → \(error)")
            }

            let message = "Hello, world!"
            command = ["echo", message]
            do {
                let result = try Shell.default.run(command: command)
                XCTAssertEqual(result, message)
            } catch let error as Shell.Error {
                XCTFail("Unexpected error: \(command) → \(error.description)")
            } catch let error {
                XCTFail("Unexpected error: \(command) → \(error)")
            }

            let nonexistentCommand = "no‐such‐command"
            let threw = expectation(description: "Error thrown for unidentified command.")
            do {
                try Shell.default.run(command: [nonexistentCommand])
            } catch let error as Shell.Error {
                XCTAssert(error.description.contains("not found"), "Unexpected error: \(command) → \(error.description)")
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
            } catch let error as Shell.Error {
                XCTFail("Unexpected error: \(command) → \(error.description)")
            } catch let error {
                XCTFail("Unexpected error: \(command) → \(error)")
            }

            let automatic = "Hello, world!"
            command = ["echo", Shell.quote(automatic)]
            do {
                let result = try Shell.default.run(command: command)
                XCTAssert(¬result.contains("\u{22}"))
            } catch let error as Shell.Error {
                XCTFail("Unexpected error: \(command) → \(error.description)")
            } catch let error {
                XCTFail("Unexpected error: \(command) → \(error)")
            }
        #endif
    }

    static var allTests: [(String, (ShellTests) -> () throws -> Void)] {
        return [
            ("testShell", testShell)
        ]
    }
}
