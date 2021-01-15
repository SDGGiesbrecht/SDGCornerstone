/*
 XMLEncoder.Implementation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XMLEncoder {

  internal class Implementation: Encoder, SingleValueEncodingContainer {

    // MARK: - Initailzation

    internal init() {
      codingPath = []
      partialNodes = []
    }

    // MARK: - Encoding

    internal func box(_ string: StrictString) -> XMLNode {
      return XMLNode(characterData: string)
    }
    internal func box(_ string: String) -> XMLNode {
      return box(StrictString(string))
    }

    internal func box<Value: Encodable>(_ value: Value) throws -> XMLNode {
      try value.encode(to: self)
      var node = partialNodes.popLast() ?? XMLNode()
      if value is [String: Any] {  // To be deteriministic.
        node.sortKeys = true
      }
      return node
    }

    // MARK: - Encoder

    internal var partialNodes: [XMLNode]
    internal var codingPath: [CodingKey]
    internal var userInfo: [CodingUserInfoKey: Any] {
      return [:]
    }

    internal func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key>
    where Key: CodingKey {
      partialNodes.append(XMLNode())
      return KeyedEncodingContainer(KeyedContainer(self))
    }

    internal func unkeyedContainer() -> UnkeyedEncodingContainer {
      partialNodes.append(XMLNode())
      return UnkeyedContainer(self)
    }

    internal func singleValueContainer() -> SingleValueEncodingContainer {
      return self
    }

    // MARK: - SingleValueEncodingContainer

    internal func encodeNil() throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: Bool) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: String) throws {
      partialNodes.append(box(value))
    }

    internal func encode(_ value: Double) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: Float) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: Int) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: Int8) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: Int16) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: Int32) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: Int64) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: UInt) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: UInt8) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: UInt16) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: UInt32) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode(_ value: UInt64) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal func encode<T>(_ value: T) throws where T: Encodable {
      #warning("Not implemented yet.")
      fatalError()
    }
  }
}
