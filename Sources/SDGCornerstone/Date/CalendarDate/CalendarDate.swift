/*
 CalendarDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A date on a particular calendar.
///
/// The `CalendarDate` structure will remain accurate to its initial definition even if calendar or time zone rules change in the future, such as a change in the Daylight Savings start or end times. (This is in contrast to `Date`, which simply defines itself by a number of seconds since an epoch. If any rules were changed in the future, converting it back to a calendar‐base representation would result in a different date and time.)
///
/// To get the current time, use a static function such as `hebrewNow()` or `gregorianNow()`. Each returns a date representing the current time, but is defined according to a different calendar.
public struct CalendarDate : Comparable, Equatable, OneDimensionalPoint, PointProtocol {

    // MARK: - Static Properties

    internal static let epoch = HebrewDate.epoch

    // MARK: - Static Functions

    /// Returns the current date on the Hebrew calendar.
    public static func hebrewNow() -> CalendarDate {
        return CalendarDate(definition: CalendarDate(Date()).converted(to: HebrewDate.self))
    }

    /// Returns the current date on the Gregorian calendar.
    public static func gregorianNow() -> CalendarDate {
        return CalendarDate(definition: CalendarDate(Date()).converted(to: GregorianDate.self))
    }

    // MARK: - Initialization

    /// Creates an instance with the provided definition.
    public init(definition: DateDefinition) {
        self.definition = definition
    }

    /// Creates a date using the Hebrew calendar.
    public init(hebrewYear year: HebrewYear, month: HebrewMonth = .tishrei, day: HebrewDay = 1, hour: HebrewHour = 0, part: HebrewPart = 0) {
        self.init(definition: HebrewDate(year: year, month: month, day: day, hour: hour, part: part))
    }

    /// Creates a date using the Gregorian calendar.
    public init(gregorianYear year: GregorianYear, month: GregorianMonth = .january, day: GregorianDay = 1, hour: GregorianHour = 0, minute: GregorianMinute = 0, second: GregorianSecond = 0) {
        let definition = GregorianDate(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        self.init(definition: definition)
    }

    /// Creates a calendar date using an instance of `Date`.
    public init(_ date: Date) {
        self.init(definition: FoundationDate(date))
    }

    // MARK: - Properties

    private var definition: DateDefinition {
        willSet {
            cache = Cache()
        }
        didSet {
            cache.conversions[type(of: definition).uniqueTypeIdentifier] = definition
        }
    }

    private class Cache {
        fileprivate init() {}
        fileprivate var conversions: [String: DateDefinition] = [:]
    }
    private var cache = Cache()

    // Hebrew

    /// The Hebrew year.
    public var hebrewYear: HebrewYear {
        return converted(to: HebrewDate.self).year
    }
    /// The Hebrew month.
    public var hebrewMonth: HebrewMonth {
        return converted(to: HebrewDate.self).month
    }
    /// The Hebrew weekday.
    public var hebrewWeekday: HebrewWeekday {
        return converted(to: HebrewWeekdayDate.self).weekday
    }
    /// The Hebrew day.
    public var hebrewDay: HebrewDay {
        return converted(to: HebrewDate.self).day
    }
    /// The Hebrew hour.
    public var hebrewHour: HebrewHour {
        return converted(to: HebrewDate.self).hour
    }
    /// The Hebrew part.
    public var hebrewPart: HebrewPart {
        return converted(to: HebrewDate.self).part
    }

    // Gregorian

    /// The Gregorian year.
    public var gregorianYear: GregorianYear {
        return converted(to: GregorianDate.self).year
    }
    /// The Gregorian month.
    public var gregorianMonth: GregorianMonth {
        return converted(to: GregorianDate.self).month
    }
    /// The Gregorian weekday.
    public var gregorianWeekday: GregorianWeekday {
        return converted(to: GregorianWeekdayDate.self).weekday
    }
    /// The Gregorian day.
    public var gregorianDay: GregorianDay {
        return converted(to: GregorianDate.self).day
    }
    /// The Gregorian hour.
    public var gregorianHour: GregorianHour {
        return converted(to: GregorianDate.self).hour
    }
    /// The Gregorian minute.
    public var gregorianMinute: GregorianMinute {
        return converted(to: GregorianDate.self).minute
    }
    /// The Gregorian second.
    public var gregorianSecond: GregorianSecond {
        return converted(to: GregorianDate.self).second
    }

    private var intervalSinceEpoch: CalendarInterval<FloatMax> {
        if let hebrew = definition as? HebrewDate {
            return hebrew.intervalSinceReferenceDate
        } else {
            return type(of: definition).referenceDate.intervalSinceEpoch + definition.intervalSinceReferenceDate
        }
    }

    // MARK: - Conversions

    private func recomputeDefinition<D : DateDefinition>(as type: D.Type) -> D {
        if type == HebrewDate.self {
            return D(intervalSinceReferenceDate: intervalSinceEpoch)
        } else {
            return D(intervalSinceReferenceDate: intervalSinceEpoch − D.referenceDate.intervalSinceEpoch)
        }
    }

    /// Returns a conversion of the definition to a specific `DateDefinition` type.
    ///
    /// This method is preferred to manual conversions, as the returned conversions are automatically cached.
    ///
    /// - Parameters:
    ///     - type: The type to convert to.
    ///
    /// - Returns: The converted definition.
    public func converted<D : DateDefinition>(to type: D.Type) -> D {

        let cachedDefinition: DateDefinition = cached(in: &cache.conversions[D.uniqueTypeIdentifier]) {
            return recomputeDefinition(as: D.self)
        }

        if let result = cachedDefinition as? D {
            return result
        } else {
            return recomputeDefinition(as: D.self)
        }
    }

    // MARK: - Text Representations

    // [_Warning: These need to be overhauled._]
    /*
    /// The Hebrew date formatted by the system.
    public var systemFormattedFullHebrewDate: StrictString {
        let gregorianFormatter = NSDateFormatter()
        gregorianFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        let format = gregorianFormatter.dateFormat

        let hebrewFormatter = NSDateFormatter()
        hebrewFormatter.dateFormat = format
        hebrewFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)

        func symbol(key: String) -> String {
            return String(LocalizedString(table: "Date", key: key, bundle: SDGFoundationExtensionsBundle))
        }
        hebrewFormatter.monthSymbols = [
            symbol("Tishrei"),
            symbol("Cheshvan"),
            symbol("Kislev"),
            symbol("Tevet"),
            symbol("Shevat"),
            symbol("Adar I"),
            symbol("Adar"),
            symbol("Nisan"),
            symbol("Iyar"),
            symbol("Sivan"),
            symbol("Tammuz"),
            symbol("Av"),
            symbol("Elul"),
            symbol("Adar II"),
        ]
        return StrictString(hebrewFormatter.stringFromDate(NSDate(self + 6.hebrewHours)))
    }

    /// The Gregorian date formatted by the system.
    public var systemFormattedFullGregorianDate: StrictString {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.FullStyle
        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        return StrictString(formatter.stringFromDate(NSDate(self)))
    }

    /// The UTC time formatted by the system.
    public var systemFormattedUTCTime: String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeZone = NSTimeZone.UTC()
        return formatter.stringFromDate(NSDate(self))
    }

    /// The local time formatted by the system.
    public var systemFormattedLocalTime: String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return formatter.stringFromDate(NSDate(self))
    }*/

    // MARK: - iCalendar

    /// Returns a string representation in the floating iCalendar format.
    public var floatingiCalendarRepresentation: StrictString {
        return gregorianYear.iCalendarRepresentation + gregorianMonth.iCalendarRepresentation + gregorianDay.iCalendarRepresentation + ("T" as StrictString) + gregorianHour.iCalendarRepresentation + gregorianMinute.iCalendarRepresentation + gregorianSecond.iCalendarRepresentation
    }

    /// Returns a string representation in UTC in the iCalendar format.
    public var iCalendarRepresentation: StrictString {
        return floatingiCalendarRepresentation + ("Z" as StrictString)
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
        return lhs.intervalSinceEpoch < rhs.intervalSinceEpoch
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
        return lhs.intervalSinceEpoch == rhs.intervalSinceEpoch
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = CalendarInterval<FloatMax>

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout CalendarDate, rhs: CalendarInterval<FloatMax>) {
        lhs = CalendarDate(definition: RelativeDate(rhs, after: lhs))
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func − (lhs: CalendarDate, rhs: CalendarDate) -> CalendarInterval<FloatMax> {
        return lhs.intervalSinceEpoch − rhs.intervalSinceEpoch
    }
}
