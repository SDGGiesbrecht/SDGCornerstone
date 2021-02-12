/*
 XML.Encoder.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGPersistence

extension XML {

  // #example(1, xmlEncoding)
  /// An encoder which converts `Encodable` values into XML.
  ///
  /// Several related types can be used to customize the XML representation. All of them are demonstrated in the example that follows.
  ///
  /// - The `@XML.Attribute` property wrapper can be applied to `LosslessStringConvertible` properties to make them encode as an attributes instead of as child elements.
  /// - `XML.Element` instances are encoded vertabim, so custom XML can be assembled and fed to the encoder.
  /// - The `CustomXMLRepresentable` protocol provide additional customization:
  ///   - It can be used to provide a DTD.
  ///   - It can request a default element name be used whenever its name is not already constrained by a coding key. This occurs for the root element of the document, and for elements which occur in an unkeyed container, such as array elements.
  ///
  /// ```swift
  /// struct Document: Codable, CustomXMLRepresentable {
  ///
  ///   var dtd: XML.DTD? {  // CustomXMLRepresentable
  ///     return .system("file://localhost/Some/File.dtd")
  ///   }
  ///
  ///   var defaultElementName: StrictString? {  // CustomXMLRepresentable
  ///     return "document"
  ///   }
  ///
  ///   var basicChildElement: String = "basic child element"
  ///
  ///   @XML.Attribute var attribute: String = "attribute"
  ///
  ///   struct CustomChild: Codable {
  ///     init() {}
  ///     func encode(to encoder: Encoder) throws {
  ///       var container = encoder.singleValueContainer()
  ///       try container.encode(
  ///         XML.Element(
  ///           name: "custom",
  ///           content: [
  ///             .characterData("A mix of text and "),
  ///             .element(XML.Element(name: "elements")),
  ///             .characterData("."),
  ///           ]
  ///         )
  ///       )
  ///     }
  ///     init(from decoder: Decoder) throws {
  ///       let container = try decoder.singleValueContainer()
  ///       let element = try container.decode(XML.Element.self)
  ///       XCTAssertEqual(element.name, "custom")
  ///       XCTAssertEqual(element.content.first?.description, "A mix of text and ")
  ///     }
  ///   }
  ///   var custom: CustomChild = CustomChild()
  ///
  ///   struct UnnamedChild: Codable {
  ///     init() {}
  ///   }
  ///   var unnamedArray: [UnnamedChild] = [UnnamedChild(), UnnamedChild(), UnnamedChild()]
  ///
  ///   struct NamedChild: Codable, CustomXMLRepresentable {
  ///     var defaultElementName: StrictString? {
  ///       return "named"
  ///     }
  ///   }
  ///   var namedArray: [NamedChild] = [NamedChild(), NamedChild(), NamedChild()]
  /// }
  ///
  /// let encoder = XML.Encoder()
  /// let xml = try encoder.encodeToSource(Document())
  /// XCTAssertEqual(
  ///   xml,
  ///   [
  ///     "<?xml version=\u{22}1.1\u{22} encoding=\u{22}UTF\u{2D}8\u{22}?>",
  ///     "<!DOCTYPE document SYSTEM \u{22}file://localhost/Some/File.dtd\u{22}>",
  ///     "<document attribute=\u{22}attribute\u{22}>",
  ///     " <basicChildElement>basic child element</basicChildElement>",
  ///     " <custom>A mix of text and <elements/>.</custom>",
  ///     " <namedArray>",
  ///     "  <named/>",
  ///     "  <named/>",
  ///     "  <named/>",
  ///     " </namedArray>",
  ///     " <unnamedArray>",
  ///     "  <UnnamedChild/>",
  ///     "  <UnnamedChild/>",
  ///     "  <UnnamedChild/>",
  ///     " </unnamedArray>",
  ///     "</document>",
  ///   ].joined(separator: "\n")
  /// )
  /// ```
  public struct Encoder {

    // MARK: - Initialization

    /// Creates an XML encoder.
    ///
    /// - Parameters:
    ///   - userInformation: User‐provided information for use during encoding.
    public init(userInformation: [CodingUserInfoKey: Any] = [:]) {
      self.userInformation = userInformation
    }

    // MARK: - Properties

    /// User information.
    public var userInformation: [CodingUserInfoKey: Any]

    // MARK: - Encoding

    /// Encodes a top‐level value as XML source.
    ///
    /// - Parameters:
    ///   - value: The value.
    public func encodeToSource<Value: Encodable>(_ value: Value) throws -> StrictString {
      let implementation = Implementation(
        rootElementName: StrictString(XML.Coder.MiscellaneousKey(defaultFor: value).stringValue),
        userInformation: userInformation
      )
      let element = try implementation.encode(value)
      let dtd = (value as? CustomXMLRepresentable)?.dtd
      let document = XML.Document(dtd: dtd, rootElement: element)
      return document.source()
    }

    /// Encodes a top‐level value as XML data.
    ///
    /// - Parameters:
    ///   - value: The value.
    public func encode<Value: Encodable>(_ value: Value) throws -> Data {
      return try encodeToSource(value).file
    }
  }
}
