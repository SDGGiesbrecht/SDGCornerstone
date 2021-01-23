/*
 Coding Helpers.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGXML

import XCTest

import SDGPersistenceTestUtilities

func testXML<Value>(
  of value: Value,
  specification: StrictString,
  overwriteSpecificationInsteadOfFailing: Bool,
  file: StaticString = #filePath,
  line: UInt = #line
) throws where Value: Codable, Value: Equatable {
  let specifications = testSpecificationDirectory().appendingPathComponent("Codable XML")

  let encoder = XML.Encoder()
  let xml: Data = try encoder.encode(value)
  let source = try StrictString(file: xml, origin: nil)
  compare(
    String(source),
    against: specifications.appendingPathComponent("\(specification).txt"),
    overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing,
    file: file,
    line: line
  )

  let decoder = XML.Decoder()
  #if !PLATFORM_LACKS_FOUNDATION_XML
    let constructed = try decoder.decode(Value.self, from: xml)
    XCTAssertEqual(
      constructed,
      value,
      "Value changed after encoding and decoding.",
      file: file,
      line: line
    )
  #endif
}
