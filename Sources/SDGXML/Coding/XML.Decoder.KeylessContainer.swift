/*
 XML.Decoder.KeylessContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

internal protocol XMLDecoderKeylessContainer: XMLDecoderContainer {

  var decoder: XML.Decoder.Implementation { get }
  var indexKey: CodingKey? { get }

  func decode(_ type: String.Type) throws -> String
  func decode<T>(_ type: T.Type) throws -> T where T: Decodable
}

extension XMLDecoderKeylessContainer {

  // MARK: - Encoding

  internal func decodeFromLosslessString<T>(_ value: T.Type) throws -> T
  where T: LosslessStringConvertible {
    let string = try decode(String.self)
    guard let converted = T(string) else {
      var codingPath = decoder.codingPath
      if let index = indexKey {
        codingPath.append(index)
      }
      throw decoder.mismatchedTypeError(T.self, codingPath: codingPath)
    }
    return converted
  }

  // MARK: - XEncodingContainer

  internal func decodeNil() -> Bool {
    return (try? decode(XML.Coder.Nil.self)) ≠ nil
  }

  internal func decode(_ type: Bool.Type) throws -> Bool {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: Int.Type) throws -> Int {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: Int8.Type) throws -> Int8 {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: Int16.Type) throws -> Int16 {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: Int32.Type) throws -> Int32 {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: Int64.Type) throws -> Int64 {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: UInt.Type) throws -> UInt {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: UInt8.Type) throws -> UInt8 {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: UInt16.Type) throws -> UInt16 {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: UInt32.Type) throws -> UInt32 {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: UInt64.Type) throws -> UInt64 {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: Double.Type) throws -> Double {
    return try decodeFromLosslessString(type)
  }

  internal func decode(_ type: Float.Type) throws -> Float {
    return try decodeFromLosslessString(type)
  }
}
