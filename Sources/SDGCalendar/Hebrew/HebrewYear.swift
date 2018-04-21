/*
 HebrewYear.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A Hebrew year.
public struct HebrewYear : CardinalCalendarComponent, CodableViaRawRepresentableCalendarComponent, RawRepresentableCalendarComponent, Year {

    // MARK: - Static Properties

    /// The number of months in a year.
    public static func numberOfMonths(leapYear: Bool) -> Int {
        if leapYear {
            return 13
        } else {
            return 12
        }
    }

    /// The number of years in a leap year cycle.
    public static let yearsPerLeapYearCycle = 19

    /// The number of months in a leap year cycle.
    public static let monthsPerLeapYearCycle: Int = {
        var months = 0
        for year in 1 ... HebrewYear(yearsPerLeapYearCycle) {
            months += year.numberOfMonths
        }
        return months
    }()

    // MARK: - Properties

    private var year: Int

    /// Returns `true` if the year is a leap year.
    public var isLeapYear: Bool {
        switch self.year.mod(HebrewYear.yearsPerLeapYearCycle) {
        case 3, 6, 8, 11, 14, 17, 0 /* 19 */:
            return true
        default:
            return false
        }
    }

    /// Returns the year length.
    public var length: Length {
        return Length(numberOfDays: numberOfDays)
    }

    /// The number of months in the year.
    public var numberOfMonths: Int {
        return HebrewYear.numberOfMonths(leapYear: isLeapYear)
    }

    /// The number of days in the year.
    public var numberOfDays: Int {
        let nextStart = HebrewDate.intervalFromReferenceDate(toStartOf: self + 1)
        let ownStart = HebrewDate.intervalFromReferenceDate(toStartOf: self)
        let result = (nextStart − ownStart).inDays
        return Int(result)
    }

    // MARK: - CalendarComponent

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.meanDuration_]
    /// The mean duration.
    public static var meanDuration: CalendarInterval<FloatMax> {
        return FloatMax(monthsPerLeapYearCycle).hebrewMoons ÷ FloatMax(HebrewYear.yearsPerLeapYearCycle)
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.minimumDuration_]
    /// The minimum duration.
    public static var minimumDuration: CalendarInterval<FloatMax> {
        return FloatMax(HebrewYear.Length.minimumNumberOfDays).days
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.maximumDuration_]
    /// The maximum duration.
    public static var maximumDuration: CalendarInterval<FloatMax> {
        return FloatMax(HebrewYear.Length.maximumNumberOfDays).days
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
        year = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<RawValue>? = nil

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: RawValue {
        return year
    }

    // MARK: - Year

    private func inDigits() -> StrictString {
        return year.inDigits()
    }

    // [_Inherit Documentation: SDGCornerstone.Year.inEnglishDigits()_]
    /// Returns the year in English digits.
    public func inEnglishDigits() -> StrictString {
        return inDigits()
    }

    /// :nodoc:
    public func _inDeutschenZiffern() -> StrictString {
        return inDigits()
    }
}
