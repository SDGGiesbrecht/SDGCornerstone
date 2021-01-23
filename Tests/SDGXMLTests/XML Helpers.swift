/*
 XML Helpers.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGXML

import XCTest

import SDGPersistenceTestUtilities

func testXML(
  element: XML.Element,
  specification: StrictString,
  overwriteSpecificationInsteadOfFailing: Bool,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  let specifications = testSpecificationDirectory().appendingPathComponent("XML")

  let source = element.source()
  compare(
    String(source),
    against: specifications.appendingPathComponent("\(specification).txt"),
    overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing,
    file: file,
    line: line
  )
  #if !PLATFORM_LACKS_FOUNDATION_XML
    let parsed = try XML.Element(source: source)
    XCTAssertEqual(
      parsed,
      element,
      "Reparsing produced a different element.",
      file: file,
      line: line
    )
  #endif
}
