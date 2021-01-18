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

  internal class Implementation: Encoder {

    // MARK: - Initailzation

    internal init(rootElementName: StrictString, userInfo: [CodingUserInfoKey: Any]) {
      element = XML.Element(name: rootElementName)
      codingPath = []
      self.userInfo = userInfo
    }

    // MARK: - Properties

    var element: XML.Element

    // MARK: - Encoder

    internal var codingPath: [CodingKey]
    internal var userInfo: [CodingUserInfoKey: Any]

    internal func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key>
    where Key: CodingKey {
      return KeyedEncodingContainer(KeyedContainer(encoder: self))
    }

    internal func unkeyedContainer() -> UnkeyedEncodingContainer {
      return UnkeyedContainer(encoder: self)
    }

    internal func singleValueContainer() -> SingleValueEncodingContainer {
      return SingleValueContainer(encoder: self)
    }
  }
}
