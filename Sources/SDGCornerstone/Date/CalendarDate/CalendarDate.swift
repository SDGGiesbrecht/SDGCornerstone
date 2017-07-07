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

    // [_Define Documentation: SDGCornerstone.CalendarDate.init(hebrewYear:month:day:hour:part:)_]
    /// Creates a date using the Hebrew calendar.
    ///
    /// This initializer has two written forms whose effects are the same:
    /// - `init(hebrewYear:month:day:hour:part:)` tends to be more legible when used with variables.
    /// - `init(hebrew:_:_:at:_:)` tends to be more legible when used with literals.
    public init(hebrewYear year: HebrewYear, month: HebrewMonth = .tishrei, day: HebrewDay = 1, hour: HebrewHour = 0, part: HebrewPart = 0) {
        self.init(definition: HebrewDate(year: year, month: month, day: day, hour: hour, part: part))
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarDate.init(hebrewYear:month:day:hour:part:)_]
    /// Creates a date using the Hebrew calendar.
    ///
    /// This initializer has two written forms whose effects are the same:
    /// - `init(hebrewYear:month:day:hour:part:)` tends to be more legible when used with variables.
    /// - `init(hebrew:_:_:at:_:)` tends to be more legible when used with literals.
    public init(hebrew month: HebrewMonth, _ day: HebrewDay, _ year: HebrewYear, at hour: HebrewHour = 0, part: HebrewPart = 0) {
        self.init(hebrewYear: year, month: month, day: day, hour: hour, part: part)
    }

    // [_Define Documentation: SDGCornerstone.CalendarDate.init(gregorianYear:month:day:hour:minute:second:)_]
    /// Creates a date using the Hebrew calendar.
    ///
    /// This initializer has two written forms whose effects are the same:
    /// - `init(gregorianYear:month:day:hour:minute:second:)` tends to be more legible when used with variables.
    /// - `init(gregorian:_:_:at:_:_:)` tends to be more legible when used with literals.
    public init(gregorianYear year: GregorianYear, month: GregorianMonth = .january, day: GregorianDay = 1, hour: GregorianHour = 0, minute: GregorianMinute = 0, second: GregorianSecond = 0) {
        let definition = GregorianDate(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        self.init(definition: definition)
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarDate.init(gregorianYear:month:day:hour:minute:second:)_]
    /// Creates a date using the Hebrew calendar.
    ///
    /// This initializer has two written forms whose effects are the same:
    /// - `init(gregorianYear:month:day:hour:minute:second:)` tends to be more legible when used with variables.
    /// - `init(gregorian:_:_:at:_:_:)` tends to be more legible when used with literals.
    public init(gregorian month: GregorianMonth, _ day: GregorianDay, _ year: GregorianYear, at hour: GregorianHour = 0, _ minute: GregorianMinute = 0, _ second: GregorianSecond = 0) {
        self.init(gregorianYear: year, month: month, day: day, hour: hour, minute: minute, second: second)
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
            cache.conversions[ObjectIdentifier(type(of: definition))] = definition
        }
    }

    private class Cache {
        fileprivate init() {}
        fileprivate var conversions: [ObjectIdentifier: DateDefinition] = [:]
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

        let cachedDefinition: DateDefinition = cached(in: &cache.conversions[ObjectIdentifier(D.self)]) {
            return recomputeDefinition(as: D.self)
        }

        if let result = cachedDefinition as? D {
            return result
        } else { // [_Exempt from Code Coverage_]
            return recomputeDefinition(as: D.self)
        }
    }

    // MARK: - Text Representations

    /// Returns the date in the ISO format.
    public func dateInISOFormat() -> StrictString {
        return gregorianYear.inISOFormat() + "‐" + gregorianMonth.inISOFormat() + "‐" + gregorianDay.inISOFormat()
    }

    private func dateInBritishEnglish<Y : Year, M : Month, D : Day, W : Weekday>(year: Y, month: M, day: D, weekday: W, withYear: Bool, withWeekday: Bool) -> StrictString {
        var result = day.inEnglishDigits() + " " + month.inEnglish()
        if withYear {
            result += " " + year.inEnglishDigits()
        }
        if withWeekday {
            result.prepend(weekday.inEnglish + " ")
        }
        return result
    }

    private func dateInAmericanEnglish<Y : Year, M : Month, D : Day, W : Weekday>(year: Y, month: M, day: D, weekday: W, withYear: Bool, withWeekday: Bool) -> StrictString {
        var result = month.inEnglish() + " " + day.inEnglishDigits()
        if withYear {
            result += ", " + year.inEnglishDigits()
        }
        if withWeekday {
            result.prepend(weekday.inEnglish() + ", ")
        }
        return result
    }

    /// Returns the Hebrew date in British English.
    public func hebrewDateInBritishEnglish(withYear: Bool = true, withWeekday: Bool = false) -> StrictString {
        return dateInBritishEnglish(year: hebrewYear, month: hebrewMonth, day: hebrewDay, weekday: hebrewWeekday, withYear: withYear, withWeekday: withWeekday)
    }

    /// Returns the Hebrew date in American English.
    public func hebrewDateInAmericanEnglish(withYear: Bool = true, withWeekday: Bool = false) -> StrictString {
        return dateInAmericanEnglish(year: hebrewYear, month: hebrewMonth, day: hebrewDay, weekday: hebrewWeekday, withYear: withYear, withWeekday: withWeekday)
    }

    /// Returns the Gregorian date in British English.
    public func gregorianDateInBritishEnglish(withYear: Bool = true, withWeekday: Bool = false) -> StrictString {
        return dateInBritishEnglish(year: gregorianYear, month: gregorianMonth, day: gregorianDay, weekday: gregorianWeekday, withYear: withYear, withWeekday: withWeekday)
    }

    /// Returns the Gregorian date in American English.
    public func gregorianDateInAmericanEnglish(withYear: Bool = true, withWeekday: Bool = false) -> StrictString {
        return dateInAmericanEnglish(year: gregorianYear, month: gregorianMonth, day: gregorianDay, weekday: gregorianWeekday, withYear: withYear, withWeekday: withWeekday)
    }

    private func datumAufDeutsch<Y : Year, M : Month, D : Day, W : Weekday>(jahr: Y, monat: M, tag: D, wochentag: W, mitJahr: Bool, mitWochentag: Bool) -> StrictString {
        var ergebnis = tag.inDeutschenZiffern() + " " + monat.aufDeutsch()
        if mitJahr {
            ergebnis += " " + jahr.inDeutschenZiffern()
        }
        if mitWochentag {
            ergebnis.prepend(wochentag.aufDeutsch() + ", ")
        }
        return ergebnis
    }

    /// Gibt das hebräische Datum auf Deutsch zurück.
    public func hebräischesDatumAufDeutsch(mitJahr: Bool = true, mitWochentag: Bool = false) -> StrictString {
        return datumAufDeutsch(jahr: hebrewYear, monat: hebrewMonth, tag: hebrewDay, wochentag: hebrewWeekday, mitJahr: mitJahr, mitWochentag: mitWochentag)
    }

    /// Gibt das gregorianische Datum auf Deutsch zurück.
    public func gregorianischesDatumAufDeutsch(mitJahr: Bool = true, mitWochentag: Bool = false) -> StrictString {
        return datumAufDeutsch(jahr: gregorianYear, monat: gregorianMonth, tag: gregorianDay, wochentag: gregorianWeekday, mitJahr: mitJahr, mitWochentag: mitWochentag)
    }

    private func dateEnFrançais<Y : Year, M : Month, D : Day, W : Weekday>(_ majuscules: Casing, an: Y, mois: M, jour: D, jourDeSemaine: W, avecAn: Bool, avecJourDeSemaine: Bool) -> SemanticMarkup {
        var résultat: SemanticMarkup = "le " + jour.enChiffresFrançais() + " " + SemanticMarkup(mois.enFrançais(.sentenceMedial))
        if avecAn {
            résultat += " " + SemanticMarkup(an.enChiffresFrançais())
        }
        if avecJourDeSemaine {
            résultat.prepend(SemanticMarkup(jourDeSemaine.enFrançais(.sentenceMedial)) + ", ")
        }
        return majuscules.applySimpleAlgorithm(to: résultat)
    }

    /// Retourne la date hébraïque en français.
    public func dateHébraïqueEnFrançais(_ majuscules: Casing, avecAn: Bool = true, avecJourDeSemaine: Bool = false) -> SemanticMarkup {
        return dateEnFrançais(majuscules, an: hebrewYear, mois: hebrewMonth, jour: hebrewDay, jourDeSemaine: hebrewWeekday, avecAn: avecAn, avecJourDeSemaine: avecJourDeSemaine)
    }

    /// Retourne la date grégorienne en français.
    public func dateGrégorienneEnFrançais(_ majuscules: Casing, avecAn: Bool = true, avecJourDeSemaine: Bool = false) -> SemanticMarkup {
        return dateEnFrançais(majuscules, an: gregorianYear, mois: gregorianMonth, jour: gregorianDay, jourDeSemaine: gregorianWeekday, avecAn: avecAn, avecJourDeSemaine: avecJourDeSemaine)
    }

    private func ημερομηνίαΣεΕλληνικά<Y : Year, M : Month, D : Day, W : Weekday>(χρόνος: Y, μήνας: M, ημέρα: D, ημέραΤηςΕβδομάδας: W, μεΧρόνο: Bool, μεΗμέραΤηςΕβδομάδας: Bool) -> StrictString {
        var αποτέλεσμα = ημέρα.σεΕλληνικάΨηφία() + " " + μήνας.σεΕλληνικά(.γενική)
        if μεΧρόνο {
            αποτέλεσμα += " " + χρόνος.σεΕλληνικάΨηφία()
        }
        if μεΗμέραΤηςΕβδομάδας {
            αποτέλεσμα.prepend(ημέραΤηςΕβδομάδας.σεΕλληνικά() + ", ")
        }
        return αποτέλεσμα
    }

    /// Επιστρέφει την εβραϊκή ημερομηνία στα ελληνικά.
    public func εβραϊκήΗμερομηνίαΣεΕλληνικά(μεΧρόνο: Bool = true, μεΗμέραΤηςΕβδομάδας: Bool = false) -> StrictString {
        return ημερομηνίαΣεΕλληνικά(χρόνος: hebrewYear, μήνας: hebrewMonth, ημέρα: hebrewDay, ημέραΤηςΕβδομάδας: hebrewWeekday, μεΧρόνο: μεΧρόνο, μεΗμέραΤηςΕβδομάδας: μεΗμέραΤηςΕβδομάδας)
    }

    /// Επιστρέφει την Γρηγοριανή ημερομηνία στα ελληνικά.
    public func γρηγοριανήΗμερομηνίαΣεΕλληνικά(μεΧρόνο: Bool = true, μεΗμέραΤηςΕβδομάδας: Bool = false) -> StrictString {
        return ημερομηνίαΣεΕλληνικά(χρόνος: gregorianYear, μήνας: gregorianMonth, ημέρα: gregorianDay, ημέραΤηςΕβδομάδας: gregorianWeekday, μεΧρόνο: μεΧρόνο, μεΗμέραΤηςΕβδομάδας: μεΗμέραΤηςΕβδομάδας)
    }

    private func תאריך־בעברית<Y : Year, M : Month, D : Day, W : Weekday>(שנה: Y, חודש: M, יום: D, יום־שבוע: W, עם־שנה: Bool, עם־יום־שבוע: Bool) -> StrictString {
        var תוצאה = יום.בעברית־בספרות() + " ב" + חודש.בעברית()
        if עם־שנה {
            תוצאה += " " + שנה.בעברית־בספרות()
        }
        if עם־יום־שבוע {
            תוצאה.prepend(יום־שבוע.בעברית() + ", ")
        }
        return תוצאה
    }

    /// מחזירה את התאריך העברי בעברית.
    public func תאריך־עברי־בעברית(עם־שנה: Bool = true, עם־יום־שבוע: Bool = false) -> StrictString {
        return תאריך־בעברית(שנה: hebrewYear, חודש: hebrewMonth, יום: hebrewDay, יום־שבוע: hebrewWeekday, עם־שנה: עם־שנה, עם־יום־שבוע: עם־יום־שבוע)
    }

    /// מחזירה את התאריך הגרגוריאני בעברית.
    public func תאריך־גרגוריאני־בעברית(עם־שנה: Bool = true, עם־יום־שבוע: Bool = false) -> StrictString {
        return תאריך־בעברית(שנה: gregorianYear, חודש: gregorianMonth, יום: gregorianDay, יום־שבוע: gregorianWeekday, עם־שנה: עם־שנה, עם־יום־שבוע: עם־יום־שבוע)
    }

    /// Returns the time in the ISO format.
    public func timeInISOFormat(includeSeconds: Bool = false) -> StrictString {
        var result: StrictString = gregorianHour.inISOFormat() + ":" as StrictString + gregorianMinute.inISOFormat()
        if includeSeconds {
            result += ":" as StrictString + gregorianSecond.inISOFormat()
        }
        return result
    }

    /// Returns the time in English in the twenty‐four–hour format.
    public func twentyFourHourTimeInEnglish() -> StrictString {
        return gregorianHour.inDigitsInTwentyFourHourFormat() + ":" + gregorianMinute.inDigits()
    }

    /// Returns the time in English in the twelve‐hour format.
    public func twelveHourTimeInEnglish() -> StrictString {
        return gregorianHour.inDigitsInTwelveHourFormat() + ":" + gregorianMinute.inDigits() + " " + gregorianHour.amOrPM()
    }

    /// Gibt die Uhrzeit auf Deutsch zurück.
    public func uhrzeitAufDeutsch() -> StrictString {
        return gregorianHour.inDigitsInTwentyFourHourFormat() + "." + gregorianMinute.inDigits()
    }

    /// Retourne l’heure en français.
    public func heureEnFrançais() -> StrictString {
        return gregorianHour.inDigitsInTwentyFourHourFormat() + " h " + gregorianMinute.inDigits()
    }

    /// Επιστρέφει την ώρα στα ελληνικά.
    public func ώραΣεΕλληνικά(μεΧρόνο: Bool = true, μεΗμέραΤηςΕβδομάδας: Bool = false) -> StrictString {
        return gregorianHour.inDigitsInTwentyFourHourFormat() + ":" + gregorianMinute.inDigits()
    }

    /// מחזירה את השעה בעברית.
    public func שעה־בעברית() -> StrictString {
        return gregorianHour.inDigitsInTwentyFourHourFormat() + ":" + gregorianMinute.inDigits()
    }

    // MARK: - iCalendar

    /// Returns a string representation in the floating iCalendar format.
    public func floatingICalendarFormat() -> StrictString {
        return gregorianYear.inICalendarFormat() + gregorianMonth.inICalendarFormat() + gregorianDay.inICalendarFormat() + ("T" as StrictString) + gregorianHour.inICalendarFormat() + gregorianMinute.inICalendarFormat() + gregorianSecond.inICalendarFormat()
    }

    /// Returns a string representation in UTC in the iCalendar format.
    public func iCalendarFormat() -> StrictString {
        return floatingICalendarFormat() + ("Z" as StrictString)
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
        if let relative = lhs.definition as? RelativeDate {
            lhs.definition = RelativeDate(relative.intervalSince + rhs, after: relative.baseDate)
        } else {
            lhs.definition = RelativeDate(rhs, after: lhs)
        }
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
