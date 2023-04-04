/*
 XML.Attribute.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension XML {

  /// A property wrapper that causes properties to be encoded as XML attributes when encoded to XML.
  ///
  /// The XML attribute value will the the lossless string representation of the property.
  ///
  /// This property wrapper has no effect when manually fed into an unkeyed or single value container.
  @propertyWrapper
  public struct Attribute<Value>: Decodable, DefaultAssignmentPropertyWrapper,
    LosslessStringConvertible, Encodable, TransparentWrapper, XMLAttributeProtocol
  where Value: Codable, Value: LosslessStringConvertible {

    // MARK: - CustomStringConvertible

    public var description: String {
      return wrappedValue.description
    }

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

    // MARK: - LosslessStringConvertible

    public init?(_ description: String) {
      if let wrapped = Wrapped(description) {
        self = Attribute(wrappedValue: wrapped)
      } else {
        return nil
      }
    }

    // MARK: - PropertyWrapper

    public var wrappedValue: Value

    // MARK: - TransparentWrapper

    public var wrappedInstance: Any {
      return wrappedValue
    }
  }
}

extension XML.Attribute: Equatable where Value: Equatable {

  public static func == (
    precedingValue: XML.Attribute<Value>,
    followingValue: XML.Attribute<Value>
  ) -> Bool {
    return precedingValue.wrappedValue == followingValue.wrappedValue
  }
}

extension XML.Attribute: Hashable where Value: Hashable {

  public func hash(into hasher: inout Hasher) {
    wrappedValue.hash(into: &hasher)
  }
}

extension XML.Attribute: Sendable where Value: Sendable {}
