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

  internal struct KeyedContainer<Key>: KeyedEncodingContainerProtocol, XMLEncoderContainer
  where Key: CodingKey {

    // MARK: - Initialization

    internal init(encoder: XML.Encoder.Implementation) {
      self.encoder = encoder
      encoder.currentElement.ordered = false
    }

    // MARK: - Properties

    internal let encoder: XML.Encoder.Implementation

    // MARK: - Encoding

    private mutating func encodeLosslessString<T>(_ value: T, forKey key: Key) throws
    where T: LosslessStringConvertible {
      try encode(String(describing: value), forKey: key)
    }

    // MARK: - KeyedEncodingContainerProtocol

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
      try encoder.createNewElement(key: key) { element in
        element.data = StrictString(value)
      }
    }

    internal mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
      try encoder.createNewElement(key: key) { _ in
        try value.encode(to: encoder)
      }
    }

    internal mutating func nestedContainer<NestedKey>(
      keyedBy keyType: NestedKey.Type,
      forKey key: Key
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
      return KeyedEncodingContainer(KeyedContainer<NestedKey>(encoder: nestedEncoder(key: key)))
    }

    internal mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
      return UnkeyedContainer(encoder: nestedEncoder(key: key))
    }

    internal mutating func superEncoder() -> Encoder {
      superEncoder(forKey: XML.Encoder.MiscellaneousKey("super"))
    }

    internal mutating func superEncoder<Key>(forKey key: Key) -> Encoder where Key: CodingKey {
      return nestedEncoder(key: key)
    }
  }
}
