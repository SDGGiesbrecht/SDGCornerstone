/*
 APITests.swift

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

class APITests: TestCase {

  func testExternalProcess() {
    #if !(os(iOS) || os(watchOS) || os(tvOS))

      forAllLegacyModes {
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
        // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
        #if !os(Android)
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
    // #workaround(Swift 5.3, Shell misbehaves. See RegressionTests.testCMDWorks.)
    #if !os(Windows)
      #if !(os(iOS) || os(watchOS) || os(tvOS))
        try forAllLegacyModes {
          // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
          #if !os(Android)
            _ = try Shell.default.run(command: ["ls"]).get()
          #endif
          let printWorkingDirectory: String
          #if os(Windows)
            printWorkingDirectory = "cd"
          #else
            printWorkingDirectory = "pwd"
          #endif
          // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
          #if !os(Android)
            _ = try Shell.default.run(
              command: [printWorkingDirectory],
              in: URL(fileURLWithPath: "/"),
              with: [:]
            ).get()
          #endif

          let message = "Hello, world!"
          // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
          #if !os(Android)
            XCTAssertEqual(try Shell.default.run(command: ["echo", message]).get(), message)
          #endif

          let nonexistentCommand = "no‐such‐command"
          // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
          #if !os(Android)
            let result = Shell.default.run(command: [nonexistentCommand])
            switch result {
            case .success(let output):
              XCTFail("Should have failed: \(output)")
            case .failure(let error):
              switch error {
              case .foundationError(let error):
                XCTFail(error.localizedDescription)
              case .processError(code: _, let output):
                // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
                #if !os(Android)
                  XCTAssert(
                    output.contains("not found") ∨ output.contains("not recognized"),
                    "\(error)"
                  )
                #endif
              }
            }
          #endif

          #if !os(Windows)  // echo’s exemptional quoting behaviour undermines the test.
            let metacharacters = "(...)"
            // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
            #if !os(Android)
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
          // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
          #if !os(Android)
            switch (Shell.default.wrappedInstance as! ExternalProcess).run(["/c", "..."]) {
            case .failure(let error):
              // Expected.
              _ = error.localizedDescription
            case .success(let output):
              // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
              #if !os(Android)
                XCTFail("Shell should have thrown an error. Output received:\n\(output)")
              #endif
            }
          #endif
        }
      #endif
    #endif
  }
}
