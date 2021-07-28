/*
 RegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollation

import XCTest

import SDGXCTestUtilities

class RegressionTests: TestCase {

  func testוEquivalentToF() {
    let strings = ["ה", "הה", "ו", "וו", "ז", "זז"]
    XCTAssertEqual(CollationOrder.root.collate(strings), strings)
  }
}
