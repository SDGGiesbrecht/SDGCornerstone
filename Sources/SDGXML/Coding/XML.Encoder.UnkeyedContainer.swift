/*
 XML.Encoder.UnkeyedContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

extension XML.Encoder {

  internal struct UnkeyedContainer: UnkeyedEncodingContainer {

    // MARK: - Initialization

    internal init(encoder: XML.Encoder.Implementation) {
      self.encoder = encoder
    }

    // MARK: - Properties

    private let encoder: XML.Encoder.Implementation
    private var element: XML.Element {
      get {
        encoder.currentElement
      }
      set {
        encoder.currentElement = newValue
      }
    }

    // MARK: - UnkeyedEncodingContainer

    internal var codingPath: [CodingKey] {
      return encoder.codingPath
    }

    internal var count: Int {
      return element.content.count
    }

    internal mutating func encodeNil() throws {
      #warning("Not implemented yet.")
      fatalError()
    }

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
      element.content.append(
        .element(
          XML.Element(
            name: XML.sanitize(name: (count + 1).inDigits()),
            content: [.characterData(XML.CharacterData(text: StrictString(value)))]
          )
        )
      )
    }
    private mutating func encodeLosslessString<T>(_ value: T) throws
    where T: LosslessStringConvertible {
      try encode(value.description)
    }

    internal mutating func encode<T>(_ value: T) throws where T: Encodable {
      let key: CodingKey = IndexKey(count + 1)

      encoder.beginElement(named: key)
      defer { encoder.endElement(parentOrderIsSignificant: true) }

      try value.encode(to: encoder)
    }

    internal mutating func nestedContainer<NestedKey>(
      keyedBy keyType: NestedKey.Type
    ) -> KeyedEncodingContainer<NestedKey>
    where NestedKey: CodingKey {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func superEncoder() -> Encoder {
      #warning("Not implemented yet.")
      fatalError()
    }
  }
}
