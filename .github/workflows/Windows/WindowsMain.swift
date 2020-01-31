/*
 WindowsMain.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

@testable import SDGControlFlowTests
@testable import SDGWindowsTests

extension SDGControlFlowAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCaching", testCaching),
      ("testCodable", testCodable),
      ("testNonmutatingVariants", testNonmutatingVariants),
      ("testPerformanceTest", testPerformanceTest),
      ("testShared", testShared),
      ("testSharedProperty", testSharedProperty),
      ("testWeak", testWeak),
    ])
  ]
}

extension WindowsTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testControlFlow", testControlFlow),
      ("testLogic", testLogic),
      ("testMathematics", testMathematics),
      ("testCollections", testCollections),
      ("testText", testText),
      ("testPersistence", testPersistence),
      ("testLocalization", testLocalization),
      ("testCornerstoneLocalizations", testCornerstoneLocalizations),
      ("testTesting", testTesting),
      ("testXCTest", testXCTest),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGControlFlowAPITests.windowsTests
tests += WindowsTests.windowsTests

XCTMain(tests)
