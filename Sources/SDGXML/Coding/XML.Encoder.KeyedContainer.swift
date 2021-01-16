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

    internal init(_ encoder: Implementation) {
      self.encoder = encoder
    }

    // MARK: - Properties

    private let encoder: Implementation

    // MARK: - KeyedEncodingContainerProtocol

    internal var codingPath: [CodingKey] {
      return encoder.codingPath
    }

    internal mutating func encodeNil(forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Bool, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: String, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Double, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Float, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int8, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int16, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int32, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int64, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt8, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt16, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt32, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt64, forKey key: Key) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {

      encoder.codingPath.append(key)
      defer { _ = encoder.codingPath.popLast() }

      var node = encoder.partialNodes.popLast()
      defer {
        if let node = node {
          encoder.partialNodes.append(node)
        }
      }

      node?.children.append((StrictString(key.stringValue), try encoder.box(value)))
    }

    internal mutating func nestedContainer<NestedKey>(
      keyedBy keyType: NestedKey.Type,
      forKey key: Key
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
      #warning("Not implemented yet.")
      fatalError()
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
