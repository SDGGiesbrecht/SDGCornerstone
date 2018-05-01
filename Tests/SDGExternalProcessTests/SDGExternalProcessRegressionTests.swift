/*
 SDGExternalProcessRegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGExternalProcess
import SDGXCTestUtilities

class SDGExternalProcessRegressionTests : TestCase {

    func testDelayedShellOutput() {
        // Untracked

        #if !(os(iOS) || os(watchOS) || os(tvOS))
        let longCommand = ["git", "ls-remote", "--tags", "https://github.com/realm/jazzy"]
        do {
            let output = try Shell.default.run(command: longCommand)
            XCTAssert(output.contains("0.8.3"))
        } catch {
            XCTFail("Unexpected error: \(longCommand) → \(error)")
        }
        #endif
    }
}
