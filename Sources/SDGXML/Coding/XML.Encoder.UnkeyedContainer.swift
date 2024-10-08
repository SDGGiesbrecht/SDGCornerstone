/*
 XML.Encoder.UnkeyedContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

extension XML.Encoder {

  internal struct UnkeyedContainer: UnkeyedEncodingContainer, XMLEncoderKeylessContainer {

    // MARK: - Initialization

    internal init(encoder: XML.Encoder.Implementation) {
      self.encoder = encoder
    }

    // MARK: - Properties

    internal let encoder: XML.Encoder.Implementation

    // MARK: - Encoding

    private func nextIndexKey() -> XML.Coder.MiscellaneousKey {
      return XML.Coder.MiscellaneousKey(count + 1)
    }

    // MARK: - UnkeyedEncodingContainer

    internal var count: Int {
      return encoder.currentElement.children.count
    }

    internal func encodeNil() throws {
      try encoder.createNewElement(key: XML.Coder.MiscellaneousKey("nil")) { element in
        element.isNil = true
      }
    }

    internal mutating func encode(_ value: String) throws {
      try encoder.createNewElement(key: XML.Coder.MiscellaneousKey(defaultFor: value)) { element in
        element.data = StrictString(value)
      }
    }

    internal mutating func encode<T>(_ value: T) throws where T: Encodable {
      try pack(value) { xml, encode in
        let key: CodingKey
        if let xml = xml {
          key = XML.Coder.MiscellaneousKey(String(xml.name))
        } else {
          key = XML.Coder.MiscellaneousKey(defaultFor: value)
        }
        try encoder.createNewElement(key: key, encode)
      }
    }

    internal mutating func nestedContainer<NestedKey>(
      keyedBy keyType: NestedKey.Type
    ) -> KeyedEncodingContainer<NestedKey>
    where NestedKey: CodingKey {
      return KeyedEncodingContainer(
        KeyedContainer<NestedKey>(encoder: nestedEncoder(key: nextIndexKey()))
      )
    }

    internal mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
      return UnkeyedContainer(encoder: nestedEncoder(key: nextIndexKey()))
    }

    internal mutating func superEncoder() -> Encoder {
      return nestedEncoder(key: nextIndexKey())
    }
  }
}
