/*
 GregorianYear.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

// @localization(🇩🇪DE) @crossReference(GregorianYear)
// #example(1, gregorianischesJahr)
/// Ein gregorianisches Jahr.
///
/// Jahren vor Christus werden mit einer negativen Zahl voreingestellt. Die bereitgestellte mathematische Funktionen berücksichtigen automatisch das Fehlen eines Jahre Null. Zum Beispiel:
///
/// ```swift
/// let adOne = GregorianYear(1)
/// let oneBC = GregorianYear(−1)
/// let oneYear = Int(1)
///
/// XCTAssertEqual(adOne − oneYear, oneBC)
/// XCTAssertEqual(adOne − oneBC, oneYear)
/// ```
public typealias GregorianischesJahr = GregorianYear
// @localization(🇨🇦EN) @crossReference(GregorianYear)
// #example(1, gregorianYear)
/// A Gregorian year.
///
/// Initialize with a negative integer to get a BC year. The provided mathematical functions automatically accomodate for the lack of a zero year. For example:
///
/// ```swift
/// let adOne = GregorianYear(1)
/// let oneBC = GregorianYear(−1)
/// let oneYear = Int(1)
///
/// XCTAssertEqual(adOne − oneYear, oneBC)
/// XCTAssertEqual(adOne − oneBC, oneYear)
/// ```
public struct GregorianYear : CalendarComponent, CodableViaRawRepresentableCalendarComponent, ConsistentlyOrderedCalendarComponent, ICalendarComponent, ISOCalendarComponent, RawRepresentableCalendarComponent, Year {

    // MARK: - Static Properties

    // Leap Year Cycles

    /// The number of years in a leap year cycle.
    public static let yearsPerLeapYearCycle: Int = 400

    /// The number of months in a leap year cycle.
    public static let monthsPerLeapYearCycle: Int = GregorianYear.yearsPerLeapYearCycle × GregorianYear.monthsPerYear

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
    public static let monthsPerYear: Int = GregorianMonth.allCases.count

    // Days

    /// The number of days in a non‐leap year.
    public static let daysPerNormalYear: Int = {
        var days = 0
        for month in GregorianMonth.allCases {
            days += month.numberOfDays(leapYear: false)
        }
        return days
    }()
    /// The number of days in a leap year.
    public static let daysPerLeapYear: Int = {
        var days = 0
        for month in GregorianMonth.allCases {
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

    public static var meanDuration: CalendarInterval<FloatMax> {
        return FloatMax(GregorianYear.daysPerLeapYearCycle).days ÷ FloatMax(GregorianYear.yearsPerLeapYearCycle)
    }

    public static var minimumDuration: CalendarInterval<FloatMax> {
        return FloatMax(GregorianYear.daysPerNormalYear).days
    }

    public static var maximumDuration: CalendarInterval<FloatMax> {
        return FloatMax(GregorianYear.daysPerLeapYear).days
    }

    // MARK: - ConsistentlyOrderedCalendarComponent

    public init(numberAlreadyElapsed: Int) {
        self = (1 as GregorianYear) + numberAlreadyElapsed
    }

    public init(ordinal: Int) {
        self.init(ordinal)
    }

    public var numberAlreadyElapsed: Int {
        return self − (1 as GregorianYear)
    }

    public var ordinal: Int {
        return rawValue
    }

    // MARK: - ISOCalendarComponent

    public func inISOFormat() -> StrictString {
        let cardinal = self − GregorianYear(−1)
        var digits = (|cardinal|).inDigits().filled(to: 4, with: "0", from: .start)
        if cardinal.isNegative {
            digits.prepend("−")
        }
        return digits
    }

    // MARK: - PointProtocol

    public typealias Vector = Int

    public static func += (precedingValue: inout GregorianYear, followingValue: Int) {
        var result = precedingValue.rawValue + followingValue

        // Compensate for zero year.

        if precedingValue.year > 0 ∧ result ≤ 0 {
            // Crossed zero downwards
            result −= 1
        } else if precedingValue.year < 0 ∧ result ≥ 0 {
            // Crossed zero upwards
            result += 1
        }
        precedingValue = GregorianYear(result)
    }

    public static func − (precedingValue: GregorianYear, followingValue: GregorianYear) -> Int {
        var result = precedingValue.rawValue − followingValue.rawValue

        // Compensate for zero year.
        if precedingValue.year > 0 ∧ followingValue.year < 0 {
            // Positive distance crossing zero.
            result −= 1
        } else if precedingValue.year < 0 ∧ followingValue.year > 0 {
            // Negative distance crossing zero.
            result += 1
        }

        return result
    }

    // MARK: - RawRepresentableCalendarComponent

    public init(unsafeRawValue: Int) {
        assert(unsafeRawValue ≠ 0, UserFacing<StrictString, APILocalization>({ localization in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "0 is not a valid Gregorian year."
            }
        }))
        year = unsafeRawValue
    }

    public static let validRange: Range<Int>? = nil

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

    public func inEnglishDigits() -> StrictString {
        return inDigits(bcAbbreviation: "BC")
    }

    public func _inDeutschenZiffern() -> StrictString {
        return inDigits(bcAbbreviation: "v. Chr.")
    }

    public func _enChiffresFrançais() -> StrictString {
        return inDigits(bcAbbreviation: "av. J.‐C.")
    }

    public func _σεΕλληνικάΨηφία() -> StrictString {
        return inDigits(bcAbbreviation: "π.Χ.")
    }

    public func _בעברית־בספרות() -> StrictString {
        return inDigits(bcAbbreviation: "לפנה״ס")
    }
}
