/*
 XML.Element.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGText

extension XML {

  /// An XML element.
  public struct Element: CustomStringConvertible, Encodable, Equatable {

    // MARK: - Initialization

    /// Creates an element with a particular name.
    ///
    /// - Parameters:
    ///   - name: The name.
    ///   - attributes: The attributes.
    ///   - content: The content.
    public init(
      name: StrictString,
      attributes: [StrictString: AttributeValue] = [:],
      content: [XML.Content] = []
    ) {
      self.name = name
      self.attributes = attributes
      self._content = Element.normalize(content: content)
    }

    #if !PLATFORM_LACKS_FOUNDATION_XML
      /// Creates an element by parsing XML source.
      ///
      /// - Parameters:
      ///   - source: The source of the XML element.
      public init(source: StrictString) throws {
        let document = try XML.Document(source: source)
        self = document.rootElement
      }
    #endif

    // MARK: - Properties

    /// The name of the element.
    public var name: StrictString

    /// The attributes of the element.
    public var attributes: [StrictString: AttributeValue]

    private var _content: [XML.Content]
    /// The content of the element.
    public var content: [XML.Content] {
      get {
        return _content
      }
      set {
        _content = Element.normalize(content: newValue)
      }
    }
    private static func normalize(content: [XML.Content]) -> [XML.Content] {
      var result: [XML.Content] = []
      result.reserveCapacity(content.count)
      for element in content {
        if case .characterData(let characters) = element,
          case .characterData(let previous) = result.last
        {
          result.removeLast()
          result.append(.characterData(CharacterData(text: previous.text + characters.text)))
        } else {
          result.append(element)
        }
      }
      return result
    }

    // MARK: - Source

    /// The source of the element.
    public func source() -> StrictString {
      let attributeSource: StrictString =
        attributes
        .sorted(by: { $0.0 < $1.0 })
        .lazy.map({ " \($0.0)=\u{22}\($0.1.escapedText)\u{22}" })
        .joined()
      if content.isEmpty {
        return "<\(name)\(attributeSource)/>"
      } else {
        let contentSource: StrictString = content
          .lazy.map({ $0.source() })
          .joined()
        return "<\(name)\(attributeSource)>\(contentSource)</\(name)>"
      }
    }

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
  extension XML.Element: Decodable {

    // MARK: - Decodable

    public init(from decoder: Swift.Decoder) throws {
      try self.init(from: decoder, via: StrictString.self) { string in
        return try XML.Element(source: string)
      }
    }
  }
#endif
