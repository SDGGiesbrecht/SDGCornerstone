/*
 XML.Encoder.SingleValueContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML.Encoder {

  internal struct SingleValueContainer: SingleValueEncodingContainer, XMLEncoderKeylessContainer {

    // MARK: - Initialization

    internal init(encoder: XML.Encoder.Implementation) {
      self.encoder = encoder
    }

    // MARK: - Properties

    internal let encoder: XML.Encoder.Implementation

    // MARK: - SingleValueEncodingContainer

    internal func encodeNil() throws {
      encoder.currentElement.isNil = true
    }

    internal mutating func encode(_ value: String) throws {
      encoder.currentElement.data = StrictString(value)
    }

    internal mutating func encode<T>(_ value: T) throws where T: Encodable {
      try pack(value) { xml, encode in
        try encode(encoder.currentElement)
      }
    }
  }
}
