/*
 SDGProcessPropertiesTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGProcessProperties

import SDGLogic
import SDGTesting
import SDGXCTestUtilities

class SDGProcessPropertiesTests : TestCase {

    func testBuildConfiguration() {
        if _isDebugAssertConfiguration() {
            test(variable: (BuildConfiguration.current, "BuildConfiguration.current"), is: .debug)
        }
    }

    func testProcess() {
        XCTAssert(ProcessInfo.applicationIdentifier ≠ "", "Failed to retrieve application identifier.")
        XCTAssert(ProcessInfo.domain ≠ "", "Failed to retrieve application domain.")
    }

    static var allTests: [(String, (SDGProcessPropertiesTests) -> () throws -> Void)] {
        return [
            ("testBuildConfiguration", testBuildConfiguration),
            ("testProcess", testProcess)
        ]
    }
}
