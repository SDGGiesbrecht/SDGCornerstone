/*
 XML.Content.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText

extension XML {

  /// The content of an XML element.
  public enum Content: CustomStringConvertible, Equatable, ExpressibleByStringLiteral, Sendable {

    // MARK: - Cases

    /// An element.
    case element(XML.Element)

    /// Character data.
    case characterData(XML.CharacterData)

    // MARK: - Source

    /// The source of the content.
    public func source() -> StrictString {
      switch self {
      case .element(let element):
        return element.source()
      case .characterData(let text):
        return text.escapedText
      }
    }

    // MARK: - ExpressibleByStringLiteral

    public init(stringLiteral value: String) {
      self = .characterData(XML.CharacterData(text: StrictString(value)))
    }

    // MARK: - CustomStringConvertible

    public var description: String {
      return String(source())
    }
  }
}
