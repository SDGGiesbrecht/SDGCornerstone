/*
 XML.Encoder.Container.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol XMLEncoderContainer {
  var encoder: XML.Encoder.Implementation { get }
}

extension XMLEncoderContainer {

  // MARK: - Encoding

  internal func nestedEncoder(key: CodingKey) -> XML.Encoder.Implementation {
    return encoder.createNewElement(key: key) { element in
      return XML.Encoder.Implementation(
        root: element,
        codingPath: encoder.codingPath,
        userInformation: encoder.userInfo
      )
    }
  }

  internal func pack<T>(
    _ value: T,
    encode: (XML.Element?, (XML.Coder.Element) throws -> Void) throws -> Void
  ) throws where T: Encodable {
    let xml = value as? XML.Element
    try encode(xml) { element in
      if let xml = xml {
        guard xml.name == encoder.currentElement.name else {
          throw encoder.mismatchedKeyError(value: xml, codingPath: encoder.codingPath)
        }
        encoder.currentElement.literal = xml
      } else {
        try value.encode(to: encoder)
      }
    }
  }

  // MARK: - XEncodingContainer

  internal var codingPath: [CodingKey] {
    return encoder.codingPath
  }
}
