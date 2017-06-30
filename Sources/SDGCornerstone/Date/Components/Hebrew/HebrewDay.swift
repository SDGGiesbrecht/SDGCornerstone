/*
 HebrewDay.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A day of the Hebrew month.
public struct HebrewDay : ConsistentDurationCalendarComponent, Day, OrdinalCalendarComponent, RawRepresentableCalendarComponent {

    // MARK: - Properties

    private var day: Int

    // MARK: - Recurrence

    /// Corrects the day for the specified month and year, altering them if necessary. (If it doesn’t exist that year, Cheshvan 30 will be replaced by Kislev 1, etc.)
    public mutating func correct(forMonth month: inout HebrewMonth, year: inout HebrewYear) {
        let daysInMonth = month.numberOfDays(yearLength: year.length, leapYear: year.isLeapYear)
        if self.day > daysInMonth {
            self.day −= daysInMonth
            month.incrementCyclically(leapYear: year.isLeapYear) { year += 1 }
        }
    }

    // MARK: - ConsistentDurationCalendarComponent

    // [_Define Documentation: SDGCornerstone.ConsistentDurationCalendarComponent.duration_]
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).days
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = RawValue

    // MARK: - RawRepresentableCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:)_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    public init(unsafeRawValue: RawValue) {
        day = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<Int>? = 1 ..< HebrewMonth.maximumNumberOfDays + 1

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: Int {
        return day
    }
}
