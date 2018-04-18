/*
 RelativeDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

internal struct RelativeDate : CustomReflectable, DateDefinition, TextualPlaygroundDisplay {

    // MARK: - Initialization

    internal init(_ interval: CalendarInterval<FloatMax>, after date: CalendarDate) {
        baseDate = date
        intervalSince = interval

        intervalSinceReferenceDate = (date − RelativeDate.referenceDate) + interval
    }

    // MARK: - Properties

    internal let baseDate: CalendarDate
    internal let intervalSince: CalendarInterval<FloatMax>

    // MARK: - CustomReflectable

    // [_Inherit Documentation: SDGCornerstone.CustomReflectable.customMirror_]
    /// The custom mirror for this instance.
    public var customMirror: Mirror {
        return Mirror(self, children: [
            String(UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return "baseDate"
                }
            }).resolved()) : baseDate,
            String(UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return "intervalSince"
                }
            }).resolved()) : intervalSince
            ], displayStyle: .struct)
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return "(" + String(describing: baseDate) + ") + " + String(describing: intervalSince)
    }

    // MARK: - DateDefinition

    internal static let identifier: StrictString = "Δ"
    internal static let referenceDate: CalendarDate = CalendarDate.epoch

    internal let intervalSinceReferenceDate: CalendarInterval<FloatMax>

    internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate

        self.baseDate = RelativeDate.referenceDate
        self.intervalSince = intervalSinceReferenceDate
    }

    // MARK: - Decodable

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    internal init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let interval = try container.decode(CalendarInterval<FloatMax>.self)
        let baseDate = try container.decode(CalendarDate.self)
        self = RelativeDate(interval, after: baseDate)
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    internal func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(intervalSince)
        try container.encode(baseDate)
    }
}
