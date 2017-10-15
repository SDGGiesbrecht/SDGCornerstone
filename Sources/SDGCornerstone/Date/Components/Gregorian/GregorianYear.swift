/*
 GregorianYear.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Example 1: Gregorian Year_]
/// A Gregorian year.
///
/// Initialize with a negative integer to get a BC year. The provided mathematical functions automatically accomodate for the lack of a zero year. For example:
///
/// ```swift
/// let year = GregorianYear(1) − 1
/// // 1 BC
///
/// let timespan = GregorianYear(1) − GregorianYear(−1)
/// // 1 year
/// ```
public struct GregorianYear : CalendarComponent, ConsistentlyOrderedCalendarComponent, ICalendarComponent, ISOCalendarComponent, RawRepresentableCalendarComponent, Year {

    // MARK: - Static Properties

    // Leap Year Cycles

    /// The number of years in a leap year cycle.
    public static let yearsPerLeapYearCycle = 400

    /// The number of months in a leap year cycle.
    public static let monthsPerLeapYearCycle = GregorianYear.yearsPerLeapYearCycle × GregorianYear.monthsPerYear

    /// The number of days in a leap year cycle.
    public static let daysPerLeapYearCycle: Int = {
        var leapYears = 0
        let startYear: GregorianYear = 1
        for year in startYear ..< (startYear + GregorianYear.yearsPerLeapYearCycle) where year.isLeapYear {
            leapYears += 1
        }
        let normalYears = GregorianYear.yearsPerLeapYearCycle − leapYears
        return normalYears × GregorianYear.daysPerNormalYear + leapYears × GregorianYear.daysPerLeapYear
    }()

    // Months

    /// The number of months in a year.
    public static let monthsPerYear: Int = GregorianMonth.cases.count

    // Days

    /// The number of days in a non‐leap year.
    public static let daysPerNormalYear: Int = {
        var days = 0
        for month in GregorianMonth.cases {
            days += month.numberOfDays(leapYear: false)
        }
        return days
    }()
    /// The number of days in a leap year.
    public static let daysPerLeapYear: Int = {
        var days = 0
        for month in GregorianMonth.cases {
            days += month.numberOfDays(leapYear: true)
        }
        return days
    }()

    // MARK: - Properties

    private var year: Int

    /// Returns `true` if the year is a leap year.
    public var isLeapYear: Bool {
        let yearsSinceOneBC = self − GregorianYear(−1)

        if yearsSinceOneBC.mod(4) ≠ 0 {
            // Not a multiple of 4, normal year.
            return false
        } else if yearsSinceOneBC.mod(100) ≠ 0 {
            // Multiple of 4, but not 100, leap year.
            return true
        } else if yearsSinceOneBC.mod(400) ≠ 0 {
            // Multiple of 100, but not 400, normal year
            return false
        } else {
            // Multiple of 400, leap year
            return true
        }
    }

    /// The number of days in the year.
    public var numberOfDays: Int {
        if isLeapYear {
            return GregorianYear.daysPerLeapYear
        } else {
            return GregorianYear.daysPerNormalYear
        }
    }

    // MARK: - CalendarComponent

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.meanDuration_]
    /// The mean duration.
    public static var meanDuration: CalendarInterval<FloatMax> {
        return FloatMax(GregorianYear.daysPerLeapYearCycle).days ÷ FloatMax(GregorianYear.yearsPerLeapYearCycle)
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.minimumDuration_]
    /// The minimum duration.
    public static var minimumDuration: CalendarInterval<FloatMax> {
        return FloatMax(GregorianYear.daysPerNormalYear).days
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.maximumDuration_]
    /// The maximum duration.
    public static var maximumDuration: CalendarInterval<FloatMax> {
        return FloatMax(GregorianYear.daysPerLeapYear).days
    }

    // MARK: - ConsistentlyOrderedCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    public init(numberAlreadyElapsed: Int) {
        self = (1 as GregorianYear) + numberAlreadyElapsed
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    public init(ordinal: Int) {
        self.init(ordinal)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    public var numberAlreadyElapsed: Int {
        return self − (1 as GregorianYear)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    public var ordinal: Int {
        return rawValue
    }

    // MARK: - ISOCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ISOCalendarCompenent.inISOFormat()_]
    /// Returns a string representation in the ISO format.
    public func inISOFormat() -> StrictString {
        let cardinal = self − GregorianYear(−1)
        var digits = (|cardinal|).inDigits().filled(to: 4, with: "0", from: .start)
        if cardinal.isNegative {
            digits.prepend("−")
        }
        return digits
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Int

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout GregorianYear, rhs: Int) {
        var result = lhs.rawValue + rhs

        // Compensate for zero year.

        if lhs.year > 0 ∧ result ≤ 0 {
            // Crossed zero downwards
            result −= 1
        } else if lhs.year < 0 ∧ result ≥ 0 {
            // Crossed zero upwards
            result += 1
        }
        lhs = GregorianYear(result)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func − (lhs: GregorianYear, rhs: GregorianYear) -> Int {
        var result = lhs.rawValue − rhs.rawValue

        // Compensate for zero year.
        if lhs.year > 0 ∧ rhs.year < 0 {
            // Positive distance crossing zero.
            result −= 1
        } else if lhs.year < 0 ∧ rhs.year > 0 {
            // Negative distance crossing zero.
            result += 1
        }

        return result
    }

    // MARK: - RawRepresentableCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:)_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    public init(unsafeRawValue: Int) {
        assert(unsafeRawValue ≠ 0, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Code Coverage_]
                return "0 is not a valid Gregorian year."
            }
        }))
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

    // MARK: - Year

    private func inDigits(bcAbbreviation: StrictString) -> StrictString {
        var number = year
        if number.isNegative {
            number = |number|
        }
        var digits = number.inDigits()
        if year.isNegative {
            digits += " " + bcAbbreviation
        }
        return digits
    }

    // [_Inherit Documentation: SDGCornerstone.Year.inEnglishDigits()_]
    /// Returns the year in English digits.
    public func inEnglishDigits() -> StrictString {
        return inDigits(bcAbbreviation: "BC")
    }

    // [_Inherit Documentation: SDGCornerstone.Year.inDeutschenZiffern()_]
    /// Gibt das Jahr in deutschen Ziffern zurück.
    public func inDeutschenZiffern() -> StrictString {
        return inDigits(bcAbbreviation: "v. Chr.")
    }

    // [_Inherit Documentation: SDGCornerstone.Year.enChiffresFrançais()_]
    /// Retourne l’an en chiffres français.
    public func enChiffresFrançais() -> StrictString {
        return inDigits(bcAbbreviation: "av. J.‐C.")
    }

    // [_Inherit Documentation: SDGCornerstone.Year.σεΕλληνικάΨηφία()_]
    /// Επιστρέφει τον χρόνο στα ελληνικά ψηφία.
    public func σεΕλληνικάΨηφία() -> StrictString {
        return inDigits(bcAbbreviation: "π.Χ.")
    }

    // [_Inherit Documentation: SDGCornerstone.Year.בעברית־בספרות()_]
    /// מחזירה את השנה בעברית ובספרות.
    public func בעברית־בספרות() -> StrictString {
        return inDigits(bcAbbreviation: "לפנה״ס")
    }
}
