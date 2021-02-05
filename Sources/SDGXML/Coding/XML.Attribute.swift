/*
 XML.Attribute.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension XML {

  /// A property wrapper that causes properties to be encoded as XML attributes when encoded to XML.
  ///
  /// The XML attribute value will the the lossless string representation of the property.
  public struct Attribute<Value>: Decodable, DefaultAssignmentPropertyWrapper, Encodable,
    TransparentWrapper
  where Value: Codable, Value: LosslessStringConvertible {

    // MARK: - Decodable

    public init(from decoder: Swift.Decoder) throws {
      try self.init(from: decoder, via: Value.self, convert: { Attribute(wrappedValue: $0) })
    }

    // MARK: - DefaultAssignmentPropertyWrapper

    public init(wrappedValue: Value) {
      self.wrappedValue = wrappedValue
    }

    // MARK: - Encodable

    public func encode(to encoder: Swift.Encoder) throws {
      try encode(to: encoder, via: wrappedValue)
    }

    // MARK: - PropertyWrapper

    public var wrappedValue: Value

    // MARK: - TransparentWrapper

    public var wrappedInstance: Any {
      return wrappedValue
    }
  }
}
