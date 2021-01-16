/*
 XML.CharacterData.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML {

  /// XML character data.
  public struct CharacterData: Equatable, ExpressibleByStringLiteral {

    // MARK: - Initialization

    /// Creates character data from text.
    ///
    /// - Parameters:
    ///   - text: The text.
    public init(text: StrictString) {
      self.text = text
    }

    /// Creates character data from text that is already in escaped form.
    ///
    /// - Parameters:
    ///   - escapedText: The text.
    public init(escapedText: StrictString) {
      self.text = CharacterData.unescape(escapedText)
    }

    // MARK: - Properties

    /// The text of the character data.
    public var text: StrictString

    /// The text of the character data with escapes applied.
    public var escapedText: StrictString {
      get {
        return CharacterData.escape(text)
      }
      set {
        text = CharacterData.unescape(newValue)
      }
    }
    private static func escape(_ text: StrictString) -> StrictString {
      #warning("Not implemented yet.")
      return text
    }
    private static func unescape(_ text: StrictString) -> StrictString {
      #warning("Not implemented yet.")
      return text
    }

    // MARK: - ExpressibleByStringLiteral

    public init(stringLiteral value: String) {
      self.init(text: StrictString(value))
    }
  }
}
