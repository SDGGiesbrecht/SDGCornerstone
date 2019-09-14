/*
 CachedLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal struct CachedLocalization<L> : Codable where L : Localization {

    // MARK: - Initialization

    internal init(localization: L, date: Date) {
        self.localization = localization
        self.date = date
    }

    // MARK: - Properties

    internal let localization: L
    internal let date: Date

    // MARK: - Decodable

    internal init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let code = try container.decode(String.self)
        guard let localization = L(exactly: code) else {
            // Never leaves the internal scope anyway.
            throw DecodingError.dataCorruptedError(in: container, debugDescription: code)
        }
        self.localization = localization
        date = try container.decode(Date.self)
    }

    // MARK: - Encodable

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(localization.code)
        try container.encode(date)
    }
}
