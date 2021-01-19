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

  func testXMLElement() throws {
    XCTAssertNil(try? XML.Element(source: "<element>"))
    XCTAssertEqual(
      try XML.Element(source: "<element><![CDATA[<xml>]]></element>"),
      XML.Element(name: "element", content: [.characterData(XML.CharacterData(text: "<xml>"))])
    )
  }

  func testXMLElementAttributes() throws {
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
  }

  func testXMLElementEmpty() throws {
    try testXML(
      element: XML.Element(name: "empty"),
      specification: "Empty",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLElementEscapedAttributes() throws {
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

  func testXMLElementEscapedText() throws {
    try testXML(
      element: XML.Element(name: "text", content: ["1 < 2"]),
      specification: "Escaped Text",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLElementNested() throws {
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
  }

  func testXMLElementText() throws {
    try testXML(
      element: XML.Element(name: "text", content: ["Hello, world!"]),
      specification: "Text",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLEncoderArray() throws {
    try testXML(
      of: ["A", "B", "C"],
      specification: "Array",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLEncoderDictionary() throws {
    try testXML(
      of: [
        "key": "value",
        "Schlüssel": "Wert",
        "clef": "valeur",
      ],
      specification: "Dictionary",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLEncoderString() throws {
    try testXML(
      of: "string",
      specification: "String",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLEncoderStructure() throws {
    struct Nested: Codable {
      var a: String = "A"
      var b: String = "B"
    }
    struct Structure: Codable {
      var boolean: Bool = false
      var optional: Bool?
      var integer: Int = 0
      var eightBitInteger: Int8 = 0
      var sixteenBitInteger: Int16 = 0
      var thirtyTwoBitInteger: Int32 = 0
      var sixtyFourBitInteger: Int64 = 0
      var unsignedInteger: UInt = 0
      var eightBitUnsignedInteger: UInt8 = 0
      var sixteenBitUnsignedInteger: UInt16 = 0
      var thirtyTwoBitUnsignedInteger: UInt32 = 0
      var sixtyFourBitUnsignedInteger: UInt64 = 0
      var double: Double = 0
      var float: Float = 0
      var nested: Nested = Nested()
    }
    try testXML(
      of: Structure(),
      specification: "Structure",
      overwriteSpecificationInsteadOfFailing: false
    )
  }
}
