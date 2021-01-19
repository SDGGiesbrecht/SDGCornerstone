/*
 XML.Encoder.KeyedContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML.Encoder {

  internal struct KeyedContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {

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

    // MARK: - State

    private func beginElement(named key: CodingKey) {
      encoder.beginElement(named: key)
    }

    private func endElement() {
      encoder.endElement(parentOrderIsSignificant: false, parentIsFormattable: true)
    }

    // MARK: - KeyedEncodingContainerProtocol

    internal var codingPath: [CodingKey] {
      return encoder.codingPath
    }

    internal mutating func encodeNil(forKey key: Key) throws {}

    internal mutating func encode(_ value: Bool, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: Int, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: Int8, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: Int16, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: Int32, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: Int64, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: UInt, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: UInt8, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: UInt16, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: UInt32, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: UInt64, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: Double, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: Float, forKey key: Key) throws {
      try encodeLosslessString(value, forKey: key)
    }

    internal mutating func encode(_ value: String, forKey key: Key) throws {

      beginElement(named: key)
      defer { endElement() }

      element.content = [.characterData(XML.CharacterData(text: StrictString(value)))]
    }
    private mutating func encodeLosslessString<T>(_ value: T, forKey key: Key) throws
    where T: LosslessStringConvertible {
      try encode(value.description, forKey: key)
    }

    internal mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {

      beginElement(named: key)
      defer { endElement() }

      try value.encode(to: encoder)
    }

    internal mutating func nestedContainer<NestedKey>(
      keyedBy keyType: NestedKey.Type,
      forKey key: Key
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {

      beginElement(named: key)
      #warning("This is happening before filling in the container!")
      defer { endElement() }

      return KeyedEncodingContainer(KeyedContainer<NestedKey>(encoder: encoder))
    }

    internal mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {

      beginElement(named: key)
      #warning("This is happening before filling in the container!")
      defer { endElement() }

      return UnkeyedContainer(encoder: encoder)
    }

    internal mutating func superEncoder() -> Encoder {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func superEncoder(forKey key: Key) -> Encoder {
      #warning("Not implemented yet.")
      fatalError()
    }
  }
}
