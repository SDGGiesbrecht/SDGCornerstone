/*
 HebrewDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

internal struct HebrewDate: DateDefinition, MarkupPlaygroundDisplay {

  // MARK: - Reference Year

  private static let referenceYear: HebrewYear = 5758
  private static let intervalFromStartOfReferenceYearToReferenceMoon: CalendarInterval<FloatMax> =
    (4 as FloatMax).hours + (129 as FloatMax).hebrewParts
  private static let weekdayOfReferenceYearStart: HebrewWeekday = .thursday

  // MARK: - Root Calendar Functions

  internal static func intervalFromReferenceDate(
    toStartOf targetYear: HebrewYear
  ) -> CalendarInterval<FloatMax> {

    let yearsElapsed = targetYear − HebrewDate.referenceYear

    let cyclesElapsed = yearsElapsed.dividedAccordingToEuclid(by: HebrewYear.yearsPerLeapYearCycle)
    var monthsElapsed = cyclesElapsed × HebrewYear.monthsPerLeapYearCycle

    for countingYear
      in (HebrewDate.referenceYear + cyclesElapsed × HebrewYear.yearsPerLeapYearCycle)..<targetYear
    {
      monthsElapsed += countingYear.numberOfMonths
    }

    let yearMoon =
      HebrewDate.intervalFromStartOfReferenceYearToReferenceMoon
      + FloatMax(monthsElapsed).hebrewMoons

    var yearStart = yearMoon.rounded(.down, toMultipleOf: (1 as FloatMax).days)
    let moonsUnitsIntoDay = yearMoon.mod((1 as FloatMax).days)

    var oldMoonOccurred = false
    if moonsUnitsIntoDay ≥ (18 as FloatMax).hours {
      // Old Moon: New moon is after 18 hours (noon), so postpone 1 day
      yearStart += (1 as FloatMax).days
      oldMoonOccurred = true
    }

    let intervalSinceStartOfReferenceWeek =
      yearStart
      + FloatMax(weekdayOfReferenceYearStart.numberAlreadyElapsed).days
    let intervalIntoWeek = intervalSinceStartOfReferenceWeek.mod((1 as FloatMax).weeks)
    let weekday = HebrewWeekday(numberAlreadyElapsed: Int(intervalIntoWeek.inDays))

    switch weekday {
    case .sunday, .wednesday, .friday:
      // Postpone if Sunday, Wednesday or Friday
      yearStart += (1 as FloatMax).days
    default:
      break
    }

    if ¬oldMoonOccurred {
      if ¬targetYear.isLeapYear {
        if weekday == .tuesday {
          if moonsUnitsIntoDay ≥ (9 as FloatMax).hours + (204 as FloatMax).hebrewParts {
            // No old moon and too late on Tuesday, so add two days (to Wednesday, then in turn, because of the above rule, to Thursday).
            yearStart += (2 as FloatMax).days
          }
        }
      }

      if (targetYear − 1).isLeapYear {
        if weekday == .monday {
          if moonsUnitsIntoDay ≥ (15 as FloatMax).hours + (589 as FloatMax).hebrewParts {
            // No old moon, immediately following a leap year and too late on Monday, so postpone.
            yearStart += (1 as FloatMax).days
          }
        }
      }
    }

    return yearStart
  }

  internal static let epoch = CalendarDate(
    definition: HebrewDate(
      year: HebrewDate.referenceYear,
      month: .tishrei,
      day: 1,
      hour: 0,
      part: 0
    )
  )

  private static func intervalFromStartOfYear(
    toStartOf month: HebrewMonth,
    leapYear: Bool,
    yearLength: HebrewYear.Length
  ) -> CalendarInterval<FloatMax> {
    if month == .tishrei {
      return (0 as FloatMax).days
    } else {
      let previousMonth = month.predecessor(leapYear: leapYear)
      return HebrewDate.intervalFromStartOfYear(
        toStartOf: previousMonth,
        leapYear: leapYear,
        yearLength: yearLength
      ) + FloatMax(previousMonth.numberOfDays(yearLength: yearLength, leapYear: leapYear)).days
    }
  }

  // MARK: - Initialization

  internal init(
    year: HebrewYear,
    month: HebrewMonth,
    day: HebrewDay,
    hour: HebrewHour,
    part: HebrewPart
  ) {
    var year = year
    var month = month
    var day = day

    month.correctForYear(leapYear: year.isLeapYear)
    day.correct(forMonth: &month, year: &year)

    self.year = year
    self.month = month
    self.day = day
    self.hour = hour
    self.part = part

    var interval = HebrewDate.intervalFromReferenceDate(toStartOf: year)

    interval += HebrewDate.intervalFromStartOfYear(
      toStartOf: month,
      leapYear: year.isLeapYear,
      yearLength: year.length
    )

    interval += FloatMax(day.numberAlreadyElapsed).days

    interval += FloatMax(hour.numberAlreadyElapsed).hours

    interval += part.numberAlreadyElapsed.hebrewParts

    self.intervalSinceReferenceDate = interval
  }

  // MARK: - Properties

  internal let year: HebrewYear
  internal let month: HebrewMonth
  internal let day: HebrewDay
  internal let hour: HebrewHour
  internal let part: HebrewPart

  // MARK: - DateDefinition

  internal static let identifier: StrictString = "עברי"
  internal static var referenceDate: CalendarDate {
    unreachable()  // Would be a cyclical definition.
  }

  internal var intervalSinceReferenceDate: CalendarInterval<FloatMax>

  internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
    self.intervalSinceReferenceDate = intervalSinceReferenceDate

    let approxYears = Int(intervalSinceReferenceDate ÷ HebrewYear.meanDuration)
    let guessYear = HebrewDate.referenceYear + approxYears
    let year = findLocalMinimum(
      near: guessYear
    ) { (year: HebrewYear) -> CalendarInterval<FloatMax> in
      let interval =
        intervalSinceReferenceDate
        − HebrewDate.intervalFromReferenceDate(toStartOf: year)
      if interval ≥ (0 as FloatMax).hebrewParts {
        return interval
      } else {
        return |interval| + HebrewYear.maximumDuration
      }
    }
    var remainder =
      intervalSinceReferenceDate
      − HebrewDate.intervalFromReferenceDate(toStartOf: year)

    var approxMonthsElapsed = Int(remainder ÷ HebrewMonth.meanDuration)
    approxMonthsElapsed.decrease(to: HebrewYear.numberOfMonths(leapYear: year.isLeapYear) − 1)
    let guessMonth = HebrewMonth(
      numberAlreadyElapsed: approxMonthsElapsed,
      leapYear: year.isLeapYear
    )
    let month = findLocalMinimum(
      near: HebrewMonthAndYear(month: guessMonth, year: year),
      within: HebrewMonthAndYear(
        month: .tishrei,
        year: year
      )...HebrewMonthAndYear(month: .elul, year: year),
      inFunction: { (month: HebrewMonthAndYear) -> CalendarInterval<FloatMax> in
        let result =
          remainder
          − HebrewDate.intervalFromStartOfYear(
            toStartOf: month.month,
            leapYear: month.year.isLeapYear,
            yearLength: month.year.length
          )
        if result.isNegative {
          return |result| + HebrewYear.maximumDuration
        } else {
          return result
        }
      }
    ).month  // @exempt(from: tests) False positive.
    remainder
      −= HebrewDate.intervalFromStartOfYear(
        toStartOf: month,
        leapYear: year.isLeapYear,
        yearLength: year.length
      )

    let day = HebrewDay(numberAlreadyElapsed: Int(remainder.inDays.rounded(.down)))
    remainder = remainder.mod((1 as FloatMax).days)

    let hour = HebrewHour(numberAlreadyElapsed: Int(remainder.inHours.rounded(.down)))
    remainder = remainder.mod((1 as FloatMax).hours)

    let part = HebrewPart(numberAlreadyElapsed: remainder.inHebrewParts)

    self.year = year
    self.month = month
    self.day = day
    self.hour = hour
    self.part = part
  }

  // MARK: - Decodable

  internal init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let year = try container.decode(HebrewYear.self)
    let month = try container.decode(HebrewMonth.self)
    let day = try container.decode(HebrewDay.self)
    let hour = try container.decode(HebrewHour.self)
    let part = try container.decode(HebrewPart.self)
    self = HebrewDate(year: year, month: month, day: day, hour: hour, part: part)
  }

  // MARK: - Encodable

  internal func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(year)
    try container.encode(month)
    try container.encode(day)
    try container.encode(hour)
    try container.encode(part)
  }

  // MARK: - MarkupPlaygroundDisplay

  public func playgroundDescriptionMarkup() -> SemanticMarkup {
    return UserFacing<SemanticMarkup, FormatLocalization>({ localization in
      let date = CalendarDate(definition: self)
      switch localization {
      case .englishUnitedKingdom:
        return SemanticMarkup(
          date.hebrewDateInBritishEnglish() + " at " + date.twentyFourHourTimeInEnglish()
        )
      case .englishUnitedStates, .englishCanada:
        return SemanticMarkup(
          date.hebrewDateInAmericanEnglish() + " at " + date.twelveHourTimeInEnglish()
        )
      case .deutschDeutschland:
        return SemanticMarkup(date.hebräischesDatumAufDeutsch() + " um " + date.uhrzeitAufDeutsch())
      case .françaisFrance:
        return date.dateHébraïqueEnFrançais(.sentenceMedial) + " à " + date.heureEnFrançais()
      case .ελληνικάΕλλάδα:
        if self.hour == 1 {
          return SemanticMarkup(date.εβραϊκήΗμερομηνίαΣεΕλληνικά() + " στη " + date.ώραΣεΕλληνικά())
        } else {
          return SemanticMarkup(
            date.εβραϊκήΗμερομηνίαΣεΕλληνικά() + " στις " + date.ώραΣεΕλληνικά()
          )
        }
      case .עברית־ישראל:
        return SemanticMarkup(date.תאריך־עברי־בעברית() + " ב־" + date.שעה־בעברית())
      }
    }).resolved()
  }
}
