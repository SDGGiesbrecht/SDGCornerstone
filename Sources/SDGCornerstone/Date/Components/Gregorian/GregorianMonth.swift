/*
 GregorianMonth.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A month of the Gregorian year.
public enum GregorianMonth : Int, ConsistentlyOrderedCalendarComponent, EnumerationCalendarComponent {

    // MARK: - Cases

    /// January
    case january
    /// February
    case february
    /// March
    case march
    /// April
    case april
    /// May
    case may
    /// June
    case june
    /// July
    case july
    /// August
    case august
    /// September
    case september
    /// October
    case october
    /// November
    case november
    /// December
    case december

    // MARK: - Static Properties

    // Months

    /// The mean duration of a Gregorian month.
    public static let meanDuration = GregorianYear.meanDuration ÷ Double(GregorianYear.numberOfMonths)

    /// The maximum duration of a Gregorian month.
    public static let maximumDuration = Double(GregorianMonth.maximumNumberOfDays).days
    /// The minimum duration of a Gregorian month.
    public static let minimumDuration = Double(GregorianMonth.minimumNumberOfDays).days

    // Days

    /// The maximum number of days in a Gregorian month.
    public static let maximumNumberOfDays: Int = {
        var max = 0
        for month in GregorianMonth.cases {
            max.increase(to: month.maximumNumberOfDays)
        }
        return max
    }()
    /// The minimum number of days in a Gregorian month.
    public static let minimumNumberOfDays: Int = {
        var min = maximumNumberOfDays
        for month in GregorianMonth.cases {
            min.decrease(to: month.minimumNumberOfDays)
        }
        return min
    }()

    // MARK: - Properties

    /// The number of days in the month.
    public func numberOfDays(leapYear: Bool) -> Int {

        switch self {

        case .january, .march, .may, .july, .august, .october, .december:
            return 31

        case .february:
            if leapYear {
                return 29
            } else {
                return 28
            }

        case .april, .june, .september, .november:
            return 30
        }
    }

    private static var maximumNumberOfDaysCache: [GregorianMonth: Int] = [:]
    /// The maximum number of days in the month.
    public var maximumNumberOfDays: Int {
        return cached(in: &GregorianMonth.maximumNumberOfDaysCache[self]) {
            var max = 0
            max.increase(to: numberOfDays(leapYear: false))
            max.increase(to: numberOfDays(leapYear: true))
            return max
        }
    }
    private static var minimumNumberOfDaysCache: [GregorianMonth: Int] = [:]
    /// The minimum number of days in the month.
    public var minimumNumberOfDays: Int {
        return cached(in: &GregorianMonth.minimumNumberOfDaysCache[self]) {
            var min = maximumNumberOfDays
            min.decrease(to: numberOfDays(leapYear: false))
            min.decrease(to: numberOfDays(leapYear: true))
            return min
        }
    }

    // MARK: - iCalendar

    /// Returns a string representation in the iCalendar format.
    public var iCalendarRepresentation: StrictString {
        return StrictString(String(format: "%02d", ordinal))
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
