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

import SDGCornerstoneLocalizations

extension XML.Encoder {

  internal class Implementation: Encoder {

    // MARK: - Initailzation

    internal convenience init(
      rootElementName: StrictString,
      userInformation: [CodingUserInfoKey: Any]
    ) {
      self.init(
        root: XML.Coder.Element(name: rootElementName),
        codingPath: [],
        userInformation: userInformation
      )
    }

    internal init(
      root: XML.Coder.Element,
      codingPath: [CodingKey],
      userInformation: [CodingUserInfoKey: Any]
    ) {
      partialElements = [root]
      self.codingPath = codingPath
      self.userInfo = userInformation
    }

    // MARK: - Properties

    private var partialElements: [XML.Coder.Element]

    // MARK: - Encoding

    internal var currentElement: XML.Coder.Element {
      return partialElements.last!
    }

    internal func createNewElement(
      key: CodingKey,
      _ closure: (XML.Coder.Element) throws -> Void
    ) throws {
      let wrapped: (XML.Coder.Element) throws -> XML.Encoder.Implementation? = { element in
        try closure(element)
        return nil
      }
      _ = try createNewElement(key: key, wrapped)
    }

    internal func createNewElement(
      key: CodingKey,
      _ closure: (XML.Coder.Element) -> XML.Encoder.Implementation
    ) -> XML.Encoder.Implementation {
      let wrapped: (XML.Coder.Element) -> XML.Encoder.Implementation? = { closure($0) }
      return createNewElement(key: key, wrapped)!
    }

    private func createNewElement(
      key: CodingKey,
      _ closure: (XML.Coder.Element) throws -> XML.Encoder.Implementation?
    ) rethrows -> XML.Encoder.Implementation? {

      codingPath.append(key)
      defer { codingPath.removeLast() }

      let new = XML.Coder.Element(name: StrictString(key.stringValue))
      partialElements.last!.children.append(new)
      partialElements.append(new)
      defer { partialElements.removeLast() }

      return try closure(new)
    }

    // MARK: - Encoding

    internal func encode<Root>(_ root: Root) throws -> XML.Element where Root: Encodable {
      try root.encode(to: self)
      return partialElements.first!.modelElement()
    }

    // MARK: - Errors

    internal func mismatchedKeyError(value: XML.Element, codingPath: [CodingKey]) -> EncodingError {
      let path = XML.Coder.description(of: codingPath)
      let description = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
          return
            "The element named ‘\(value.name)’ cannot be encoded at ‘\(path)’; element names must match encoding keys."
        case .englishUnitedStates, .englishCanada:
          return
            "The element named “\(value.name)” cannot be encoded at “\(path)”; element names must match encoding keys."
        case .deutschDeutschland:
          return
            "Es ist unmöglich, das Element „\(value.name)“ unter „\(path)“ zu verschlüsseln; Elementnamen und Schlüsseln mussen übereinstimmen."
        }
      }).resolved()
      return EncodingError.invalidValue(
        value,
        EncodingError.Context(codingPath: codingPath, debugDescription: String(description))
      )
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
