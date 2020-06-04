/*
 RegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGExternalProcess

import XCTest

import SDGXCTestUtilities

class RegressionTests: TestCase {

  func testDelayedShellOutput() throws {
    // Untracked

    #if !(os(iOS) || os(watchOS) || os(tvOS))
      try forAllLegacyModes {
        let longCommand = [
          "git", "ls\u{2D}remote", "\u{2D}\u{2D}tags", "https://github.com/realm/jazzy",
        ]
        // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
        #if !os(Android)
          let output = try Shell.default.run(command: longCommand).get()
          XCTAssert(output.contains("0.8.3"))
        #endif
      }
    #endif
  }

  func testSearchFindsGit() {
    // Untracked

    #if !(os(iOS) || os(watchOS) || os(tvOS))
      // #workaround(Swift 5.2.4, Process/Pipe/FileHandle have wires crossed with standard output.)
      #if !os(Android)
        XCTAssertNotNil(
          ExternalProcess(
            searching: [],
            commandName: "git",
            validate: { process in
              return (try? process.run(["\u{2D}\u{2D}version"]).get()) ≠ nil
            }
          )
        )
      #endif
    #endif
  }
}
