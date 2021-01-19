/*
 XML.Encoder.Implementation.swift

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

extension XML.Encoder {

  internal class Implementation: Encoder {

    // MARK: - Initailzation

    internal convenience init(
      rootElementName: StrictString,
      userInformation: [CodingUserInfoKey: Any]
    ) {
      self.init(
        root: XML.Encoder.Element(name: rootElementName),
        codingPath: [],
        userInformation: userInformation
      )
    }

    internal init(
      root: XML.Encoder.Element,
      codingPath: [CodingKey],
      userInformation: [CodingUserInfoKey: Any]
    ) {
      partialElements = [root]
      self.codingPath = codingPath
      self.userInfo = userInformation
    }

    // MARK: - Properties

    private var partialElements: [XML.Encoder.Element]

    // MARK: - Encoding

    internal var currentElement: XML.Encoder.Element {
      return partialElements.last!
    }

    internal func createNewElement(
      key: CodingKey,
      _ closure: (XML.Encoder.Element) throws -> Void
    ) throws {
      let wrapped: (XML.Encoder.Element) throws -> XML.Encoder.Implementation? = { element in
        try closure(element)
        return nil
      }
      _ = try createNewElement(key: key, wrapped)
    }

    internal func createNewElement(
      key: CodingKey,
      _ closure: (XML.Encoder.Element) -> XML.Encoder.Implementation
    ) -> XML.Encoder.Implementation {
      let wrapped: (XML.Encoder.Element) -> XML.Encoder.Implementation? = { closure($0) }
      return createNewElement(key: key, wrapped)!
    }

    private func createNewElement(
      key: CodingKey,
      _ closure: (XML.Encoder.Element) throws -> XML.Encoder.Implementation?
    ) rethrows -> XML.Encoder.Implementation? {

      codingPath.append(key)
      defer { codingPath.removeLast() }

      let new = XML.Encoder.Element(name: StrictString(key.stringValue))
      partialElements.last!.children.append(new)
      partialElements.append(new)
      defer { partialElements.removeLast() }

      return try closure(new)
    }

    // MARK: - Completion

    internal func encode<Root>(_ root: Root) throws -> XML.Element where Root: Encodable {
      try root.encode(to: self)
      return partialElements.first!.modelElement()
    }

    // MARK: - Encoder

    internal var codingPath: [CodingKey]
    internal let userInfo: [CodingUserInfoKey: Any]

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
