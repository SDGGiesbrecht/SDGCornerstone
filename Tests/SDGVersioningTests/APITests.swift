/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGVersioning

import SDGCornerstoneLocalizations

import XCTest

import SDGTesting
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class APITests: TestCase {

  func testVersion() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      testCustomStringConvertibleConformance(
        of: Version(1, 2, 3),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "1.2.3",
        overwriteSpecificationInsteadOfFailing: false
      )

      XCTAssertEqual(Version(firstIn: "1.0.0"), Version(1, 0, 0))
      XCTAssertEqual(Version(firstIn: "1.0"), Version(1, 0, 0))
      XCTAssertEqual(Version(firstIn: "1"), Version(1, 0, 0))
      XCTAssertNil(Version(String("Blah blah blah...")))
      XCTAssertNil(Version(firstIn: "Blah blah blah..."))
      XCTAssertNil(Version(String("1.0.0.0")))
      XCTAssertNil(Version(String("1.0.A")))
      XCTAssertNil(Version(String("1.A")))
      XCTAssertNil(Version(String("A")))
      XCTAssertEqual(Version(1, 0, 0).compatibleVersions.upperBound, Version(2, 0, 0))
      XCTAssertEqual(Version(0, 1, 0).compatibleVersions.upperBound, Version(0, 2, 0))
      XCTAssertEqual(Version(1, 0, 0), "1.0.0")
      XCTAssertEqual(Version(1, 0, 0).string(droppingEmptyPatch: true), "1.0")
      XCTAssertEqual(Version(1, 2, 3).string(droppingEmptyPatch: true), "1.2.3")
      XCTAssert(Version(1, 2, 3) < Version(2, 2, 3))
      XCTAssert(Version(1, 2, 3) < Version(1, 2, 4))
    #endif
  }
}
