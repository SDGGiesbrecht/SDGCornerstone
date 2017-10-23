/*
 Encodable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Encodable {

    // [_Define Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.

    /// Encodes this value by encoding a proxy type into the given encoder.
    public func encode<Other>(to encoder: Encoder, via other: Other) throws where Other : Encodable {
        var container = encoder.singleValueContainer()
        try container.encode(other)
    }
}

extension Encodable where Self : EncodableViaCustomStringConvertible {
    // MARK: - where Self : EncodableViaCustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: description)
    }
}

extension Encodable where Self : EncodableViaIntegerProtocol {
    // MARK: - where Self : EncodableViaIntegerProtocol

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: inDigits())
    }
}
