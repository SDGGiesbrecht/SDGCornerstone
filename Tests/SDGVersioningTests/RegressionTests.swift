/*
 RegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGVersioning

import XCTest

import SDGXCTestUtilities

class RegressionTests: TestCase {

  func testWindowsGitVersionDetectable() {
    // Untracked

    XCTAssertEqual(Version(firstIn: "git version 2.28.0.windows.1"), Version(2, 28))
  }

  func testVersionRangesCanBeCreated() {
    // Untracked

    XCTAssert(Version(1, 5, 0) < Version(3, 0, 0))
    XCTAssert(Version(2, 0, 0) ∈ Version(1, 5, 0)..<Version(3, 0, 0))
  }
}
