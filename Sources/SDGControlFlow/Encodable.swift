/*
 Encodable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Encodable {

    /// Encodes this value by encoding a proxy type into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder.
    ///     - other: The instance of the proxy type.
    public func encode<Other>(to encoder: Encoder, via other: Other) throws where Other : Encodable {
        var container = encoder.singleValueContainer()
        try container.encode(other)
    }
}
