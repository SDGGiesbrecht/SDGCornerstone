/*
 SDGExternalProcessRegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGExternalProcess

import XCTest

import SDGXCTestUtilities

class SDGExternalProcessRegressionTests: TestCase {

  func testAndroidShell() {
    // Untracked

    #if os(Android)
      func reportError(_ error: Error, task: String) {
        let message = [
          "\nFailed to \(task):",
          "Error: \(error)",
          "Localized: \(error.localizedDescription)",
          "Type: \(type(of: error))",
          ].joined(separator: "\n")
        #warning("Swap")
        print(message)
        XCTFail(message)
      }

      let process = Process()
      process.executableURL = URL(fileURLWithPath: "/system/bin/sh")
      process.arguments = ["\u{2D}c", "echo \u{27}Hello, world!\u{27}"]

      let pipe = Pipe()
      process.standardOutput = pipe
      process.standardError = pipe

      do {
        try process.run()
      } catch {
        reportError(error, task: "run")
      }
    #endif
  }

  func testDelayedShellOutput() throws {
    // Untracked

    // #workaround(Swift 5.1.3, Insufficient information to debug.)
    #if !os(Android)
      #if !(os(iOS) || os(watchOS) || os(tvOS))
        try forAllLegacyModes {
          let longCommand = [
            "git", "ls\u{2D}remote", "\u{2D}\u{2D}tags", "https://github.com/realm/jazzy"
          ]
          let output = try Shell.default.run(command: longCommand).get()
          XCTAssert(output.contains("0.8.3"))
        }
      #endif
    #endif
  }
}
