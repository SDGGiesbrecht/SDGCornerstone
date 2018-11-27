/*
 GregorianDay.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A day of a Gregorian month.
public struct GregorianDay : CodableViaRawRepresentableCalendarComponent, ConsistentDurationCalendarComponent, Day, ICalendarComponent, ISOCalendarComponent, OrdinalCalendarComponent, RawRepresentableCalendarComponent {

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

    // MARK: - ConsistentDurationCalendarComponent

    // @documentation(SDGCornerstone.ConsistentDurationCalendarComponent.duration)
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).days
    }

    // MARK: - ISOCalendarComponent

    // #documentation(SDGCornerstone.ISOCalendarCompenent.inISOFormat())
    /// Returns a string representation in the ISO format.
    public func inISOFormat() -> StrictString {
        return ordinal.inDigits().filled(to: 2, with: "0", from: .start)
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Int

    // MARK: - RawRepresentableCalendarComponent

    // #documentation(SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:))
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    public init(unsafeRawValue: RawValue) {
        day = unsafeRawValue
    }

    // #documentation(SDGCornerstone.RawRepresentableCalendarComponent.validRange)
    /// The valid range for raw values.
    public static let validRange: Range<RawValue>? = 1 ..< GregorianMonth.maximumNumberOfDays + 1

    // #documentation(SDGCornerstone.RawRepresentableCalendarComponent.rawValue)
    /// The raw value.
    public var rawValue: Int {
        return day
    }
}
