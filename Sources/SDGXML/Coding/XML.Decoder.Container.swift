/*
 XML.Decoder.Container.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol XMLDecoderContainer {
  var decoder: XML.Decoder.Implementation { get }
}

extension XMLDecoderContainer {

  // MARK: - Encoding

  internal func nestedDecoder(key: CodingKey) throws -> XML.Decoder.Implementation {
    return try decoder.enterElement(key: key) { element in
      return XML.Decoder.Implementation(
        root: element,
        codingPath: decoder.codingPath,
        userInformation: decoder.userInfo
      )
    }
  }

  // MARK: - XDecodingContainer

  internal var codingPath: [CodingKey] {
    return decoder.codingPath
  }
}
