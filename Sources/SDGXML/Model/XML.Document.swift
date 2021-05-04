/*
 XML.Document.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if !PLATFORM_LACKS_FOUNDATION_XML
  #if canImport(FoundationXML)
    import FoundationXML
  #endif
#endif

import SDGText
import SDGPersistence

extension XML {

  /// An XML document.
  public struct Document: CustomStringConvertible, Encodable, Equatable {

    // MARK: - Initialization

    /// Creates an XML document.
    ///
    /// - Parameters:
    ///   - dtd: Optional. A DTD.
    ///   - rootElement: The root element.
    public init(dtd: DTD? = nil, rootElement: Element) {
      self.dtd = dtd
      self.rootElement = rootElement
    }

    #if !PLATFORM_LACKS_FOUNDATION_XML
      /// Creates a document by parsing XML source.
      ///
      /// - Parameters:
      ///   - source: The source.
      public init(source: StrictString) throws {
        self = try XML.Parser.parse(source)
      }
    #endif

    // MARK: - Properties

    /// The DTD.
    public var dtd: DTD?

    /// The root element.
    public var rootElement: Element

    // MARK: - Source

    /// The source of the document.
    public func source() -> StrictString {
      var result: [StrictString] = [
        "<?xml version=\u{22}1.1\u{22} encoding=\u{22}UTF\u{2D}8\u{22}?>"
      ]
      if let dtd = dtd {
        result.append(dtd.source(element: rootElement.name))
      }
      result.append(rootElement.source())
      return result.joined(separator: "\n")
    }

    // MARK: - Validation

    #if !PLATFORM_LACKS_FOUNDATION_XML_XML_DOCUMENT
      /// Validates the document according its schema.
      public func validate() throws {
        let foundation = try XMLDocument(xmlString: String(source()))
        try foundation.validate()
      }
    #endif

    // MARK: - CustomStringConvertible

    public var description: String {
      return String(source())
    }

    // MARK: - Encodable

    public func encode(to encoder: Swift.Encoder) throws {
      try encode(to: encoder, via: source())
    }
  }
}

#if !PLATFORM_LACKS_FOUNDATION_XML
  extension XML.Document: Decodable, FileConvertible {

    // MARK: - Decodable

    public init(from decoder: Swift.Decoder) throws {
      try self.init(from: decoder, via: StrictString.self) { string in
        return try XML.Document(source: string)
      }
    }

    // MARK: - FileConvertible

    public init(file: Data, origin: URL?) throws {
      let source = try StrictString(file: file, origin: origin)
      try self.init(source: source)
    }

    public var file: Data {
      return source().file
    }
  }
#endif
