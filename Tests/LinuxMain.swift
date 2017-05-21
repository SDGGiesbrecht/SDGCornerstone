/*
 LinuxMain.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
@testable import SDGCornerstoneTests

XCTMain([
    testCase(CachingTests.allTests),
    testCase(CollectionTests.allTests),
    testCase(DataTests.allTests),
    testCase(EnumerationTests.allTests),
    testCase(LogicTests.allTests),
    testCase(LocalizationTests.allTests),
    testCase(MathematicsTests.allTests),
    testCase(RandomizationTests.allTests),
    testCase(TextTests.allTests),

    testCase(RegressionTests.allTests),

    testCase(InternalTests.allTests)
])
