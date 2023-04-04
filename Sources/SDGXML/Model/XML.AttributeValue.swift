/*
 XML.AttributeValue.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCollections
import SDGText
import SDGPersistence

extension XML {

  /// An XML attribute value.
  public struct AttributeValue: Decodable, Encodable, Equatable, ExpressibleByStringLiteral,
    Sendable, TransparentWrapper
  {

    private static let illegalCharacters: Set<Unicode.Scalar> = ["&", "\u{22}", "<"]

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
      return AttributeValue.escape(text)
    }
    private static func escape(_ text: StrictString) -> StrictString {
      return text.mutatingMatches(
        for: ConditionalPattern({ $0 ∈ AttributeValue.illegalCharacters })
      ) { match -> StrictString in
        let scalar: Unicode.Scalar = match.contents.first!
        return "&#x\(scalar.hexadecimalCode);"
      }
    }

    // MARK: - Decodable

    public init(from decoder: Swift.Decoder) throws {
      try self.init(from: decoder, via: StrictString.self) { string in
        return AttributeValue(text: string)
      }
    }

    // MARK: - Encodable

    public func encode(to encoder: Swift.Encoder) throws {
      try encode(to: encoder, via: text)
    }

    // MARK: - ExpressibleByStringLiteral

    public init(stringLiteral value: String) {
      self.init(text: StrictString(value))
    }

    // MARK: - TransparentWrapper

    public var wrappedInstance: Any {
      return text
    }
  }
}
