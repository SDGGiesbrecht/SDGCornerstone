/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGExternalProcess

import XCTest

import SDGXCTestUtilities

class APITests: TestCase {

  func testExternalProcess() {

    forAllLegacyModes {
      #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
        XCTAssertNil(
          ExternalProcess(
            searching: [
              "/no/such/file",
              "/tmp",  // Directory
              "/.file", "/dev/null",  // Not executable
            ].map({ URL(fileURLWithPath: $0) }),
            commandName: nil,
            validate: { (_: ExternalProcess) in true }
          ),
          "Failed to reject non‐executables."
        )
      #endif
      #if !PLATFORM_LACKS_SWIFT_COMPILER
        #if !os(Windows)  // #workaround(Fails and needs debugging.)
          XCTAssertEqual(
            ExternalProcess(
              searching: [
                "/no/such/file",
                "/tmp",  // Directory
                "/.file",  // Not executable
              ].map({ URL(fileURLWithPath: $0) }),
              commandName: "swift",
              validate: { _ in true }
            )?.executable.deletingPathExtension().lastPathComponent,
            "swift",
            "Failed to find with “which” (or “where” on Windows)."
          )
        #endif
      #endif
      XCTAssertNil(
        ExternalProcess(
          searching: [
            "/no/such/file",
            "/tmp",  // Directory
            "/.file",  // Not executable
          ].map({ URL(fileURLWithPath: $0) }),
          commandName: "swift",
          validate: { _ in false }
        ),
        "Failed to reject the executable according to custom validation."
      )
    }
  }

  func testExternalProcessError() {
    #if !PLATFORM_LACKS_FOUNDATION_PROCESS
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
    _ = ExternalProcess.Error.foundationError(NSError(domain: "", code: 1, userInfo: nil))
      .presentableDescription()
    _ = ExternalProcess.Error.processError(code: 1, output: "").presentableDescription()
  }

  func testShell() throws {
    // #workaround(Swift 5.3.2, Shell misbehaves. See RegressionTests.testCMDWorks.)
    #if !os(Windows)
      try forAllLegacyModes { () throws -> Void in
        let directory: URL?
        #if os(Android)
          directory = URL(fileURLWithPath: "/data/local/tmp")
        #else
          directory = nil
        #endif
        #if !PLATFORM_LACKS_FOUNDATION_PROCESS
          _ = try Shell.default.run(command: ["ls"], in: directory).get()
        #endif
        let printWorkingDirectory: String
        #if os(Windows)
          printWorkingDirectory = "cd"
        #else
          printWorkingDirectory = "pwd"
        #endif
        #if !PLATFORM_LACKS_FOUNDATION_PROCESS
          _ = try Shell.default.run(
            command: [printWorkingDirectory],
            in: URL(fileURLWithPath: "/"),
            with: [:]
          ).get()
        #endif

        let message = "Hello, world!"
        #if !PLATFORM_LACKS_FOUNDATION_PROCESS
          XCTAssertEqual(try Shell.default.run(command: ["echo", message]).get(), message)
        #endif

        let nonexistentCommand = "no‐such‐command"
        #if !PLATFORM_LACKS_FOUNDATION_PROCESS
          let result = Shell.default.run(command: [nonexistentCommand])
          switch result {
          case .success(let output):
            XCTFail("Should have failed: \(output)")
          case .failure(let error):
            switch error {
            case .foundationError(let error):
              XCTFail(error.localizedDescription)
            case .processError(code: _, let output):
              XCTAssert(
                output.contains("not found") ∨ output.contains("not recognized"),
                "\(error)"
              )
            }
          }
        #endif

        #if !os(Windows)  // echo’s exemptional quoting behaviour undermines the test.
          #if !PLATFORM_LACKS_FOUNDATION_PROCESS
            let metacharacters = "(...)"
            XCTAssertEqual(
              try Shell.default.run(command: ["echo", Shell.quote(metacharacters)]).get(),
              metacharacters
            )
            XCTAssert(
              ¬(try Shell.default.run(command: ["echo", Shell.quote("Hello, world!")]).get()
                .contains(
                  "\u{22}"
                ))
            )
          #endif
        #endif

        _ = "\(Shell.default)"
        #if !PLATFORM_LACKS_FOUNDATION_PROCESS
          switch (Shell.default.wrappedInstance as! ExternalProcess).run(["/c", "..."]) {
          case .failure(let error):
            // Expected.
            _ = error.localizedDescription
          case .success(let output):
            XCTFail("Shell should have thrown an error. Output received:\n\(output)")
          }
        #endif
      }
    #endif
    _ = Shell.quote("...")
    _ = Shell.quote(" ")
  }
}
