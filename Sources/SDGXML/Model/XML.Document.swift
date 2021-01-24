/*
 XML.Document.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

#if !PLATFORM_LACKS_FOUNDATION_XML
  extension XML.Document: Decodable {}
#endif
extension XML {

  /// An XML document.
  public struct Document: CustomStringConvertible, Encodable {

    // MARK: - Initialization

    /// Creates an XML document.
    ///
    /// - Parameters:
    ///   - rootElement: The root element.
    public init(rootElement: Element) {
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

    /// The root element.
    public var rootElement: Element

    // MARK: - Source

    /// The source of the element.
    public func source() -> StrictString {
      return rootElement.source()
    }

    // MARK: - CustomStringConvertible

    public var description: String {
      return String(source())
    }

    #if !PLATFORM_LACKS_FOUNDATION_XML
      // MARK: - Decodable

      public init(from decoder: Swift.Decoder) throws {
        try self.init(from: decoder, via: StrictString.self) { string in
          return try XML.Document(source: string)
        }
      }
    #endif

    // MARK: - Encodable

    public func encode(to encoder: Swift.Encoder) throws {
      try encode(to: encoder, via: source())
    }
  }
}
