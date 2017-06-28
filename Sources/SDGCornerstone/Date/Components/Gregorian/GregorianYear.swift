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
public struct GregorianYear : ConsistentlyOrderedCalendarComponent, RawRepresentableCalendarComponent {

    // MARK: - Static Properties

    // Leap Year Cycle

    /// The number of years in a leap year cycle.
    public static let yearsPerLeapYearCycle = 400

    /// The number of months in a leap year cycle.
    public static let monthsPerLeapYearCycle = GregorianYear.yearsPerLeapYearCycle × GregorianYear.numberOfMonths

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
    public static let numberOfMonths: Int = 12

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

    // Time

    /// The mean duration of a Gregorian year.
    public static let meanDuration = Double(GregorianYear.daysPerLeapYearCycle).days ÷ Double(GregorianYear.yearsPerLeapYearCycle)

    /// The maximum duration of a Gregorian year.
    public static let maximumDuration = Double(GregorianYear.daysPerLeapYear).days
    /// The minimum duration of a Gregorian year.
    public static let minimumDuration = Double(GregorianYear.daysPerNormalYear).days

    // MARK: - Properties

    private var year: Int

    // Year

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

    // Months

    /// The number of months in the year.
    public var numberOfMonths: Int {
        return GregorianYear.numberOfMonths
    }

    // Days

    /// The number of days in the year.
    public var numberOfDays: Int {
        if isLeapYear {
            return GregorianYear.daysPerLeapYear
        } else {
            return GregorianYear.daysPerNormalYear
        }
    }

    // MARK: - iCalendar

    /// A string representation in the iCalendar format.
    ///
    /// - Precondition: The year is in the range 1 BC–AD 9999.
    public var iCalendarRepresentation: StrictString {
        assert(−1 ≤ rawValue ∧ rawValue ≤ 9999, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada:
                return StrictString("The year \(self.inEnglishDigits()) is out of range for the iCalendar format.")
            }
        }))
        let value: Int
        if rawValue == −1 {
            value = 0
        } else {
            value = rawValue
        }
        return StrictString(String(format: "%04d", value))
    }

    // MARK: - Text Representations

    private func inDigits(bcAbbreviation: StrictString) -> StrictString {
        var number = year
        if number.isNegative {
            number = |number|
        }
        var digits = number.inDigits()
        if year.isNegative {
            digits += (" " as StrictString) + bcAbbreviation
        }
        return digits
    }

    /// Returns the year in English digits.
    public func inEnglishDigits() -> StrictString {
        return inDigits(bcAbbreviation: "BC")
    }

    /// Gibt das Jahr in deutschen Ziffern zurück.
    public func inDeutschenZiffern() -> StrictString {
        return inDigits(bcAbbreviation: "v. Chr.")
    }

    /// Retourne l’an en chiffres français.
    public func enChiffresFrançais() -> StrictString {
        return inDigits(bcAbbreviation: "av. J.‐C.")
    }

    /// Επιστρέφει τον χρόνο στα ελληνικά ψηφία.
    public func σταΕλληνικάΨηφία() -> StrictString {
        return inDigits(bcAbbreviation: "π.Χ.")
    }

    /// מחזירה את השנה בעברית ובספרות.
    public func בעברית־בספרות() -> StrictString {
        return inDigits(bcAbbreviation: "לפנה״ס")
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

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = RawValue

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
    public static func − (lhs: GregorianYear, rhs: GregorianYear) -> RawValue {
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
    public init(unsafeRawValue: RawValue) {
        assert(unsafeRawValue ≠ 0, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada:
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
}
