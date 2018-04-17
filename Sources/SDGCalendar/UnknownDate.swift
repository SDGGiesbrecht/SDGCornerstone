/*
 UnknownDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization
import SDGCornerstoneLocalizations

internal struct UnknownDate : CustomReflectable, DateDefinition {

    // MARK: - Initialization

    internal init(encodingIdentifier: StrictString, encodedDefinition: StrictString, lastCalculatedInstant: CalendarInterval<FloatMax>) {
        self.encodingIdentifier = encodingIdentifier
        self.encodedDefinition = encodedDefinition
        self.lastCalculatedInstant = lastCalculatedInstant
    }

    // MARK: - Properties

    internal let encodingIdentifier: StrictString
    internal let encodedDefinition: StrictString
    internal let lastCalculatedInstant: CalendarInterval<FloatMax>

    // MARK: - CustomReflectable

    // [_Inherit Documentation: SDGCornerstone.CustomReflectable.customMirror_]
    /// The custom mirror for this instance.
    public var customMirror: Mirror {
        return Mirror(self, children: [
            String(UserFacingText({ (localization: APILocalization) in
                switch localization {
                case .englishCanada:
                    return "encodingIdentifier"
                }
            }).resolved()) : encodingIdentifier,
            String(UserFacingText({ (localization: APILocalization) in
                switch localization {
                case .englishCanada:
                    return "encodedDefinition"
                }
            }).resolved()) : lastCalculatedInstant,
            String(UserFacingText({ (localization: APILocalization) in
                switch localization {
                case .englishCanada:
                    return "lastCalculatedInstant"
                }
            }).resolved()) : encodedDefinition
            ], displayStyle: .struct)
    }

    // MARK: - DateDefinition

    internal static let identifier: StrictString = "?"
    internal static let referenceDate: CalendarDate = CalendarDate.epoch

    internal var intervalSinceReferenceDate: CalendarInterval<FloatMax> {
        return lastCalculatedInstant
    }

    internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        unreachable() // This definition is never converted to.
    }

    // MARK: - Decodable

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    internal init(from decoder: Decoder) throws {
        unreachable() // This definition is never encoded.
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    internal func encode(to encoder: Encoder) throws {
        unreachable() // This definition is never encoded.
    }
}
