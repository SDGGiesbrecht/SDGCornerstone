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
  /// Several related types can be used to customize the XML representation.
  ///
  /// - The `@XML.Attribute` property wrapper can be applied to `LosslessStringConvertible` properties to make them encode as an attributes instead of as child elements.
  /// - `XML.Element` instances are encoded vertabim, so custom XML can be assembled and fed to the encoder.
  ///
  /// ```swift
  /// struct Document: Codable {
  ///
  ///   var basicChildElement: String = "basic child element"
  ///
  ///   @XML.Attribute var attribute: String = "attribute"
  ///
  ///   struct CustomChild: Codable {
  ///     init() {}
  ///     func encode(to encoder: Encoder) throws {
  ///       var container = encoder.singleValueContainer()
  ///       try container.encode(XML.Element(name: "custom", content: [
  ///         .characterData("A mix of text and "),
  ///         .element(XML.Element(name: "elements")),
  ///         .characterData(".")
  ///       ]))
  ///     }
  ///     init(from decoder: Decoder) throws {
  ///       let container = try decoder.singleValueContainer()
  ///       let element = try container.decode(XML.Element.self)
  ///       XCTAssertEqual(element.name, "custom")
  ///       XCTAssertEqual(element.content.first?.description, "A mix of text and ")
  ///     }
  ///   }
  ///   var custom: CustomChild = CustomChild()
  /// }
  ///
  /// let encoder = XML.Encoder()
  /// let xml = try encoder.encodeToSource(Document())
  /// #warning("Document stuff missing.")
  /// #warning("Root element name not customized.")
  /// XCTAssertEqual(xml, [
  ///   #"<Document attribute="attribute">"#,
  ///   #" <basicChildElement>basic child element</basicChildElement>"#,
  ///   #" <custom>A mix of text and <elements/>.</custom>"#,
  ///   #"</Document>"#
  /// ].joined(separator: "\n"))
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

    public var userInformation: [CodingUserInfoKey: Any]

    // MARK: - Encoding

    /// Encodes a top‐level value as XML source.
    ///
    /// - Parameters:
    ///   - value: The value.
    public func encodeToSource<Value: Encodable>(_ value: Value) throws -> StrictString {
      let implementation = Implementation(
        rootElementName: "\(arbitraryDescriptionOf: Value.self)",
        userInformation: userInformation
      )
      return try implementation.encode(value).source()
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
