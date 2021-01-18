/*
 XML.Encoder.SingleValueContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML.Encoder {

  internal struct SingleValueContainer: SingleValueEncodingContainer {

    // MARK: - Initialization

    internal init(encoder: XML.Encoder.Implementation) {
      self.encoder = encoder
    }

    // MARK: - Properties

    private let encoder: XML.Encoder.Implementation
    private var element: XML.Element {
      get {
        encoder.element
      }
      set {
        encoder.element = newValue
      }
    }

    // MARK: - SingleValueEncodingContainer

    internal var codingPath: [CodingKey] {
      return encoder.codingPath
    }

    internal mutating func encodeNil() throws {}

    internal mutating func encode(_ value: Bool) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: Int) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: Int8) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: Int16) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: Int32) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: Int64) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: UInt) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: UInt8) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: UInt16) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: UInt32) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: UInt64) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: Double) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: Float) throws {
      try encodeLosslessString(value)
    }

    internal mutating func encode(_ value: String) throws {
      element.content = [.characterData(XML.CharacterData(text: StrictString(value)))]
    }
    private mutating func encodeLosslessString<T>(_ value: T) throws
    where T: LosslessStringConvertible {
      try encode(value.description)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
      #warning("Not implemented yet.")
      fatalError()
    }
  }
}
