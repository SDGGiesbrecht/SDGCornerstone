/*
 GregorianDay.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A day of a Gregorian month.
public struct GregorianDay : OrdinalCalendarComponent, RawRepresentableCalendarComponent {

    // MARK: - Properties

    private var day: Int

    // MARK: - Recurrence

    /// Corrects the day for the specified month and year, altering them if necessary. (February 29 → March 1 in non‐leap years.)
    ///
    /// - Parameters:
    ///     - month: The month.
    ///     - year: The year.
    public mutating func correct(forMonth month: inout GregorianMonth, year: GregorianYear) {
        let daysInMonth = month.numberOfDays(leapYear: year.isLeapYear)
        if self.day > daysInMonth {
            self.day −= daysInMonth
            month.increment()
        }
    }

    // MARK: - iCalendar

    /// Returns a string representation in the iCalendar format.
    public var iCalendarRepresentation: StrictString {
        return StrictString(String(format: "%02d", rawValue))
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
    public static let validRange: Range<Int>? = 1 ..< GregorianMonth.maximumNumberOfDays + 1

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: Int {
        return day
    }
}
