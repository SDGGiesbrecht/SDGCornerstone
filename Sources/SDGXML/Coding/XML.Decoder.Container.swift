/*
 XML.Decoder.Container.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol XMLDecoderContainer {
  var decoder: XML.Decoder.Implementation { get }
}

extension XMLDecoderContainer {

  // MARK: - Decoding

  internal func unpack<T>(_ element: XML.Coder.Element, as type: T.Type) throws -> T
  where T: Decodable {
    if T.self == XML.Element.self {
      let xml =
        decoder.currentElement.literal
        ?? decoder.currentElement.modelElement()  // @exempt(from: tests) Unreachable?
      return xml as! T
    }
    return try T(from: decoder)
  }

  // MARK: - XDecodingContainer

  internal var codingPath: [CodingKey] {
    return decoder.codingPath
  }
}
