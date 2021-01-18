/*
 XML.Encoder.Implementation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML.Encoder {

  #warning("Temporarily disabled.")
  #if false
    internal class Implementation: Encoder {
      #warning("Is classhood necessary?")

      // MARK: - Initailzation

      internal init() {
        codingPath = []
        partialNodes = []
      }

      // MARK: - Encoding

      internal func box(_ string: StrictString) -> XML.Element {
        return XML.Node(characterData: string)
      }
      internal func box(_ string: String) -> XML.Element {
        return box(StrictString(string))
      }

      internal func box<Value: Encodable>(_ value: Value) throws -> XML.Element {
        try value.encode(to: self)
        var node = partialNodes.popLast() ?? XML.Element()
        if value is [String: Any] {  // To be deteriministic.
          node.sortKeys = true
        }
        return node
      }

      // MARK: - Encoder

      internal var partialNodes: [XML.Element]
      internal var codingPath: [CodingKey]
      internal var userInfo: [CodingUserInfoKey: Any] {
        return [:]
      }

      internal func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key>
      where Key: CodingKey {
        partialNodes.append(XML.Element())
        return KeyedEncodingContainer(KeyedContainer(self))
      }

      internal func unkeyedContainer() -> UnkeyedEncodingContainer {
        partialNodes.append(XML.Element())
        return UnkeyedContainer(self)
      }

      internal func singleValueContainer() -> SingleValueEncodingContainer {
        return self
      }
    }
  #endif
}
