/*
 XML.AttributeValue.swift

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

  /// An XML attribute value.
  public struct AttributeValue: Equatable, ExpressibleByStringLiteral {

    private static let illegalCharacters: Set<Unicode.Scalar> = ["&", "\u{27}", "<"]

    // MARK: - Initialization

    /// Creates an attribute value from text.
    ///
    /// - Parameters:
    ///   - text: The text.
    public init(text: StrictString) {
      self.text = text
    }

    // MARK: - Properties

    /// The text of the character data.
    public var text: StrictString

    /// The text of the character data with escapes applied.
    internal var escapedText: StrictString {
      get {
        return AttributeValue.escape(text)
      }
    }
    private static func escape(_ text: StrictString) -> StrictString {
      return text.mutatingMatches(
        for: ConditionalPattern({ $0 ∈ AttributeValue.illegalCharacters })
      ) { match -> StrictString in
        let scalar: Unicode.Scalar = match.contents.first!
        return "&#x\(scalar.hexadecimalCode);"
      }
    }

    // MARK: - ExpressibleByStringLiteral

    public init(stringLiteral value: String) {
      self.init(text: StrictString(value))
    }
  }
}
