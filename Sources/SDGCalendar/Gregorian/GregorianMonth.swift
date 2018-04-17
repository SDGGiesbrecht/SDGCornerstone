/*
 GregorianMonth.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

/// A month of the Gregorian year.
public enum GregorianMonth : Int, CalendarComponent, Codable, ConsistentlyOrderedCalendarComponent, ICalendarComponent, ISOCalendarComponent, Month, EnumerationCalendarComponent, TextualPlaygroundDisplay {

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

    // MARK: - CalendarComponent

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.meanDuration_]
    /// The mean duration.
    public static var meanDuration: CalendarInterval<FloatMax> {
        return GregorianYear.meanDuration ÷ FloatMax(GregorianYear.monthsPerYear)
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.minimumDuration_]
    /// The minimum duration.
    public static var minimumDuration: CalendarInterval<FloatMax> {
        return FloatMax(GregorianMonth.minimumNumberOfDays).days
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.maximumDuration_]
    /// The maximum duration.
    public static var maximumDuration: CalendarInterval<FloatMax> {
        return FloatMax(GregorianMonth.maximumNumberOfDays).days
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    public var description: String {
        return String(UserFacingText({ (localization: InterfaceLocalization) in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.inEnglish()
            }
        }).resolved())
    }

    // MARK: - Decodable

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        try self.init(usingOrdinalFrom: decoder)
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        try encodeUsingOrdinal(to: encoder)
    }

    // MARK: - ISOCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ISOCalendarCompenent.inISOFormat()_]
    /// Returns a string representation in the ISO format.
    public func inISOFormat() -> StrictString {
        return ordinal.inDigits().filled(to: 2, with: "0", from: .start)
    }

    // MARK: - Month

    // [_Inherit Documentation: SDGCornerstone.Month.inEnglish()_]
    /// Returns the English name.
    public func inEnglish() -> StrictString {
        switch self {
        case .january:
            return "January"
        case .february:
            return "February"
        case .march:
            return "March"
        case .april:
            return "April"
        case .may:
            return "May"
        case .june:
            return "June"
        case .july:
            return "July"
        case .august:
            return "August"
        case .september:
            return "September"
        case .october:
            return "October"
        case .november:
            return "November"
        case .december:
            return "December"
        }
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
