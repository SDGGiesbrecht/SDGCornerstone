/*
 XML.Decoder.UnkeyedContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

extension XML.Decoder {

  internal struct UnkeyedContainer: UnkeyedDecodingContainer, XMLDecoderKeylessContainer {

    // MARK: - Initialization

    internal init(decoder: XML.Decoder.Implementation) {
      self.decoder = decoder
    }

    // MARK: - Properties

    internal let decoder: XML.Decoder.Implementation

    // MARK: - Decoding

    internal func decodeAndAdvance<T>(
      _ type: T.Type,
      _ interpret: (XML.Coder.Element) throws -> T
    ) throws -> T {
      let result: T = try decoder.enterElement(
        index: currentIndex,
        expectedType: T.self,
        interpret
      )
      currentIndex += 1
      return result
    }

    internal func nestedDecoder(index: Int) throws -> XML.Decoder.Implementation {
      return try decoder.enterElement(
        index: index,
        expectedType: Any.self
      ) { element in
        return XML.Decoder.Implementation(
          root: element,
          codingPath: decoder.codingPath,
          userInformation: decoder.userInfo
        )
      }
    }

    // MARK: - UnkeyedDecodingContainer

    internal var count: Int? {
      return decoder.currentElement.children.count
    }

    internal var currentIndex: Int {
      get {
        return decoder.currentElement.currentIndex
      }
      nonmutating set {
        decoder.currentElement.currentIndex = newValue
      }
    }

    internal var isAtEnd: Bool {
      return currentIndex == count
    }

    internal func decodeNil() throws -> Bool {
      let result = try decoder.enterElement(
        index: currentIndex,
        expectedType: Any.self
      ) { element in
        return element.isNil
      }
      if result {
        currentIndex += 1
      }
      return result
    }

    internal func decode(_ type: String.Type) throws -> String {
      return try decodeAndAdvance(String.self) { element in
        guard let text = element.data else {
          throw decoder.mismatchedTypeError(String.self, codingPath: codingPath)
        }
        return String(text)
      }
    }

    internal func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
      return try decodeAndAdvance(T.self) { element in
        return try unpack(element, as: type)
      }
    }

    internal func nestedContainer<NestedKey>(
      keyedBy type: NestedKey.Type
    ) throws -> KeyedDecodingContainer<NestedKey>
    where NestedKey: CodingKey {
      return KeyedDecodingContainer(
        KeyedContainer<NestedKey>(decoder: try nestedDecoder(index: currentIndex))
      )
    }

    internal func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
      return UnkeyedContainer(decoder: try nestedDecoder(index: currentIndex))
    }

    internal func superDecoder() throws -> Decoder {
      return try nestedDecoder(index: currentIndex)
    }

    // MARK: - XMLDecoderKeylessContainer

    internal var indexKey: CodingKey? {
      return XML.Coder.MiscellaneousKey(currentIndex)
    }
  }
}
