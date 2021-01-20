/*
 XML.Decoder.Implementation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
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

    // MARK: - Decoding

    internal var currentElement: XML.Coder.Element {
      return partialElements.last!
    }

    internal func enterElement<T>(
      key: CodingKey,
      _ closure: (XML.Coder.Element) throws -> T
    ) throws -> T {
      return try enterElement(
        key: key,
        lookup: { parent in
          let keyString = StrictString(key.stringValue)
          guard let entered = currentElement.children.first(where: { $0.name == keyString }) else {
            throw keyNotFoundError(key: key, codingPath: codingPath.dropLast())
          }
          return entered
        },
        closure: closure
      )
    }

    internal func enterElement<T, Expected>(
      index: Int,
      expectedType: Expected.Type,
      _ closure: (XML.Coder.Element) throws -> T
    ) throws -> T {
      return try enterElement(
        key: XML.Coder.MiscellaneousKey(index + 1),
        lookup: { parent in
          guard index ∈ parent.children.indices else {
            throw containerEndError(Expected.self, codingPath: codingPath)
          }
          return parent.children[index]
        },
        closure: closure
      )
    }

    private func enterElement<T>(
      key: CodingKey,
      lookup: (XML.Coder.Element) throws -> XML.Coder.Element,
      closure: (XML.Coder.Element) throws -> T
    ) rethrows -> T {

      codingPath.append(key)
      defer { codingPath.removeLast() }

      let entered = try lookup(currentElement)

      partialElements.append(entered)
      defer { partialElements.removeLast() }

      return try closure(entered)
    }

    // MARK: - Errors

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

    internal func containerEndError<T>(_ type: T.Type, codingPath: [CodingKey]) -> DecodingError {
      let path = description(of: codingPath)
      let description = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
          return "The container at ‘\(path)’ has no more elements."
        case .englishUnitedStates, .englishCanada:
          return "The container at “\(path)” has no more elements."
        case .deutschDeutschland:
          return "Der Behälter unter „\(path)“ hat keine weitere Elemente."
        }
      }).resolved()
      return DecodingError.valueNotFound(
        T.self,
        DecodingError.Context(codingPath: codingPath, debugDescription: String(description))
      )
    }

    internal func mismatchedTypeError<T>(_ type: T.Type, codingPath: [CodingKey]) -> DecodingError {
      let path = description(of: codingPath)
      let description = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
          return
            "The data at ‘\(path)’ does not describe an instance of the expected type: \(arbitraryDescriptionOf: T.self)"
        case .englishUnitedStates, .englishCanada:
          return
            "The data at “\(path)” does not describe an instance of the expected type: \(arbitraryDescriptionOf: T.self)"
        case .deutschDeutschland:
          return
            "Die Daten unter „\(path)“ beschreiben kein Exemplar des erwarteten Typs: \(arbitraryDescriptionOf: T.self)"
        }
      }).resolved()
      return DecodingError.typeMismatch(
        T.self,
        DecodingError.Context(
          codingPath: codingPath,
          debugDescription: String(description)
        )
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
      return KeyedDecodingContainer(KeyedContainer(decoder: self))
    }

    internal func unkeyedContainer() -> UnkeyedDecodingContainer {
      return UnkeyedContainer(decoder: self)
    }

    internal func singleValueContainer() -> SingleValueDecodingContainer {
      return SingleValueContainer(decoder: self)
    }
  }
}
