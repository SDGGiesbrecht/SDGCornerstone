/*
 XML.Element.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML {

  /// An XML element.
  public struct Element: Equatable {

    // MARK: - Static Methods

    /// Parses a single XML element from its source.
    ///
    /// - Parameters:
    ///   - source: The source of the XML element.
    public static func parse(source: StrictString) throws -> Element {
      #warning("Switch to initializer if no specialized errors?")
      let document = try XML.Document.parse(source: source)
      return document.rootElement
    }

    // MARK: - Initialization

    /// Creates an element with a particular name.
    ///
    /// - Parameters:
    ///   - name: The name.
    ///   - content: The content.
    public init(name: StrictString, content: [XML.Content] = []) {
      self.name = name
      self.content = content
    }

    /// Creates an element with a particular name that is already in escaped form.
    ///
    /// - Parameters:
    ///   - escapedName: The name in escaped form.
    ///   - content: The content.
    public init(escapedName: StrictString, content: [XML.Content] = []) {
      self.name = Element.unescape(escapedName)
      self.content = content
    }

    // MARK: - Properties

    /// The name of the element.
    public var name: StrictString

    /// The name of the element with character escapes applied.
    public var escapedName: StrictString {
      get {
        return Element.escape(name)
      }
      set {
        name = Element.unescape(newValue)
      }
    }
    private static func escape(_ name: StrictString) -> StrictString {
      #warning("Not implemented yet.")
      return name
    }
    private static func unescape(_ name: StrictString) -> StrictString {
      #warning("Not implemented yet.")
      return name
    }

    /// The content of the element.
    public var content: [XML.Content]

    // MARK: - Source

    /// The source of the element.
    public func source() -> StrictString {
      let contentSource = StrictString(content.lazy.map({ $0.source() }).joined())
      return "<\(escapedName)>\(contentSource)</\(escapedName)>"
    }
  }
}
