/*
 DescribableDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText
import SDGLocalization

/// A date that can be described.
///
/// Describable dates can be queried for properties such as the hour of the day or the day of the week, but may not be suitable for further calendaring computations.
public protocol DescribableDate: CustomDebugStringConvertible, CustomPlaygroundDisplayConvertible,
  CustomStringConvertible
{

  // Hebrew

  /// The Hebrew year.
  var hebrewYear: HebrewYear { get }
  /// The Hebrew month.
  var hebrewMonth: HebrewMonth { get }
  /// The Hebrew weekday.
  var hebrewWeekday: HebrewWeekday { get }
  /// The Hebrew day.
  var hebrewDay: HebrewDay { get }
  /// The Hebrew hour.
  var hebrewHour: HebrewHour { get }
  /// The Hebrew part.
  var hebrewPart: HebrewPart { get }

  // Gregorian

  /// The Gregorian year.
  var gregorianYear: GregorianYear { get }
  /// The Gregorian month.
  var gregorianMonth: GregorianMonth { get }
  /// The Gregorian weekday.
  var gregorianWeekday: GregorianWeekday { get }
  /// The Gregorian day.
  var gregorianDay: GregorianDay { get }
  /// The Gregorian hour.
  var gregorianHour: GregorianHour { get }
  /// The Gregorian minute.
  var gregorianMinute: GregorianMinute { get }
  /// The Gregorian second.
  var gregorianSecond: GregorianSecond { get }
}

extension DescribableDate {

  private func dateInBritishEnglish<Y: Year, M: Month, D: Day, W: Weekday>(
    year: Y,
    month: M,
    day: D,
    weekday: W,
    withYear: Bool,
    withWeekday: Bool
  ) -> StrictString {
    var result = day.inEnglishDigits() + " " + month.inEnglish()
    if withYear {
      result += " " + year.inEnglishDigits()
    }
    if withWeekday {
      result.prepend(contentsOf: weekday.inEnglish() + ", ")
    }
    return result
  }

  private func dateInAmericanEnglish<Y: Year, M: Month, D: Day, W: Weekday>(
    year: Y,
    month: M,
    day: D,
    weekday: W,
    withYear: Bool,
    withWeekday: Bool
  ) -> StrictString {
    var result = month.inEnglish() + " " + day.inEnglishDigits()
    if withYear {
      result += ", " + year.inEnglishDigits()
    }
    if withWeekday {
      result.prepend(contentsOf: weekday.inEnglish() + ", ")
    }
    return result
  }

  /// Returns the Hebrew date in British English.
  ///
  /// - Parameters:
  ///     - withYear: Whether or not to include the year.
  ///     - withWeekday: Whether or not to include the day of the week.
  public func hebrewDateInBritishEnglish(withYear: Bool = true, withWeekday: Bool = false)
    -> StrictString
  {
    return dateInBritishEnglish(
      year: hebrewYear,
      month: hebrewMonth,
      day: hebrewDay,
      weekday: hebrewWeekday,
      withYear: withYear,
      withWeekday: withWeekday
    )
  }

  /// Returns the Hebrew date in American English.
  ///
  /// - Parameters:
  ///     - withYear: Whether or not to include the year.
  ///     - withWeekday: Whether or not to include the day of the week.
  public func hebrewDateInAmericanEnglish(withYear: Bool = true, withWeekday: Bool = false)
    -> StrictString
  {
    return dateInAmericanEnglish(
      year: hebrewYear,
      month: hebrewMonth,
      day: hebrewDay,
      weekday: hebrewWeekday,
      withYear: withYear,
      withWeekday: withWeekday
    )
  }

  /// Returns the Gregorian date in British English.
  ///
  /// - Parameters:
  ///     - withYear: Whether or not to include the year.
  ///     - withWeekday: Whether or not to include the day of the week.
  public func gregorianDateInBritishEnglish(withYear: Bool = true, withWeekday: Bool = false)
    -> StrictString
  {
    return dateInBritishEnglish(
      year: gregorianYear,
      month: gregorianMonth,
      day: gregorianDay,
      weekday: gregorianWeekday,
      withYear: withYear,
      withWeekday: withWeekday
    )
  }

  /// Returns the Gregorian date in American English.
  ///
  /// - Parameters:
  ///     - withYear: Whether or not to include the year.
  ///     - withWeekday: Whether or not to include the day of the week.
  public func gregorianDateInAmericanEnglish(withYear: Bool = true, withWeekday: Bool = false)
    -> StrictString
  {
    return dateInAmericanEnglish(
      year: gregorianYear,
      month: gregorianMonth,
      day: gregorianDay,
      weekday: gregorianWeekday,
      withYear: withYear,
      withWeekday: withWeekday
    )
  }

  private func datumAufDeutsch<Y: Year, M: Month, D: Day, W: Weekday>(
    jahr: Y,
    monat: M,
    tag: D,
    wochentag: W,
    mitJahr: Bool,
    mitWochentag: Bool
  ) -> StrictString {
    var ergebnis = tag.inDeutschenZiffern() + " " + monat._aufDeutsch()
    if mitJahr {
      ergebnis += " " + jahr._inDeutschenZiffern()
    }
    if mitWochentag {
      ergebnis.prepend(contentsOf: wochentag.aufDeutsch() + ", ")
    }
    return ergebnis
  }

  // @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
  /// Gibt das hebräische Datum auf Deutsch zurück.
  ///
  /// - Parameters:
  ///     - mitJahr: Ob das Datum das Jahr enthalten soll.
  ///     - mitWochentag: Ob das Datum den Wochentag enthalten soll.
  public func hebräischesDatumAufDeutsch(mitJahr: Bool = true, mitWochentag: Bool = false)
    -> StrictString
  {
    return datumAufDeutsch(
      jahr: hebrewYear,
      monat: hebrewMonth,
      tag: hebrewDay,
      wochentag: hebrewWeekday,
      mitJahr: mitJahr,
      mitWochentag: mitWochentag
    )
  }

  // @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
  /// Gibt das gregorianisches Datum auf Deutsch zurück.
  ///
  /// - Parameters:
  ///     - mitJahr: Ob das Datum das Jahr enthalten soll.
  ///     - mitWochentag: Ob das Datum den Wochentag enthalten soll.
  public func gregorianischesDatumAufDeutsch(mitJahr: Bool = true, mitWochentag: Bool = false)
    -> StrictString
  {
    return datumAufDeutsch(
      jahr: gregorianYear,
      monat: gregorianMonth,
      tag: gregorianDay,
      wochentag: gregorianWeekday,
      mitJahr: mitJahr,
      mitWochentag: mitWochentag
    )
  }

  private func dateEnFrançais<Y: Year, M: Month, D: Day, W: Weekday>(
    _ majuscules: Casing,
    an: Y,
    mois: M,
    jour: D,
    jourDeSemaine: W,
    avecAn: Bool,
    avecJourDeSemaine: Bool
  ) -> SemanticMarkup {
    var résultat: SemanticMarkup =
      avecJourDeSemaine
      ? "le" : SemanticMarkup(majuscules.apply(to: "le"))  // @exempt(from: tests) Unused so far.
    résultat += " " + jour.enChiffresFrançais()
    résultat += " " + SemanticMarkup(mois._enFrançais(.sentenceMedial))

    if avecAn {
      résultat += " " + SemanticMarkup(an._enChiffresFrançais())
    }
    if avecJourDeSemaine {
      résultat.prepend(contentsOf: SemanticMarkup(jourDeSemaine.enFrançais(majuscules)) + ", ")
    }
    return résultat
  }

  // @localization(🇫🇷FR) @notLocalized(🇨🇦EN)
  /// Retourne la date hébraïque en français.
  ///
  /// - Parameters:
  ///     - majuscules: La mode d’utilisation des majuscules.
  ///     - avecAn: Si la date devrait inclure l’an.
  ///     - avecJourDeSemaine: Si la date devrait inclure le jour de semaine.
  public func dateHébraïqueEnFrançais(
    _ majuscules: Casing,
    avecAn: Bool = true,
    avecJourDeSemaine: Bool = false
  ) -> SemanticMarkup {
    return dateEnFrançais(
      majuscules,
      an: hebrewYear,
      mois: hebrewMonth,
      jour: hebrewDay,
      jourDeSemaine: hebrewWeekday,
      avecAn: avecAn,
      avecJourDeSemaine: avecJourDeSemaine
    )
  }

  // @localization(🇫🇷FR) @notLocalized(🇨🇦EN)
  /// Retourne la date grégorienne en français.
  ///
  /// - Parameters:
  ///     - majuscules: La mode d’utilisation des majuscules.
  ///     - avecAn: Si la date devrait inclure l’an.
  ///     - avecJourDeSemaine: Si la date devrait inclure le jour de semaine.
  public func dateGrégorienneEnFrançais(
    _ majuscules: Casing,
    avecAn: Bool = true,
    avecJourDeSemaine: Bool = false
  ) -> SemanticMarkup {
    return dateEnFrançais(
      majuscules,
      an: gregorianYear,
      mois: gregorianMonth,
      jour: gregorianDay,
      jourDeSemaine: gregorianWeekday,
      avecAn: avecAn,
      avecJourDeSemaine: avecJourDeSemaine
    )
  }

  private func ημερομηνίαΣεΕλληνικά<Y: Year, M: Month, D: Day, W: Weekday>(
    χρόνος: Y,
    μήνας: M,
    ημέρα: D,
    ημέραΤηςΕβδομάδας: W,
    μεΧρόνο: Bool,
    μεΗμέραΤηςΕβδομάδας: Bool
  ) -> StrictString {
    var αποτέλεσμα = ημέρα.σεΕλληνικάΨηφία() + " " + μήνας._σεΕλληνικά(.γενική)
    if μεΧρόνο {
      αποτέλεσμα += " " + χρόνος._σεΕλληνικάΨηφία()
    }
    if μεΗμέραΤηςΕβδομάδας {
      αποτέλεσμα.prepend(contentsOf: ημέραΤηςΕβδομάδας.σεΕλληνικά() + ", ")
    }
    return αποτέλεσμα
  }

  // @localization(🇬🇷ΕΛ) @notLocalized(🇨🇦EN)
  /// Επιστρέφει την εβραϊκή ημερομηνία στα Ελληνικά.
  ///
  /// - Parameters:
  ///     - μεΧρόνο: Αν η ημερομηνία θα περιλάβει τον χρόνο.
  ///     - μεΗμέραΤηςΕβδομάδας: Αν η ημερομηνία θα περιλάβει την ημέρα της εβδομάδας.
  public func εβραϊκήΗμερομηνίαΣεΕλληνικά(μεΧρόνο: Bool = true, μεΗμέραΤηςΕβδομάδας: Bool = false)
    -> StrictString
  {
    return ημερομηνίαΣεΕλληνικά(
      χρόνος: hebrewYear,
      μήνας: hebrewMonth,
      ημέρα: hebrewDay,
      ημέραΤηςΕβδομάδας: hebrewWeekday,
      μεΧρόνο: μεΧρόνο,
      μεΗμέραΤηςΕβδομάδας: μεΗμέραΤηςΕβδομάδας
    )
  }

  // @localization(🇬🇷ΕΛ) @notLocalized(🇨🇦EN)
  /// Επιστρέφει την γρηγοριανή ημερομηνία στα Ελληνικά.
  ///
  /// - Parameters:
  ///     - μεΧρόνο: Αν η ημερομηνία θα περιλάβει τον χρόνο.
  ///     - μεΗμέραΤηςΕβδομάδας: Αν η ημερομηνία θα περιλάβει την ημέρα της εβδομάδας.
  public func γρηγοριανήΗμερομηνίαΣεΕλληνικά(
    μεΧρόνο: Bool = true,
    μεΗμέραΤηςΕβδομάδας: Bool = false
  ) -> StrictString {
    return ημερομηνίαΣεΕλληνικά(
      χρόνος: gregorianYear,
      μήνας: gregorianMonth,
      ημέρα: gregorianDay,
      ημέραΤηςΕβδομάδας: gregorianWeekday,
      μεΧρόνο: μεΧρόνο,
      μεΗμέραΤηςΕβδομάδας: μεΗμέραΤηςΕβδομάδας
    )
  }

  private func תאריך־בעברית<Y: Year, M: Month, D: Day, W: Weekday>(
    שנה: Y,
    חודש: M,
    יום: D,
    יום־שבוע: W,
    עם־שנה: Bool,
    עם־יום־שבוע: Bool
  ) -> StrictString {
    var תוצאה = יום.בעברית־בספרות() + " ב" + חודש._בעברית()
    if עם־שנה {
      תוצאה += " " + שנה._בעברית־בספרות()
    }
    if עם־יום־שבוע {
      תוצאה.prepend(contentsOf: יום־שבוע.בעברית() + ", ")
    }
    return תוצאה
  }

  // @localization(🇮🇱עב) @notLocalized(🇨🇦EN)
  /// משיבה את התאריך עברי בעברית.
  ///
  /// - Parameters:
  ///     - עם־שנה: אם התאריך צריך להכיל את השנה.
  ///     - עם־שנה: אם התאריך צריך להכיל את יום השבוע.
  public func תאריך־עברי־בעברית(עם־שנה: Bool = true, עם־יום־שבוע: Bool = false) -> StrictString {
    return תאריך־בעברית(
      שנה: hebrewYear,
      חודש: hebrewMonth,
      יום: hebrewDay,
      יום־שבוע: hebrewWeekday,
      עם־שנה: עם־שנה,
      עם־יום־שבוע: עם־יום־שבוע
    )
  }

  // @localization(🇮🇱עב) @notLocalized(🇨🇦EN)
  /// משיבה את התאריך גרגוריאני בעברית.
  ///
  /// - Parameters:
  ///     - עם־שנה: אם התאריך צריך להכיל את השנה.
  ///     - עם־שנה: אם התאריך צריך להכיל את יום השבוע.
  public func תאריך־גרגוריאני־בעברית(עם־שנה: Bool = true, עם־יום־שבוע: Bool = false) -> StrictString
  {
    return תאריך־בעברית(
      שנה: gregorianYear,
      חודש: gregorianMonth,
      יום: gregorianDay,
      יום־שבוע: gregorianWeekday,
      עם־שנה: עם־שנה,
      עם־יום־שבוע: עם־יום־שבוע
    )
  }

  /// Returns the time in English in the twenty‐four–hour format.
  public func twentyFourHourTimeInEnglish() -> StrictString {
    return gregorianHour.inDigitsInTwentyFourHourFormat() + ":" + gregorianMinute.inDigits()
  }

  /// Returns the time in English in the twelve‐hour format.
  public func twelveHourTimeInEnglish() -> StrictString {
    var result = gregorianHour.inDigitsInTwelveHourFormat() + ":" + gregorianMinute.inDigits()
    result += " " + gregorianHour.amOrPM()
    return result
  }

  // @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
  /// Gibt die Uhrzeit auf Deutsch zurück.
  public func uhrzeitAufDeutsch() -> StrictString {
    return gregorianHour.inDigitsInTwentyFourHourFormat() + "." + gregorianMinute.inDigits()
  }

  // @localization(🇫🇷FR) @notLocalized(🇨🇦EN)
  /// Retourne l’heure en français.
  public func heureEnFrançais() -> StrictString {
    return gregorianHour.inDigitsInTwentyFourHourFormat() + " h " + gregorianMinute.inDigits()
  }

  // @localization(🇬🇷ΕΛ) @notLocalized(🇨🇦EN)
  /// Επιστρέφει την ώρα στα Ελληνικά.
  public func ώραΣεΕλληνικά() -> StrictString {
    return gregorianHour.inDigitsInTwentyFourHourFormat() + ":" + gregorianMinute.inDigits()
  }

  // @localization(🇮🇱עב) @notLocalized(🇨🇦EN)
  /// משיבה את השעה בעברית.
  public func שעה־בעברית() -> StrictString {
    return gregorianHour.inDigitsInTwentyFourHourFormat() + ":" + gregorianMinute.inDigits()
  }
}
