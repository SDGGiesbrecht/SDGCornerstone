/*
 XML.Decoder.Implementation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

extension XML.Decoder {

  internal class Implementation: Decoder {

    // MARK: - Initailzation

    internal convenience init(
      rootElement: XML.Element,
      userInformation: [CodingUserInfoKey: Any]
    ) {
      self.init(
        root: XML.Coder.Element(rootElement),
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

    internal func enterElement<T>(
      key: CodingKey,
      _ closure: (XML.Coder.Element) throws -> T
    ) throws -> T {

      codingPath.append(key)
      defer { codingPath.removeLast() }

      let keyString = StrictString(key.stringValue)
      guard let entered = currentElement.children.first(where: { $0.name == keyString }) else {
        throw keyNotFoundError(key: key, codingPath: codingPath)
      }

      partialElements.append(entered)
      defer { partialElements.removeLast() }

      return try closure(entered)
    }

    internal func description(of codingPath: [CodingKey]) -> StrictString {
      let string = String(codingPath.lazy.map({ $0.stringValue }).joined(separator: " → "))
      return StrictString(string)
    }

    internal func keyNotFoundError(key: CodingKey, codingPath: [CodingKey]) -> DecodingError {
      let path = description(of: codingPath)
      let description = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
          return "There is no value at ‘\(path)’."
        case .englishUnitedStates, .englishCanada:
          return "There is no value at “\(path)”."
        case .deutschDeutschland:
          return "Kein Wert ist mit „\(path)“ verbunden."
        }
      }).resolved()
      return DecodingError.keyNotFound(
        key,
        DecodingError.Context(codingPath: codingPath, debugDescription: String(description))
      )
    }

    // MARK: - Decoding

    internal func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
      return try T(from: self)
    }

    // MARK: - Decoder

    internal var codingPath: [CodingKey]
    internal let userInfo: [CodingUserInfoKey: Any]

    internal func container<Key>(keyedBy type: Key.Type) -> KeyedDecodingContainer<Key>
    where Key: CodingKey {
      return KeyedDecodingContainer(KeyedContainer(encoder: self))
    }

    internal func unkeyedContainer() -> UnkeyedDecodingContainer {
      return UnkeyedContainer(encoder: self)
    }

    internal func singleValueContainer() -> SingleValueDecodingContainer {
      return SingleValueContainer(encoder: self)
    }
  }
}
