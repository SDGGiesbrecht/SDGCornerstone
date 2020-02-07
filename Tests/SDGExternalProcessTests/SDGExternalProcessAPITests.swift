/*
 SDGExternalProcessAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGExternalProcess

import XCTest

import SDGXCTestUtilities

class SDGExternalProcessAPITests: TestCase {

  func testExternalProcess() {
    #if !(os(iOS) || os(watchOS) || os(tvOS))

      forAllLegacyModes {
        XCTAssertNil(
          ExternalProcess(
            searching: [
              "/no/such/file",
              "/tmp",  // Directory
              "/.file", "/dev/null"  // Not executable
            ].map({ URL(fileURLWithPath: $0) }),
            commandName: nil,
            validate: { (_: ExternalProcess) in true }
          ),
          "Failed to reject non‐executables."
        )
        XCTAssertEqual(
          ExternalProcess(
            searching: [
              "/no/such/file",
              "/tmp",  // Directory
              "/.file"  // Not executable
            ].map({ URL(fileURLWithPath: $0) }),
            commandName: "swift",
            validate: { _ in true }
          )?.executable.lastPathComponent,
          "swift",
          "Failed to find with “which”."
        )
        XCTAssertNil(
          ExternalProcess(
            searching: [
              "/no/such/file",
              "/tmp",  // Directory
              "/.file"  // Not executable
            ].map({ URL(fileURLWithPath: $0) }),
            commandName: "swift",
            validate: { _ in false }
          ),
          "Failed to reject the executable according to custom validation."
        )
      }
    #endif
  }

  func testExternalProcessError() {
    #if !(os(iOS) || os(watchOS) || os(tvOS))
      forAllLegacyModes {
        switch ExternalProcess(at: URL(fileURLWithPath: "/no/such/process")).run([]) {
        case .failure(let error):
          // Expected
          _ = error.localizedDescription
        case .success:
          XCTFail("Process should have thrown an error.")
        }
      }
    #endif
  }

  func testShell() throws {

    #if !(os(iOS) || os(watchOS) || os(tvOS))

      try forAllLegacyModes {
        _ = try Shell.default.run(command: ["ls"]).get()
        let printWorkingDirectory: String
        #if os(Windows)
          printWorkingDirectory = "cd"
        #else
          printWorkingDirectory = "pwd"
        #endif
        _ = try Shell.default.run(
          command: [printWorkingDirectory],
          in: URL(fileURLWithPath: "/"),
          with: [:]
        ).get()

        let message = "Hello, world!"
        XCTAssertEqual(try Shell.default.run(command: ["echo", message]).get(), message)

        let nonexistentCommand = "no‐such‐command"
        let result = Shell.default.run(command: [nonexistentCommand])
        switch result {
        case .success(let output):
          XCTFail("Should have failed: \(output)")
        case .failure(let error):
          switch error {
          case .foundationError(let error):
            XCTFail(error.localizedDescription)
          case .processError(code: _, let output):
            XCTAssert(output.contains("not found") ∨ output.contains("not recognized"), "\(error)")
          }
        }

        #if !os(Windows)  // echo’s exemptional quoting behaviour undermines the test.
          let metacharacters = "(...)"
          XCTAssertEqual(
            try Shell.default.run(command: ["echo", Shell.quote(metacharacters)]).get(),
            metacharacters
          )
          XCTAssert(
            ¬(
              try Shell.default.run(command: ["echo", Shell.quote("Hello, world!")]).get().contains(
                "\u{22}"
              )
            )
          )
        #endif

        _ = "\(Shell.default)"
        switch (Shell.default.wrappedInstance as! ExternalProcess).run(["..."]) {
        case .failure(let error):
          // Expected.
          _ = error.localizedDescription
        case .success(let output):
          XCTFail("Shell should have thrown an error. Output received:\n\(output)")
        }
      }
    #endif
  }
}
