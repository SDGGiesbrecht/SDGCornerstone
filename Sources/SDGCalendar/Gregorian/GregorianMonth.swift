/*
 GregorianMonth.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A month of the Gregorian year.
public enum GregorianMonth: Int, CalendarComponent, ConsistentlyOrderedCalendarComponent, Decodable,
  Encodable, EnumerationCalendarComponent, ICalendarComponent, ISOCalendarComponent, Month,
  TextualPlaygroundDisplay
{

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
    for month in GregorianMonth.allCases {
      max.increase(to: month.maximumNumberOfDays)
    }
    return max
  }()
  /// The minimum number of days in a Gregorian month.
  public static let minimumNumberOfDays: Int = {
    var min = maximumNumberOfDays
    for month in GregorianMonth.allCases {
      min.decrease(to: month.minimumNumberOfDays)
    }
    return min
  }()

  // MARK: - Properties

  /// The number of days in the month.
  ///
  /// - Parameters:
  ///     - leapYear: Whether or not the result should represent a leap year.
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

  public static var meanDuration: CalendarInterval<FloatMax> {
    return GregorianYear.meanDuration ÷ FloatMax(GregorianYear.monthsPerYear)
  }

  public static var minimumDuration: CalendarInterval<FloatMax> {
    return FloatMax(GregorianMonth.minimumNumberOfDays).days
  }

  public static var maximumDuration: CalendarInterval<FloatMax> {
    return FloatMax(GregorianMonth.maximumNumberOfDays).days
  }

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    try self.init(usingOrdinalFrom: decoder)
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    try encodeUsingOrdinal(to: encoder)
  }

  // MARK: - ISOCalendarComponent

  public func inISOFormat() -> StrictString {
    return ordinal.inDigits().filled(to: 2, with: "0", from: .start)
  }

  // MARK: - Month

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

  public func _aufDeutsch() -> StrictString {
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

  public func _enFrançais(_ majuscules: Casing) -> StrictString {
    switch self {
    case .january:
      return majuscules.apply(to: "janvier")
    case .february:
      return majuscules.apply(to: "février")
    case .march:
      return majuscules.apply(to: "mars")
    case .april:
      return majuscules.apply(to: "avril")
    case .may:
      return majuscules.apply(to: "mai")
    case .june:
      return majuscules.apply(to: "juin")
    case .july:
      return majuscules.apply(to: "juillet")
    case .august:
      return majuscules.apply(to: "août")
    case .september:
      return majuscules.apply(to: "septembre")
    case .october:
      return majuscules.apply(to: "octobre")
    case .november:
      return majuscules.apply(to: "novembre")
    case .december:
      return majuscules.apply(to: "décembre")
    }
  }

  public func _σεΕλληνικά(_ πτώση: _ΓραμματικήΠτώση) -> StrictString {
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
      } else {  // @exempt(from: tests) Unused so far.
        return απλό(όνομα: "Μάι")
      }
    case .june:
      return απλό(όνομα: "Ιούνι")
    case .july:
      return απλό(όνομα: "Ιούλι")
    case .august:
      if πτώση == .γενική {
        return "Αυγούστου"
      } else {  // @exempt(from: tests) Unused so far.
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

  public func _בעברית() -> StrictString {
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

  public typealias Vector = RawValue
}
