/*
 GregorianHour.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An hour of the Gregorian day.
public struct GregorianHour : CardinalCalendarComponent, ConsistentDurationCalendarComponent, ICalendarComponent, ISOCalendarComponent, RawRepresentableCalendarComponent {

    // MARK: - Static Properties

    /// The number of hours in a day.
    public static let hoursPerDay = HebrewHour.hoursPerDay

    // MARK: - Properties

    private var hour: Int

    // MARK: - ConsistentDurationCalendarComponent

    // [_Define Documentation: SDGCornerstone.ConsistentDurationCalendarComponent.duration_]
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).hours
    }

    // MARK: - Text Representations

    /// Returns the hour in digits for twenty‐four–hour notation. (0–23)
    public func inDigitsInTwentyFourHourFormat() -> StrictString {
        return hour.inDigits()
    }

    /// Returns the hour in digits for twelve‐hour notation. (1–12)
    public func inDigitsInTwelveHourFormat() -> StrictString {
        var result = hour
        if result > 12 {
            result −= 12
        }
        if result == 0 {
            result = 12
        }
        return result.inDigits()
    }

    /// Returns “a.m.” or “p.m.”, corresponding to the hour.
    public func amOrPM() -> StrictString {
        if hour ≥ 12 {
            return "p.m."
        } else {
            return "a.m."
        }
    }

    // MARK: - ISOCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ISOCalendarCompenent.inISOFormat()_]
    /// Returns a string representation in the ISO format.
    public func inISOFormat() -> StrictString {
        return hour.inDigits().filled(to: 2, with: "0", from: .start)
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Int

    // MARK: - RawRepresentableCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:)_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    public init(unsafeRawValue: RawValue) {
        hour = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<RawValue>? = 0 ..< GregorianHour.hoursPerDay

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: RawValue {
        return hour
    }
}
