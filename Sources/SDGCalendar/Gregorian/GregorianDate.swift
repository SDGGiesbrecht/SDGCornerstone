/*
 GregorianDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

internal struct GregorianDate: DateDefinition, MarkupPlaygroundDisplay {

  // MARK: - Reference Year

  private static let referenceYear: GregorianYear = 2001
  internal static let referenceMoment = CalendarDate(hebrew: .tevet, 6, 5761, at: 6)

  // MARK: - Root Calendar Functions

  private static func intervalFromReferenceDate(toStartOf targetYear: GregorianYear)
    -> CalendarInterval<FloatMax>
  {

    let yearsElapsed = targetYear − GregorianDate.referenceYear

    let cycles = (yearsElapsed.dividedAccordingToEuclid(by: GregorianYear.yearsPerLeapYearCycle))
    var interval = FloatMax(cycles).gregorianLeapYearCycles
    let yearsAccountedFor = cycles × GregorianYear.yearsPerLeapYearCycle
    let firstRemainingYear = GregorianDate.referenceYear + yearsAccountedFor

    for countingYear in firstRemainingYear..<targetYear {
      interval += FloatMax(countingYear.numberOfDays).days
    }

    return interval
  }

  private static func intervalFromStartOfYear(toStartOf month: GregorianMonth, leapYear: Bool)
    -> CalendarInterval<FloatMax>
  {
    guard let previousMonth = month.predecessor() else {
      // January
      return (0 as FloatMax).days
    }
    return GregorianDate.intervalFromStartOfYear(toStartOf: previousMonth, leapYear: leapYear)
      + FloatMax(previousMonth.numberOfDays(leapYear: leapYear)).days
  }

  // MARK: - Initialization

  internal init(
    year: GregorianYear,
    month: GregorianMonth,
    day: GregorianDay,
    hour: GregorianHour,
    minute: GregorianMinute,
    second: GregorianSecond
  ) {
    var month = month
    var day = day

    day.correct(forMonth: &month, year: year)

    self.year = year
    self.month = month
    self.day = day
    self.hour = hour
    self.minute = minute
    self.second = second

    var interval = GregorianDate.intervalFromReferenceDate(toStartOf: year)

    interval += GregorianDate.intervalFromStartOfYear(toStartOf: month, leapYear: year.isLeapYear)

    interval += FloatMax(day.numberAlreadyElapsed).days

    interval += FloatMax(hour.numberAlreadyElapsed).hours

    interval += FloatMax(minute.numberAlreadyElapsed).minutes

    interval += second.numberAlreadyElapsed.seconds

    self.intervalSinceReferenceDate = interval
  }

  // MARK: - Properties

  internal let year: GregorianYear
  internal let month: GregorianMonth
  internal let day: GregorianDay
  internal let hour: GregorianHour
  internal let minute: GregorianMinute
  internal let second: GregorianSecond

  // MARK: - DateDefinition

  internal static let identifier: StrictString = "gregoriano"
  internal static let referenceDate: CalendarDate = referenceMoment

  internal var intervalSinceReferenceDate: CalendarInterval<FloatMax>

  internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
    self.intervalSinceReferenceDate = intervalSinceReferenceDate

    let approxYears = Int(intervalSinceReferenceDate ÷ GregorianYear.meanDuration)
    let guessYear = GregorianDate.referenceYear + approxYears
    let year = findLocalMinimum(
      near: guessYear
    ) { (year: GregorianYear) -> CalendarInterval<FloatMax> in
      let interval =
        intervalSinceReferenceDate
        − GregorianDate.intervalFromReferenceDate(toStartOf: year)
      if interval.isNonNegative {
        return interval
      } else {
        return |interval| + GregorianYear.maximumDuration
      }
    }
    var remainder: CalendarInterval<FloatMax> =
      intervalSinceReferenceDate
      − GregorianDate.intervalFromReferenceDate(toStartOf: year)

    var approxMonthsElapsed = Int(remainder ÷ GregorianMonth.meanDuration)
    approxMonthsElapsed.decrease(to: GregorianYear.monthsPerYear − 1)
    let guessMonth = GregorianMonth(numberAlreadyElapsed: approxMonthsElapsed)
    let month = findLocalMinimum(
      near: guessMonth,
      within: GregorianMonth.allCases.first!...GregorianMonth.allCases.last!
    ) { (month: GregorianMonth) -> CalendarInterval<FloatMax> in
      let interval =
        remainder
        − GregorianDate.intervalFromStartOfYear(toStartOf: month, leapYear: year.isLeapYear)

      if interval.isNonNegative {
        return interval
      } else {
        return |interval| + GregorianYear.maximumDuration
      }
    }
    remainder −= GregorianDate.intervalFromStartOfYear(toStartOf: month, leapYear: year.isLeapYear)

    let day = GregorianDay(numberAlreadyElapsed: Int(remainder.inDays.rounded(.down)))
    remainder = remainder.mod((1 as FloatMax).days)

    let hour = GregorianHour(numberAlreadyElapsed: Int(remainder.inHours.rounded(.down)))
    remainder = remainder.mod((1 as FloatMax).hours)

    let minute = GregorianMinute(numberAlreadyElapsed: Int(remainder.inMinutes.rounded(.down)))
    remainder = remainder.mod((1 as FloatMax).minutes)

    let second = GregorianSecond(numberAlreadyElapsed: remainder.inSeconds)

    self.year = year
    self.month = month
    self.day = day
    self.hour = hour
    self.minute = minute
    self.second = second
  }

  // MARK: - Decodable

  internal init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let year = try container.decode(GregorianYear.self)
    let month = try container.decode(GregorianMonth.self)
    let day = try container.decode(GregorianDay.self)
    let hour = try container.decode(GregorianHour.self)
    let minute = try container.decode(GregorianMinute.self)
    let second = try container.decode(GregorianSecond.self)
    self = GregorianDate(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second
    )
  }

  // MARK: - Encodable

  internal func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(year)
    try container.encode(month)
    try container.encode(day)
    try container.encode(hour)
    try container.encode(minute)
    try container.encode(second)
  }

  // MARK: - MarkupPlaygroundDisplay

  public func playgroundDescriptionMarkup() -> SemanticMarkup {
    return UserFacing<SemanticMarkup, FormatLocalization>({ localization in
      let date = CalendarDate(definition: self)
      switch localization {
      case .englishUnitedKingdom:
        return SemanticMarkup(
          date.gregorianDateInBritishEnglish() + " at " + date.twentyFourHourTimeInEnglish()
        )
      case .englishUnitedStates, .englishCanada:
        return SemanticMarkup(
          date.gregorianDateInAmericanEnglish() + " at " + date.twelveHourTimeInEnglish()
        )
      case .deutschDeutschland:
        return SemanticMarkup(
          date.gregorianischesDatumAufDeutsch() + " um " + date.uhrzeitAufDeutsch()
        )
      case .françaisFrance:
        return date.dateGrégorienneEnFrançais(.sentenceMedial) + " à " + date.heureEnFrançais()
      case .ελληνικάΕλλάδα:
        if self.hour == 1 {
          return SemanticMarkup(
            date.γρηγοριανήΗμερομηνίαΣεΕλληνικά() + " στη " + date.ώραΣεΕλληνικά()
          )
        } else {
          return SemanticMarkup(
            date.γρηγοριανήΗμερομηνίαΣεΕλληνικά() + " στις " + date.ώραΣεΕλληνικά()
          )
        }
      case .עברית־ישראל:
        return SemanticMarkup(date.תאריך־גרגוריאני־בעברית() + " ב־" + date.שעה־בעברית())
      }
    }).resolved()
  }
}
