/*
 XCTestManifests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

extension SDGExternalProcessAPITests {
    static let __allTests = [
        ("testExternalProcess", testExternalProcess),
        ("testExternalProcessError", testExternalProcessError),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testShell", testShell),
    ]
}

extension SDGExternalProcessRegressionTests {
    static let __allTests = [
        ("testDelayedShellOutput", testDelayedShellOutput),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGExternalProcessAPITests.__allTests),
        testCase(SDGExternalProcessRegressionTests.__allTests),
    ]
}
#endif
