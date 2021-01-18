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
#warning("Temporarily @testable")
@testable import SDGXML

import XCTest

import SDGTesting
import SDGPersistenceTestUtilities
import SDGXCTestUtilities

class APITests: TestCase {

  func testXMLElement() throws {
    let specifications = testSpecificationDirectory().appendingPathComponent("XML")

    func testXML(
      element: XML.Element,
      specification: StrictString,
      overwriteSpecificationInsteadOfFailing: Bool,
      file: StaticString = #filePath,
      line: UInt = #line
    ) throws {
      let source = element.source()
      compare(
        String(source),
        against: specifications.appendingPathComponent("\(specification).txt"),
        overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing,
        file: file,
        line: line
      )
      let parsed = try XML.Element(source: source)
      XCTAssertEqual(
        parsed,
        element,
        "Reparsing produced a different element.",
        file: file,
        line: line
      )
    }

    try testXML(
      element: XML.Element(name: "empty"),
      specification: "Empty",
      overwriteSpecificationInsteadOfFailing: false
    )
    try testXML(
      element: XML.Element(name: "text", content: ["Hello, world!"]),
      specification: "Text",
      overwriteSpecificationInsteadOfFailing: false
    )
    try testXML(
      element: XML.Element(
        name: "parent",
        content: [
          .element(XML.Element(name: "child")),
          .element(XML.Element(name: "child")),
        ]
      ),
      specification: "Nested",
      overwriteSpecificationInsteadOfFailing: false
    )
    try testXML(
      element: XML.Element(name: "text", content: ["1 < 2"]),
      specification: "Escaped Text",
      overwriteSpecificationInsteadOfFailing: false
    )
    try testXML(
      element: XML.Element(
        name: "element",
        attributes: [
          "attribute": "value",
          "Eigenschaft": "Wert",
          "attribut": "valeur",
          "ιδιότητα": "τιμή",
        ]
      ),
      specification: "Attributes",
      overwriteSpecificationInsteadOfFailing: false
    )
    XCTAssertNil(try? XML.Element(source: "<element>"))
    XCTAssertEqual(
      try XML.Element(source: "<element><![CDATA[<xml>]]></element>"),
      XML.Element(name: "element", content: [.characterData(XML.CharacterData(text: "<xml>"))])
    )
    try testXML(
      element: XML.Element(
        name: "element",
        attributes: [
          "attribute": "0 < 1"
        ]
      ),
      specification: "Escaped Attribute",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLEncoder() throws {
    enum Keys: CodingKey {
      case a
    }
    var x = XML.Encoder.SingleValueContainer(name: "placeholder", codingPath: [])
    try x.encode(true)
    print(x.element.source())
    #warning("Temporarily disabled.")
    #if false
      let specifications = testSpecificationDirectory().appendingPathComponent("Codable XML")

      func testXML<Value: Encodable>(
        of value: Value,
        specification: StrictString,
        overwriteSpecificationInsteadOfFailing: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
      ) throws {
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
    #endif
  }
}
