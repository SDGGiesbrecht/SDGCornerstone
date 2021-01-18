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
  public struct Element: Equatable {

    // MARK: - Initialization

    /// Creates an element with a particular name.
    ///
    /// - Parameters:
    ///   - name: The name.
    ///   - attributes: The attributes.
    ///   - content: The content.
    public init(
      name: StrictString,
      attributes: [StrictString: StrictString] = [:],
      content: [XML.Content] = []
    ) {
      self.name = name
      self.attributes = attributes
      self._content = Element.normalize(content: content)
    }

    /// Creates an element by parsing XML source.
    ///
    /// - Parameters:
    ///   - source: The source of the XML element.
    public init(source: StrictString) throws {
      let document = try XML.Document(source: source)
      self = document.rootElement
    }

    // MARK: - Properties

    /// The name of the element.
    public var name: StrictString

    /// The name of the element with character escapes applied.
    public var escapedName: StrictString {
      get {
        return Element.escape(name: name)
      }
    }
    private static func escape(name: StrictString) -> StrictString {
      #warning("Not implemented yet.")
      return name
    }

    /// The attributes of the element.
    public var attributes: [StrictString: StrictString]

    /// The attributes of the element with character escapes applied.
    public var escapedAttributes: [StrictString: StrictString] {
      get {
        var result: [StrictString: StrictString] = [:]
        for (key, value) in attributes {
          result[Element.escape(name: key)] = Element.escape(attribute: value)
        }
        return result
      }
    }
    private static func escape(attribute: StrictString) -> StrictString {
      #warning("Not implemented yet.")
      return attribute
    }

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
      let escapedName = self.escapedName
      let attributeSource: StrictString =
        escapedAttributes
        .sorted(by: { $0.0 < $1.0 })
        .lazy.map({ " \($0.0)=\u{22}\($0.1)\u{22}" })
        .joined()
      let contentSource: StrictString = content
        .lazy.map({ $0.source() })
        .joined()
      return "<\(escapedName)\(attributeSource)>\(contentSource)</\(escapedName)>"
    }
  }
}
