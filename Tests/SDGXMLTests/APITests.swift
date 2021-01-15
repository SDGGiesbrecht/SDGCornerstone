/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGXML

import XCTest

import SDGTesting
import SDGPersistenceTestUtilities
import SDGXCTestUtilities

class APITests: TestCase {

  func testXMLEncoder() throws {
    let specifications = testSpecificationDirectory().appendingPathComponent("Codable XML")

    func testXML<Value: Encodable>(
      of value: Value,
      specification: StrictString,
      overwriteSpecificationInsteadOfFailing: Bool,
      file: StaticString = #filePath,
      line: UInt = #line
    ) throws {
      let encoder = XMLEncoder()
      let xml: Data = try encoder.encode(value)
      let source = try StrictString(file: xml, origin: nil)
      compare(
        String(source),
        against: specifications.appendingPathComponent("\(specification).txt"),
        overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing,
        file: file,
        line: line
      )
    }

    try testXML(
      of: "string",
      specification: "String",
      overwriteSpecificationInsteadOfFailing: false
    )
    try testXML(
      of: [
        "key": "value",
        "Schlüssel": "Wert",
        "clef": "valeur",
      ],
      specification: "Dictionary",
      overwriteSpecificationInsteadOfFailing: false
    )
    try testXML(
      of: ["A", "B", "C"],
      specification: "Dictionary",
      overwriteSpecificationInsteadOfFailing: false
    )
  }
}
