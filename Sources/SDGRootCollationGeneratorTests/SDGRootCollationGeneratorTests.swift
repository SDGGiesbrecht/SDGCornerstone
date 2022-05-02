/*
 SDGRootCollationGeneratorTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

final class SDGRootCollationGeneratorTests: XCTestCase {

  // Fix the spelling of “test” and run the test to execute the generator.
  func testRootCollationGenerator() throws {
    try RootCollationGenerator.main()
  }
}
