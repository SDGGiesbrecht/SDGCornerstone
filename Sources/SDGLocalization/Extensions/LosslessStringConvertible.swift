/*
 LosslessStringConvertible.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that conforms to `Codable` through its `LosslessStringConvertible` interface.
///
/// Conformance Requirements:
///
/// - `LosslessStringConvertible`
public protocol CodableViaLosslessStringConvertible : Decodable, Encodable, LosslessStringConvertible {}

extension CodableViaLosslessStringConvertible {

    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: description)
    }

    public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: String.self, convert: { Self($0) })
    }
}
