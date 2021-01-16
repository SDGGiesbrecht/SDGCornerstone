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
    public static func parse<Source>(source: Source) -> Result<
      XML.Element, XML.Element.ParsingError
    >
    where Source: Collection, Source.Element == Unicode.Scalar {

      guard source.first == "<" else {
        return .failure(.missingOpeningTag)
      }
      var processing = source.dropFirst()

      guard let nameEnd = processing.firstIndex(of: ">") else {
        return .failure(.missingClosingGreaterThanSign(unterminatedTag: StrictString(source)))
      }
      let name = StrictString(processing[..<nameEnd])
      let contentStart = processing.index(after: nameEnd)
      processing = processing[nameEnd...].dropFirst()

      while let nextTag = processing.firstIndex(of: "<") {
        var tag = processing[nextTag...]
        if tag.dropFirst().first == "/" {  // closing tag
          guard let end = tag.firstIndex(of: ">") else {
            return .failure(.missingClosingGreaterThanSign(unterminatedTag: StrictString(tag)))
          }
          tag = tag[...end]
          let endName = StrictString(tag.dropFirst(2).dropLast())
          guard endName == name else {
            return .failure(.mismatchedClosingTag(element: StrictString(tag)))
          }
          guard tag.endIndex == processing.endIndex else {
            return .failure(.trailingText(text: StrictString(processing[tag.endIndex...])))
          }
          return .success(
            Element(
              escapedName: name,
              content: .characterData(
                XML.CharacterData(escapedText: StrictString(source[contentStart..<nextTag]))
              )
            )
          )
        }
      }

      return .failure(.missingClosingTag(unterminatedElement: StrictString(source)))
    }

    // MARK: - Initialization

    /// Creates an element with a particular name.
    ///
    /// - Parameters:
    ///   - name: The name.
    public init(name: StrictString, content: XML.Content = .empty()) {
      self.name = name
      self.content = content
    }

    /// Creates an element with a particular name that is already in escaped form.
    ///
    /// - Parameters:
    ///   - escapedName: The name in escaped form.
    public init(escapedName: StrictString, content: XML.Content = .empty()) {
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
    public var content: XML.Content

    // MARK: - Source

    /// The source of the element.
    public func source() -> StrictString {
      return "<\(escapedName)>\(content.source())</\(escapedName)>"
    }
  }
}
