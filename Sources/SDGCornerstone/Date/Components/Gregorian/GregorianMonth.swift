/*
 GregorianMonth.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollectionsCore

/// A month of the Gregorian year.
public enum GregorianMonth : Int, CalendarComponent, Codable, ConsistentlyOrderedCalendarComponent, ICalendarComponent, ISOCalendarComponent, Month, EnumerationCalendarComponent {

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

    // [_Inherit Documentation: SDGCornerstone.Month.aufDeutsch()_]
    /// Gibt den deutschen Namen zurück.
    public func aufDeutsch() -> StrictString {
        switch self {
        case .january:
            return "Januar"
        case .february:
            return "Februar"
        case .march:
            return "März"
        case .april:
            return "April"
        case .may:
            return "Mai"
        case .june:
            return "Juni"
        case .july:
            return "Juli"
        case .august:
            return "August"
        case .september:
            return "September"
        case .october:
            return "Oktober"
        case .november:
            return "November"
        case .december:
            return "Dezember"
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Month.enFrançais()_]
    /// Retourne le nom français.
    public func enFrançais(_ majuscules: Casing) -> StrictString {
        let nom: StrictString
        switch self {
        case .january:
            nom = "janvier"
        case .february:
            nom = "février"
        case .march:
            nom = "mars"
        case .april:
            nom = "avril"
        case .may:
            nom = "mai"
        case .june:
            nom = "juin"
        case .july:
            nom = "juillet"
        case .august:
            nom = "août"
        case .september:
            nom = "septembre"
        case .october:
            nom = "octobre"
        case .november:
            nom = "novembre"
        case .december:
            nom = "décembre"
        }
        return majuscules.applySimpleAlgorithm(to: nom)
    }

    // [_Inherit Documentation: SDGCornerstone.Month.σεΕλληνικά()_]
    /// Επιστρέφει τον ελληνικό όνομα.
    public func σεΕλληνικά(_ πτώση: ΓραμματικήΠτώση) -> StrictString {
        let όνομα: StrictString

        func απλό(όνομα: StrictString) -> StrictString {
            switch πτώση {
            case .ονομαστική:
                return όνομα + "ος"
            case .αιτιατική:
                return όνομα + "ο"
            case .γενική:
                return όνομα.replacingMatches(for: "́" as StrictString, with: "" as StrictString) + "́ου"
            case .κλητική:
                return όνομα + "ε"
            }
        }

        switch self {
        case .january:
            return απλό(όνομα: "Ιανουάρι")
        case .february:
            return απλό(όνομα: "Φεβρουάρι")
        case .march:
            return απλό(όνομα: "Μάρτι")
        case .april:
            return απλό(όνομα: "Απρίλι")
        case .may:
            if πτώση == .γενική {
                return "Μαΐου"
            } else {
                return απλό(όνομα: "Μάι")
            }
        case .june:
            return απλό(όνομα: "Ιούνι")
        case .july:
            return απλό(όνομα: "Ιούλι")
        case .august:
            if πτώση == .γενική {
                return "Αυγούστου"
            } else {
                return απλό(όνομα: "Αύγουστ")
            }
        case .september:
            return απλό(όνομα: "Σεπτέμβρι")
        case .october:
            return απλό(όνομα: "Οκτώβρι")
        case .november:
            return απλό(όνομα: "Νοέμβρι")
        case .december:
            return απλό(όνομα: "Δεκέμβρι")
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Month.בעברית()_]
    /// מחזירה את השם העברי.
    public func בעברית() -> StrictString {
        switch self {
        case .january:
            return "ינואר"
        case .february:
            return "פברואר"
        case .march:
            return "מרץ"
        case .april:
            return "אפריל"
        case .may:
            return "מאי"
        case .june:
            return "יוני"
        case .july:
            return "יולי"
        case .august:
            return "אוגוסט"
        case .september:
            return "ספטמבר"
        case .october:
            return "אוקטובר"
        case .november:
            return "נובמבר"
        case .december:
            return "דצמבר"
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
