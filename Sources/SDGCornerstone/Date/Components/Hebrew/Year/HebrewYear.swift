/*
 HebrewYear.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A Hebrew year.
public struct HebrewYear : CardinalCalendarComponent, RawRepresentableCalendarComponent {

    // MARK: - Static Properties

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

    /// The number of months in a year.
    public static func numberOfMonths(leapYear: Bool) -> Int {
        if leapYear {
            return 13
        } else {
            return 12
        }
    }

    // Time

    /// The average length of a Hebrew year.
    public static let meanDuration = Double(monthsPerLeapYearCycle).hebrewMoons ÷ Double(HebrewYear.yearsPerLeapYearCycle)

    /// The maximum length of a Hebrew year.
    public static let maximumDuration = Double(HebrewYear.Length.maximumNumberOfDays).days
    /// The minimum length of a Hebrew year.
    public static let minimumDuration = Double(HebrewYear.Length.minimumNumberOfDays).days

    // MARK: - Properties

    private var year: Int

    // Year

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

    // Months

    /// The number of months in the year.
    public var numberOfMonths: Int {
        return HebrewYear.numberOfMonths(leapYear: isLeapYear)
    }

    // Days

    /// The number of days in the year.
    public var numberOfDays: Int {
        /*
        let nextStart = HebrewDate.intervalFromReferenceDateToStartOfYear(self + 1)
        let ownStart = HebrewDate.intervalFromReferenceDateToStartOfYear(self)
        let result = (nextStart − ownStart).inHebrewDays
        return Int(result)*/
        notImplementedYet()
        return 0
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
        year = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<Int>? = nil

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: Int {
        return year
    }
}
