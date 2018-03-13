/*
 Encodable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
    @_inlineable public func encode<Other>(to encoder: Encoder, via other: Other) throws where Other : Encodable {
        var container = encoder.singleValueContainer()
        try container.encode(other)
    }
}
