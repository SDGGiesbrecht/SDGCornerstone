/*
 XML.Encoder.KeylessContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol XMLEncoderKeylessContainer: XMLEncoderContainer {

  mutating func encode(_ value: String) throws
  mutating func encode<T>(_ value: T) throws where T: Encodable
}

extension XMLEncoderKeylessContainer {

  // MARK: - Encoding

  internal mutating func encodeLosslessString<T>(_ value: T) throws
  where T: LosslessStringConvertible {
    try encode(String(describing: value))
  }

  // MARK: - XEncodingContainer

  internal mutating func encode(_ value: Bool) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: Int) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: Int8) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: Int16) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: Int32) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: Int64) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: UInt) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: UInt8) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: UInt16) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: UInt32) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: UInt64) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: Double) throws {
    try encodeLosslessString(value)
  }

  internal mutating func encode(_ value: Float) throws {
    try encodeLosslessString(value)
  }
}
