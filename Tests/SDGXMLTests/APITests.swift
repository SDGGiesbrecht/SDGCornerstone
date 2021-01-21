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

  static var expectationStorage1: XCTestExpectation?
  func resetExpectationStorage() {
    APITests.expectationStorage1 = nil
  }

  override func setUp() {
    super.setUp()
    resetExpectationStorage()
  }
  override func tearDown() {
    resetExpectationStorage()
    super.tearDown()
  }

  func testXMLDecoderContainer() throws {
    struct Placeholder: Decodable {
      enum CodingKeys: CodingKey {
        case key
      }
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        XCTAssertEqual(container.codingPath.map({ $0.stringValue }), [])
        APITests.expectationStorage1?.fulfill()
      }
    }
    let tested = expectation(description: "init(from:) called")
    APITests.expectationStorage1 = tested
    _ = try XML.Decoder().decode(Placeholder.self, from: "<placeholder></placeholder>")
    wait(for: [tested], timeout: 0.1)
  }

  func testXMLDecoderKeyNotFound() throws {
    struct Nested: Decodable {
      var property: String
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    try testErrorDecsription(
      triggerError: { () -> String in
        var caughtError: String = ""
        XCTAssertThrowsError(
          try XML.Decoder().decode(
            Placeholder.self,
            from: "<placeholder><nested></nested></placeholder>"
          )
        ) { error in
          if let decoding = error as? DecodingError,
            case .keyNotFound(let key, let context) = decoding
          {
            XCTAssertEqual(key.stringValue, "property")
            // JSONEncoder’s comparable error does not include the key itself in the context.
            XCTAssertEqual(context.codingPath.map({ $0.stringValue }), ["nested"])
            caughtError = context.debugDescription
          } else {
            XCTFail("Wrong kind of error: \(error)")
          }
        }
        return caughtError
      },
      specification: "Missing Key",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLDecoderTypeMismatch() throws {
    struct Nested: Decodable {
      var property: Int
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    try testErrorDecsription(
      triggerError: { () -> String in
        var caughtError: String = ""
        XCTAssertThrowsError(
          try XML.Decoder().decode(
            Placeholder.self,
            from: "<placeholder><nested><property>A</property></nested></placeholder>"
          )
        ) { error in
          if let decoding = error as? DecodingError,
            case .typeMismatch(let type, let context) = decoding
          {
            XCTAssert(type == Int.self, "Wrong type: \(type)")
            // JSONEncoder’s comparable error does include the key in the context.
            XCTAssertEqual(context.codingPath.map({ $0.stringValue }), ["nested", "property"])
            caughtError = context.debugDescription
          } else {
            XCTFail("Wrong kind of error: \(error)")
          }
        }
        return caughtError
      },
      specification: "Type Mismatch",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLDecoderValueNotFound() throws {
    struct Nested: Decodable {
      var a: String
      var b: String
      init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        a = try container.decode(String.self)
        b = try container.decode(String.self)
      }
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    try testErrorDecsription(
      triggerError: { () -> String in
        var caughtError: String = ""
        XCTAssertThrowsError(
          try XML.Decoder().decode(
            Placeholder.self,
            // Element names should be irrelevant in an unkeyed container.
            from: "<placeholder><nested><first>some string</first></nested></placeholder>"
          )
        ) { error in
          if let decoding = error as? DecodingError,
            case .valueNotFound(let type, let context) = decoding
          {
            XCTAssert(type == String.self, "Wrong type: \(type)")
            // JSONEncoder’s comparable error does include the index in the context.
            XCTAssertEqual(context.codingPath.map({ $0.stringValue }), ["nested", "2"])
            caughtError = context.debugDescription
          } else {
            XCTFail("Wrong kind of error: \(error)")
          }
        }
        return caughtError
      },
      specification: "Container End",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

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

  class Superclass: Codable {
    init(a: String, b: String) {
      self.a = a
      self.b = b
    }
    var a: String
    var b: String
  }
  final class Subclass: Superclass, Equatable {
    init(a: String, b: String, c: String, d: String) {
      self.c = c
      self.d = d
      super.init(a: a, b: b)
    }
    var c: String
    var d: String
    enum CodingKeys: CodingKey {
      case c
      case d
    }
    required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      c = try container.decode(String.self, forKey: .c)
      d = try container.decode(String.self, forKey: .d)
      try super.init(from: try container.superDecoder())
    }
    override func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(c, forKey: .c)
      try container.encode(d, forKey: .d)
      try super.encode(to: container.superEncoder())
    }
    static func == (left: Subclass, right: Subclass) -> Bool {
      return (left.a, left.b, left.c, left.d) == (right.a, right.b, right.c, right.d)
    }
  }
  func testXMLEncoderClass() throws {
    try testXML(
      of: Subclass(a: "A", b: "B", c: "C", d: "D"),
      specification: "Class",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLEncoderCustomized() throws {
    struct Customized: Codable, Equatable {
      init() {}
      var a: String = "A"
      var b: String = "B"
      var c: String = "C"
      enum CodingKeys: CodingKey {
        case a
        case b
        case c
        case keyed
        case unkeyed
      }
      init(from decoder: Decoder) throws {
        let all = try decoder.container(keyedBy: CodingKeys.self)
        let keyed = try all.nestedContainer(keyedBy: CodingKeys.self, forKey: .keyed)
        a = try keyed.decode(String.self, forKey: .a)
        b = try keyed.decode(String.self, forKey: .b)
        c = try keyed.decode(String.self, forKey: .c)
        var unkeyed = try all.nestedUnkeyedContainer(forKey: .unkeyed)
        XCTAssertEqual(try unkeyed.decode(String.self), a)
        XCTAssertEqual(try unkeyed.decode(String.self), b)
        XCTAssertEqual(try unkeyed.decode(String.self), c)
      }
      func encode(to encoder: Encoder) throws {
        var all = encoder.container(keyedBy: CodingKeys.self)
        var keyed = all.nestedContainer(keyedBy: CodingKeys.self, forKey: .keyed)
        try keyed.encode(a, forKey: .a)
        try keyed.encode(b, forKey: .b)
        try keyed.encode(c, forKey: .c)
        var unkeyed = all.nestedUnkeyedContainer(forKey: .unkeyed)
        try unkeyed.encode(a)
        try unkeyed.encode(b)
        try unkeyed.encode(c)
      }
    }
    try testXML(
      of: Customized(),
      specification: "Customized",
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

  func testXMLEncoderKeyedNil() throws {
    struct WithNil: Codable, Equatable {
      init(a: String, b: String?, c: String) {
        self.a = a
        self.b = b
        self.c = c
      }
      var a: String
      var b: String?
      var c: String?
      enum CodingKeys: CodingKey {
        case a
        case b
        case c
      }
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        a = try container.decode(String.self, forKey: .a)
        b = try container.decode(Optional<String>.self, forKey: .b)
        c = try container.decode(String.self, forKey: .c)
      }
      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(a, forKey: .a)
        try container.encode(b, forKey: .b)
        try container.encode(c, forKey: .c)
      }
    }
    try testXML(
      of: WithNil(a: "A", b: nil, c: "C"),
      specification: "With Keyed Nil",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLEncoderNil() throws {
    struct WithNil: Codable, Equatable {
      init(a: String, b: String?, c: String) {
        self.a = a
        self.b = b
        self.c = c
      }
      var a: String
      var b: String?
      var c: String?
      init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        a = try container.decode(String.self)
        b = try container.decode(Optional<String>.self)
        c = try container.decode(String.self)
      }
      func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(a)
        try container.encode(b)
        try container.encode(c)
      }
    }
    try testXML(
      of: WithNil(a: "A", b: nil, c: "C"),
      specification: "With Nil",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLEncoderSingleValue() throws {
    struct Nested: Codable, Equatable {
      var a: Bool = false
      var b: Bool = true
    }
    struct SingleValue: Codable, Equatable {
      init(value: Nested) {
        self.value = value
      }
      var value: Nested
      init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(Nested.self)
      }
      func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
      }
    }
    try testXML(
      of: SingleValue(value: Nested()),
      specification: "Single Value",
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
    struct Nested: Codable, Equatable {
      var a: String = "A"
      var b: String = "B"
    }
    struct Structure: Codable, Equatable {
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

  func testXMLEncoderUnkeyed() throws {
    struct Nested: Codable, Equatable {
      var a: String = "A"
      var b: String = "B"
    }
    struct Unkeyed: Codable, Equatable {
      init() {}
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
      init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        boolean = try container.decode(Bool.self)
        optional = try container.decode(Optional<Bool>.self)
        integer = try container.decode(Int.self)
        eightBitInteger = try container.decode(Int8.self)
        sixteenBitInteger = try container.decode(Int16.self)
        thirtyTwoBitInteger = try container.decode(Int32.self)
        sixtyFourBitInteger = try container.decode(Int64.self)
        unsignedInteger = try container.decode(UInt.self)
        eightBitUnsignedInteger = try container.decode(UInt8.self)
        sixteenBitUnsignedInteger = try container.decode(UInt16.self)
        thirtyTwoBitUnsignedInteger = try container.decode(UInt32.self)
        sixtyFourBitUnsignedInteger = try container.decode(UInt64.self)
        double = try container.decode(Double.self)
        float = try container.decode(Float.self)
        nested = try container.decode(Nested.self)
      }
      func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(boolean)
        try container.encode(optional)
        try container.encode(integer)
        try container.encode(eightBitInteger)
        try container.encode(sixteenBitInteger)
        try container.encode(thirtyTwoBitInteger)
        try container.encode(sixtyFourBitInteger)
        try container.encode(unsignedInteger)
        try container.encode(eightBitUnsignedInteger)
        try container.encode(sixteenBitUnsignedInteger)
        try container.encode(thirtyTwoBitUnsignedInteger)
        try container.encode(sixteenBitUnsignedInteger)
        try container.encode(double)
        try container.encode(float)
        try container.encode(nested)
      }
    }
    try testXML(
      of: Unkeyed(),
      specification: "Unkeyed",
      overwriteSpecificationInsteadOfFailing: false
    )
  }
}
