/*
 XML.Decoder.SingleValueContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML.Decoder {

  internal struct SingleValueContainer: SingleValueDecodingContainer, XMLDecoderKeylessContainer {

    // MARK: - Initialization

    internal init(decoder: XML.Decoder.Implementation) {
      self.decoder = decoder
    }

    // MARK: - Properties

    internal let decoder: XML.Decoder.Implementation

    // MARK: - SingleValueDecodingContainer

    internal func decodeNil() -> Bool {
      return decoder.currentElement.isNil
    }

    internal func decode(_ type: String.Type) throws -> String {
      guard let text = decoder.currentElement.data else {
        throw decoder.mismatchedTypeError(String.self, codingPath: codingPath)
      }
      return String(text)
    }

    internal func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
      return try T(from: decoder)
    }

    // MARK: - XMLDecoderKeylessContainer

    internal var indexKey: CodingKey? {
      return nil
    }
  }
}
