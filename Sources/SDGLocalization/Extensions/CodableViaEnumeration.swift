/*
 CodableViaEnumeration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// An enumeration which encodes itself using a separate encoded representation.
///
/// Conform to this protocol and provide a static `codingRepresentations` property to have `Codable` conformance implemented automatically.
public protocol CodableViaEnumeration: CaseIterable, Decodable, Encodable, Hashable {

  /// The encoded representation.
  associatedtype CodableRepresentation: Codable, Hashable

  /// The mapping from enumeration values to and from encoded values.
  static var codingRepresentations: BijectiveMapping<Self, CodableRepresentation> { get }
}

extension CodableViaEnumeration {

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    try self.init(
      from: decoder,
      via: CodableRepresentation.self,
      convert: { return Self.codingRepresentations[$0] }
    )
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    try self.encode(to: encoder, via: Self.codingRepresentations[self]!)
  }
}
