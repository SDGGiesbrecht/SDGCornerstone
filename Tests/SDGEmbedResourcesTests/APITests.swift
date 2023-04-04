/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

final class APITests: XCTestCase {
  func testResources() {
    // @example(useOfEmbeddedResources)
    let data: Data = Resources.rawData
    let text: String = Resources.textFile
    // @endExample
    XCTAssertEqual(text.dropLast(), "Hello, world!")
    XCTAssertEqual(data.count, text.utf8.count)
  }
}
