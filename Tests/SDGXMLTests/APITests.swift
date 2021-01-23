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

import SDGCornerstoneLocalizations

import XCTest

import SDGTesting
import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class APITests: TestCase {

  #if !PLATFORM_LACKS_XC_TEST_XC_TEST_EXPECTATION
    static var expectationStorage1: XCTestExpectation?
  #endif
  func resetExpectationStorage() {
    #if !PLATFORM_LACKS_XC_TEST_XC_TEST_EXPECTATION
      APITests.expectationStorage1 = nil
    #endif
  }

  override func setUp() {
    super.setUp()
    resetExpectationStorage()
  }
  override func tearDown() {
    resetExpectationStorage()
    super.tearDown()
  }

  func testXML() {
    _ = XML.unsanitize(name: "%")
  }

  func testXMLAttributeValue() {
    testCustomStringConvertibleConformance(
      of: XML.AttributeValue(text: "attribute text, 0 < 1"),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Attribute",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLCharacterData() {
    testCustomStringConvertibleConformance(
      of: "attribute text, 0 < 1" as XML.CharacterData,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Character Data",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLCoderArray() throws {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      try SDGXMLTests.testXML(
        of: ["A", "B", "C"],
        specification: "Array",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
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
      case e
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
  func testXMLCoderClass() throws {
    try SDGXMLTests.testXML(
      of: Subclass(a: "A", b: "B", c: "C", d: "D"),
      specification: "Class",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  final class UnkeyedSubclass: Superclass, Equatable {
    init(a: String, b: String, c: String, d: String) {
      self.c = c
      self.d = d
      super.init(a: a, b: b)
    }
    var c: String
    var d: String
    required init(from decoder: Decoder) throws {
      var container = try decoder.unkeyedContainer()
      c = try container.decode(String.self)
      d = try container.decode(String.self)
      try super.init(from: try container.superDecoder())
    }
    override func encode(to encoder: Encoder) throws {
      var container = encoder.unkeyedContainer()
      try container.encode(c)
      try container.encode(d)
      try super.encode(to: container.superEncoder())
    }
    static func == (left: UnkeyedSubclass, right: UnkeyedSubclass) -> Bool {
      return (left.a, left.b, left.c, left.d) == (right.a, right.b, right.c, right.d)
    }
  }
  func testXMLCoderClassUnkeyed() throws {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      try SDGXMLTests.testXML(
        of: UnkeyedSubclass(a: "A", b: "B", c: "C", d: "D"),
        specification: "Unkeyed Class",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testXMLCoderCustomized() throws {
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
        let nestedKeyed = try unkeyed.nestedContainer(keyedBy: CodingKeys.self)
        XCTAssertEqual(try nestedKeyed.decode(String.self, forKey: .a), a)
        XCTAssertEqual(try nestedKeyed.decode(String.self, forKey: .b), b)
        XCTAssertEqual(try nestedKeyed.decode(String.self, forKey: .c), c)
        var nestedUnkeyed = try unkeyed.nestedUnkeyedContainer()
        XCTAssertEqual(try nestedUnkeyed.decode(String.self), a)
        XCTAssertEqual(try nestedUnkeyed.decode(String.self), b)
        XCTAssertEqual(try nestedUnkeyed.decode(String.self), c)
        _ = keyed.codingPath
        _ = unkeyed.codingPath
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
        var nestedKeyed = unkeyed.nestedContainer(keyedBy: CodingKeys.self)
        try nestedKeyed.encode(a, forKey: .a)
        try nestedKeyed.encode(b, forKey: .b)
        try nestedKeyed.encode(c, forKey: .c)
        var nestedUnkeyed = unkeyed.nestedUnkeyedContainer()
        try nestedUnkeyed.encode(a)
        try nestedUnkeyed.encode(b)
        try nestedUnkeyed.encode(c)
        _ = keyed.codingPath
        _ = unkeyed.codingPath
      }
    }
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      try SDGXMLTests.testXML(
        of: Customized(),
        specification: "Customized",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testXMLCoderDictionary() throws {
    try SDGXMLTests.testXML(
      of: [
        "key": "value",
        "Schlüssel": "Wert",
        "clef": "valeur",
      ],
      specification: "Dictionary",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLCoderKeyedNil() throws {
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
        case d
      }
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        a = try container.decode(String.self, forKey: .a)
        b = try container.decode(Optional<String>.self, forKey: .b)
        c = try container.decode(String.self, forKey: .c)
        XCTAssert(try container.decodeNil(forKey: .d))
      }
      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(a, forKey: .a)
        try container.encode(b, forKey: .b)
        try container.encode(c, forKey: .c)
        try container.encodeNil(forKey: .d)
      }
    }
    try SDGXMLTests.testXML(
      of: WithNil(a: "A", b: nil, c: "C"),
      specification: "With Keyed Nil",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLCoderNil() throws {
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
        XCTAssert(try container.decodeNil())
        XCTAssertFalse(try container.decodeNil())
      }
      func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(a)
        try container.encode(b)
        try container.encode(c)
        try container.encodeNil()
        try container.encode("non‐nil")
      }
    }
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      try SDGXMLTests.testXML(
        of: WithNil(a: "A", b: nil, c: "C"),
        specification: "With Nil",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testXMLCoderSingleValue() throws {
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
        _ = container.codingPath
      }
      func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
        _ = container.codingPath
      }
    }
    try SDGXMLTests.testXML(
      of: SingleValue(value: Nested()),
      specification: "Single Value",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLCoderString() throws {
    try SDGXMLTests.testXML(
      of: "string",
      specification: "String",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLCoderStructure() throws {
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
    try SDGXMLTests.testXML(
      of: Structure(),
      specification: "Structure",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLCoderUnkeyed() throws {
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
        try container.encode(sixtyFourBitUnsignedInteger)
        try container.encode(double)
        try container.encode(float)
        try container.encode(nested)
      }
    }
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      try SDGXMLTests.testXML(
        of: Unkeyed(),
        specification: "Unkeyed",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testXMLContent() {
    testCustomStringConvertibleConformance(
      of: XML.Content.element(XML.Element(name: "element")),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Content",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLDecoderContainer() throws {
    struct Placeholder: Decodable {
      enum CodingKeys: CodingKey {
        case key
      }
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        XCTAssertEqual(container.codingPath.map({ $0.stringValue }), [])
        #if !PLATFORM_LACKS_XC_TEST_XC_TEST_EXPECTATION
          APITests.expectationStorage1?.fulfill()
        #endif
      }
    }
    #if !PLATFORM_LACKS_XC_TEST_XC_TEST_EXPECTATION
      let tested = expectation(description: "init(from:) called")
      APITests.expectationStorage1 = tested
    #endif
    #if !PLATFORM_LACKS_FOUNDATION_XML
      _ = try XML.Decoder().decode(Placeholder.self, from: "<placeholder></placeholder>")
    #endif
    #if !PLATFORM_LACKS_XC_TEST_XC_TEST_EXPECTATION
      wait(for: [tested], timeout: 0.1)
    #endif
  }

  func testXMLDecoderKeyNotFound() throws {
    struct Nested: Decodable {
      var property: String
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    #if !PLATFORM_LACKS_FOUNDATION_XML
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
    #endif
  }

  func testXMLDecoderTypeMismatch() throws {
    struct Nested: Decodable {
      var property: Int
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    #if !PLATFORM_LACKS_FOUNDATION_XML
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
    #endif
  }

  func testXMLDecoderTypeMismatchCompletixy() throws {
    struct Nested: Decodable {
      var property: String
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    #if !PLATFORM_LACKS_FOUNDATION_XML
      try testErrorDecsription(
        triggerError: { () -> String in
          var caughtError: String = ""
          XCTAssertThrowsError(
            try XML.Decoder().decode(
              Placeholder.self,
              from: "<placeholder><nested><property><child/></property></nested></placeholder>"
            )
          ) { error in
            if let decoding = error as? DecodingError,
              case .typeMismatch(let type, let context) = decoding
            {
              XCTAssert(type == String.self, "Wrong type: \(type)")
              // JSONEncoder’s comparable error does include the key in the context.
              XCTAssertEqual(context.codingPath.map({ $0.stringValue }), ["nested", "property"])
              caughtError = context.debugDescription
            } else {
              XCTFail("Wrong kind of error: \(error)")
            }
          }
          return caughtError
        },
        specification: "Type Complexity Mismatch",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testXMLDecoderTypeMismatchKeyless() throws {
    struct Nested: Decodable {
      var property: Int
      init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        property = try container.decode(Int.self)
      }
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    #if !PLATFORM_LACKS_FOUNDATION_XML
      #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
        try testErrorDecsription(
          triggerError: { () -> String in
            var caughtError: String = ""
            XCTAssertThrowsError(
              try XML.Decoder().decode(
                Placeholder.self,
                from: "<placeholder><nested><first>A</first></nested></placeholder>"
              )
            ) { error in
              if let decoding = error as? DecodingError,
                case .typeMismatch(let type, let context) = decoding
              {
                XCTAssert(type == Int.self, "Wrong type: \(type)")
                // JSONEncoder’s comparable error does include the index in the context.
                XCTAssertEqual(context.codingPath.map({ $0.stringValue }), ["nested", "1"])
                caughtError = context.debugDescription
              } else {
                XCTFail("Wrong kind of error: \(error)")
              }
            }
            return caughtError
          },
          specification: "Keyless Type Mismatch",
          overwriteSpecificationInsteadOfFailing: false
        )
      #endif
    #endif
  }

  func testXMLDecoderTypeMismatchSingleValue() throws {
    struct Nested: Decodable {
      var property: Int
      init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        property = try container.decode(Int.self)
      }
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    #if !PLATFORM_LACKS_FOUNDATION_XML
      try testErrorDecsription(
        triggerError: { () -> String in
          var caughtError: String = ""
          XCTAssertThrowsError(
            try XML.Decoder().decode(
              Placeholder.self,
              from: "<placeholder><nested>A</nested></placeholder>"
            )
          ) { error in
            if let decoding = error as? DecodingError,
              case .typeMismatch(let type, let context) = decoding
            {
              XCTAssert(type == Int.self, "Wrong type: \(type)")
              XCTAssertEqual(context.codingPath.map({ $0.stringValue }), ["nested"])
              caughtError = context.debugDescription
            } else {
              XCTFail("Wrong kind of error: \(error)")
            }
          }
          return caughtError
        },
        specification: "Single Value Type Mismatch",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testXMLDecoderTypeMismatchSingleValueComplexity() throws {
    struct Nested: Decodable {
      var property: String
      init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        property = try container.decode(String.self)
      }
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    #if !PLATFORM_LACKS_FOUNDATION_XML
      try testErrorDecsription(
        triggerError: { () -> String in
          var caughtError: String = ""
          XCTAssertThrowsError(
            try XML.Decoder().decode(
              Placeholder.self,
              from: "<placeholder><nested><child/></nested></placeholder>"
            )
          ) { error in
            if let decoding = error as? DecodingError,
              case .typeMismatch(let type, let context) = decoding
            {
              XCTAssert(type == String.self, "Wrong type: \(type)")
              XCTAssertEqual(context.codingPath.map({ $0.stringValue }), ["nested"])
              caughtError = context.debugDescription
            } else {
              XCTFail("Wrong kind of error: \(error)")
            }
          }
          return caughtError
        },
        specification: "Single Value Complexity Type Mismatch",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testXMLDecoderTypeMismatchUnkeyedComplexity() throws {
    struct Nested: Decodable {
      var property: String
      init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        property = try container.decode(String.self)
      }
    }
    struct Placeholder: Decodable {
      var nested: Nested
    }
    #if !PLATFORM_LACKS_FOUNDATION_XML
      #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
        try testErrorDecsription(
          triggerError: { () -> String in
            var caughtError: String = ""
            XCTAssertThrowsError(
              try XML.Decoder().decode(
                Placeholder.self,
                from: "<placeholder><nested><first><child/></first></nested></placeholder>"
              )
            ) { error in
              if let decoding = error as? DecodingError,
                case .typeMismatch(let type, let context) = decoding
              {
                XCTAssert(type == String.self, "Wrong type: \(type)")
                // JSONEncoder’s comparable error does include the index in the context.
                XCTAssertEqual(context.codingPath.map({ $0.stringValue }), ["nested", "1"])
                caughtError = context.debugDescription
              } else {
                XCTFail("Wrong kind of error: \(error)")
              }
            }
            return caughtError
          },
          specification: "Unkeyed Complexity Type Mismatch",
          overwriteSpecificationInsteadOfFailing: false
        )
      #endif
    #endif
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
    #if !PLATFORM_LACKS_FOUNDATION_XML
      #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
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
      #endif
    #endif
  }

  func testXMLDocument() {
    testCustomStringConvertibleConformance(
      of: XML.Document(rootElement: XML.Element(name: "root")),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Document",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLElement() throws {
    #if !PLATFORM_LACKS_FOUNDATION_XML
      XCTAssertNil(try? XML.Element(source: "<element>"))
      XCTAssertEqual(
        try XML.Element(source: "<element><![CDATA[<xml>]]></element>"),
        XML.Element(name: "element", content: [.characterData(XML.CharacterData(text: "<xml>"))])
      )
    #endif
    testCustomStringConvertibleConformance(
      of: XML.Element(name: "element"),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Document",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLElementAttributes() throws {
    try SDGXMLTests.testXML(
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
    try SDGXMLTests.testXML(
      element: XML.Element(name: "empty"),
      specification: "Empty",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLElementEscapedAttributes() throws {
    try SDGXMLTests.testXML(
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
    try SDGXMLTests.testXML(
      element: XML.Element(name: "text", content: ["1 < 2"]),
      specification: "Escaped Text",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXMLElementNested() throws {
    try SDGXMLTests.testXML(
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
    try SDGXMLTests.testXML(
      element: XML.Element(name: "text", content: ["Hello, world!"]),
      specification: "Text",
      overwriteSpecificationInsteadOfFailing: false
    )
  }
}
