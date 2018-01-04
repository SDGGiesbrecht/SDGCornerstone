/*
 HebrewWeekday.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A day of the Hebrew week.
public enum HebrewWeekday : Int, Codable, ConsistentDurationCalendarComponent, ConsistentlyOrderedCalendarComponent, EnumerationCalendarComponent, Weekday {

    // MARK: - Cases

    /// Sunday.
    case sunday
    /// Monday.
    case monday
    /// Tuesday.
    case tuesday
    /// Wednesday.
    case wednesday
    /// Thursday.
    case thursday
    /// Friday.
    case friday
    /// Saturday.
    case saturday

    // MARK: - Static Properties

    /// The number of days in a week.
    public static let daysPerWeek: Int = cases.count

    // MARK: - ConsistentDurationCalendarComponent

    // [_Define Documentation: SDGCornerstone.ConsistentDurationCalendarComponent.duration_]
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).days
    }

    // MARK: - Decodable

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        try self.init(usingOrdinalFrom: decoder)
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encodeUsingOrdinal(to: encoder)
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = RawValue

    // MARK: - RawRepresentable

    // [_Inherit Documentation: SDGCornerstone.RawRepresentable.RawValue_]
    /// The raw value type.
    public typealias RawValue = Int
}
