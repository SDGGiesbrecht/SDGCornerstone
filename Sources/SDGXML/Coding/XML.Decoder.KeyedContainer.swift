/*
 XML.Decoder.KeyedContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

extension XML.Decoder {

  internal struct KeyedContainer<Key>: KeyedDecodingContainerProtocol, XMLDecoderContainer
  where Key: CodingKey {

    // MARK: - Initialization

    internal init(decoder: XML.Decoder.Implementation) {
      self.decoder = decoder
    }

    // MARK: - Properties

    internal let decoder: XML.Decoder.Implementation

    // MARK: - Decoding

    private func decodeFromLosslessString<T>(_ type: T.Type, forKey key: Key) throws -> T
    where T: LosslessStringConvertible {
      let string = try decode(String.self, forKey: key)
      guard let value = T(string) else {
        throw decoder.mismatchedTypeError(T.self, codingPath: decoder.codingPath.appending(key))
      }
      return value
    }

    internal func nestedDecoder(key: CodingKey) throws -> XML.Decoder.Implementation {
      return try decoder.enterElement(key: key) { element in
        return XML.Decoder.Implementation(
          root: element,
          codingPath: decoder.codingPath,
          userInformation: decoder.userInfo
        )
      }
    }

    // MARK: - KeyedDecodingContainerProtocol

    internal var allKeys: [Key] {
      return decoder.currentElement.children.compactMap { child in
        return Key(stringValue: String(child.name))
      }
    }

    internal func contains(_ key: Key) -> Bool {
      return decoder.currentElement.children.contains(where: { child in
        return String(child.name) == key.stringValue
      })
    }

    internal func decodeNil(forKey key: Key) throws -> Bool {
      return ¬contains(key)
    }

    internal func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
      return try decodeFromLosslessString(Bool.self, forKey: key)
    }

    internal func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
      return try decodeFromLosslessString(Int.self, forKey: key)
    }

    internal func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
      return try decodeFromLosslessString(Int8.self, forKey: key)
    }

    internal func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
      return try decodeFromLosslessString(Int16.self, forKey: key)
    }

    internal func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
      return try decodeFromLosslessString(Int32.self, forKey: key)
    }

    internal func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
      return try decodeFromLosslessString(Int64.self, forKey: key)
    }

    internal func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
      return try decodeFromLosslessString(UInt.self, forKey: key)
    }

    internal func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
      return try decodeFromLosslessString(UInt8.self, forKey: key)
    }

    internal func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
      return try decodeFromLosslessString(UInt16.self, forKey: key)
    }

    internal func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
      return try decodeFromLosslessString(UInt32.self, forKey: key)
    }

    internal func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
      return try decodeFromLosslessString(UInt64.self, forKey: key)
    }

    internal func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
      return try decodeFromLosslessString(Double.self, forKey: key)
    }

    internal func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
      return try decodeFromLosslessString(Float.self, forKey: key)
    }

    internal func decode(_ type: String.Type, forKey key: Key) throws -> String {
      return try decoder.enterElement(key: key) { element in
        guard let string = element.data else {
          throw decoder.mismatchedTypeError(String.self, codingPath: decoder.codingPath)
        }
        return String(string)
      }
    }

    internal func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
      return try decoder.enterElement(key: key) { element in
        return try T(from: decoder)
      }
    }

    internal func nestedContainer<NestedKey>(
      keyedBy type: NestedKey.Type,
      forKey key: Key
    ) throws -> KeyedDecodingContainer<NestedKey>
    where NestedKey: CodingKey {
      return KeyedDecodingContainer(KeyedContainer<NestedKey>(decoder: try nestedDecoder(key: key)))
    }

    internal func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
      return UnkeyedContainer(decoder: try nestedDecoder(key: key))
    }

    internal func superDecoder() throws -> Decoder {
      return try superDecoder(forKey: XML.Coder.MiscellaneousKey.super)
    }

    internal func superDecoder<Key>(forKey key: Key) throws -> Decoder where Key: CodingKey {
      return try nestedDecoder(key: key)
    }
  }
}
