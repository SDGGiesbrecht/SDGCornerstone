/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCalendar

import SDGCornerstoneLocalizations

import XCTest

import SDGMathematicsTestUtilities
import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class APITests: TestCase {

  func testCalendarComponent() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      XCTAssertEqual(GregorianDay.meanDuration, GregorianDay.maximumDuration)
      XCTAssertEqual(GregorianDay.minimumDuration, GregorianDay.maximumDuration)

      XCTAssertEqual(GregorianMinute(ordinal: 5), GregorianMinute(numberAlreadyElapsed: 4))
      XCTAssertEqual(GregorianMinute(ordinal: 4).ordinal, 4)

      XCTAssertEqual(GregorianMonth(ordinal: 2), .february)

      XCTAssertEqual(GregorianDay(ordinal: 8), 8)

      XCTAssertEqual(GregorianHour.duration, (1 as FloatMax).hours)
      XCTAssertEqual(GregorianMinute.duration, (1 as FloatMax).minutes)
      XCTAssertEqual(GregorianSecond.duration, (1 as FloatMax).seconds)
      XCTAssertEqual(GregorianWeekday.duration, (1 as FloatMax).days)
      XCTAssertEqual(HebrewDay.duration, (1 as FloatMax).days)
      XCTAssertEqual(HebrewHour.duration, (1 as FloatMax).hours)
      XCTAssertEqual(HebrewPart.duration, (1 as FloatMax).hebrewParts)
      XCTAssertEqual(HebrewWeekday.duration, (1 as FloatMax).days)

      XCTAssertEqual(GregorianDay(10) − GregorianDay(4), 6)
      XCTAssertEqual(GregorianMonth.february − GregorianMonth.january, 1)

      var day = GregorianWeekday.monday
      day.decrement()
      XCTAssertEqual(day, .sunday)
    #endif
  }

  func testCalendarDate() throws {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      // Force these to take place first.
      InternalTests.testHebrewYear()

      XCTAssertEqual(
        CalendarDate(hebrew: .iyar, 4, 5751),
        CalendarDate(gregorian: .april, 17, 1991, at: 18),
        "Date conversion failed."
      )
      XCTAssertEqual(
        CalendarDate(hebrew: .iyar, 4, 5751, at: 6),
        CalendarDate(gregorian: .april, 18, 1991),
        "Date conversion failed."
      )

      XCTAssertEqual(
        CalendarDate(hebrew: .tevet, 10, 5776, at: 3),
        CalendarDate(gregorian: .december, 21, 2015, at: 21),
        "Date conversion failed."
      )

      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy‐MM‐dd hh:mm:ss Z"
      let system = formatter.date(from: "1991‐04‐18 00:00:00 +0000")!
      XCTAssert(
        Date(CalendarDate(gregorian: .april, 18, 1991)).timeIntervalSinceReferenceDate
          ≈ system.timeIntervalSinceReferenceDate,
        "CalendarDate does not match Foundation."
      )

      XCTAssertEqual(
        CalendarDate(gregorian: .december, 23, 2015).gregorianWeekday,
        .wednesday,
        "Weekday failure."
      )
      XCTAssertEqual(
        CalendarDate(hebrew: .tevet, 11, 5776).hebrewWeekday,
        .wednesday,
        "Weekday failure."
      )

      XCTAssertNotEqual(GregorianMonth.january, GregorianMonth.december)

      let referenceDate = CalendarDate(gregorian: .january, 1, 2001)
      XCTAssertEqual(referenceDate.gregorianMonth, .january)
      XCTAssertEqual(referenceDate.gregorianDay, 1)
      XCTAssertEqual(referenceDate.gregorianYear, 2001)
      XCTAssertEqual(referenceDate.gregorianHour, 0)
      XCTAssertEqual(referenceDate.gregorianMinute, 0)
      XCTAssertEqual(referenceDate.gregorianSecond, 0)

      let anotherDate = CalendarDate(gregorian: .december, 31, 2015)
      XCTAssertEqual(anotherDate.gregorianMonth, .december)
      XCTAssertEqual(anotherDate.gregorianDay, 31)
      XCTAssertEqual(anotherDate.gregorianYear, 2015)
      XCTAssertEqual(anotherDate.gregorianHour, 0)
      XCTAssertEqual(anotherDate.gregorianMinute, 0)
      XCTAssertEqual(anotherDate.gregorianSecond, 0)

      XCTAssert(CalendarDate.hebrewNow() > CalendarDate(hebrew: .tishrei, 1, 5777))
      XCTAssert(CalendarDate.gregorianNow() > CalendarDate(gregorian: .january, 1, 2017))

      let yetAnotherDate = CalendarDate(gregorian: .july, 5, 2017, at: 18)
      XCTAssertEqual(yetAnotherDate.hebrewYear, 5777)
      XCTAssertEqual(yetAnotherDate.hebrewMonth, .tammuz)
      XCTAssertEqual(yetAnotherDate.hebrewDay, 12)
      XCTAssertEqual(yetAnotherDate.hebrewHour, 0)
      XCTAssertEqual(yetAnotherDate.hebrewPart, 0)

      XCTAssertEqual(yetAnotherDate.dateInISOFormat(), "2017‐07‐05")
      XCTAssertEqual(
        yetAnotherDate.hebrewDateInBritishEnglish(withWeekday: true),
        "Thursday, 12 Tammuz 5777"
      )
      XCTAssertEqual(
        yetAnotherDate.gregorianDateInBritishEnglish(withWeekday: true),
        "Wednesday, 5 July 2017"
      )
      XCTAssertEqual(
        yetAnotherDate.hebrewDateInAmericanEnglish(withWeekday: true),
        "Thursday, Tammuz 12, 5777"
      )
      XCTAssertEqual(
        yetAnotherDate.gregorianDateInAmericanEnglish(withWeekday: true),
        "Wednesday, July 5, 2017"
      )

      let time = CalendarDate(gregorian: .july, 6, 2017, at: 2, 05, 06)
      let time2 = CalendarDate(gregorian: .july, 6, 2017, at: 23, 55, 58)
      let time3 = CalendarDate(gregorian: .july, 6, 2017, at: 0, 00, 00)
      XCTAssertEqual(time.timeInISOFormat(includeSeconds: true), "02:05:06")
      XCTAssertEqual(time2.timeInISOFormat(includeSeconds: true), "23:55:58")
      XCTAssertEqual(time3.timeInISOFormat(includeSeconds: true), "00:00:00")

      XCTAssertEqual(time.twentyFourHourTimeInEnglish(), "2:05")
      XCTAssertEqual(time2.twentyFourHourTimeInEnglish(), "23:55")
      XCTAssertEqual(time3.twentyFourHourTimeInEnglish(), "0:00")

      XCTAssertEqual(time.twelveHourTimeInEnglish(), "2:05 a.m.")
      XCTAssertEqual(time2.twelveHourTimeInEnglish(), "11:55 p.m.")
      XCTAssertEqual(time3.twelveHourTimeInEnglish(), "12:00 a.m.")

      XCTAssertEqual(time.iCalendarFormat(), "20170706T020506Z")
      XCTAssertEqual(time2.iCalendarFormat(), "20170706T235558Z")
      XCTAssertEqual(time3.iCalendarFormat(), "20170706T000000Z")

      XCTAssertEqual(time.floatingICalendarFormat(), "20170706T020506")
      XCTAssertEqual(time2.floatingICalendarFormat(), "20170706T235558")
      XCTAssertEqual(time3.floatingICalendarFormat(), "20170706T000000")

      let hebrew = CalendarDate(hebrew: HebrewMonth.tishrei, 23, 3456, at: 7, part: 890)
      testCodableConformance(of: hebrew, uniqueTestName: "Hebrew")
      testCodableConformance(
        of: CalendarDate(gregorian: .january, 23, 3456, at: 7, 8, 9),
        uniqueTestName: "Gregorian"
      )
      testCodableConformance(
        of: CalendarDate(Date(timeIntervalSinceReferenceDate: 123_456_789)),
        uniqueTestName: "Foundation"
      )
      testCodableConformance(of: hebrew + (12345 as FloatMax).days, uniqueTestName: "Relative")
      // For unregistered definitions, see DocumentationExampleTests.DateExampleTests.

      struct Mock: Encodable {
        let key = "gregoriano"
        let container = "[]"
        let other: [Int64] = [138_059_393_067, 259_200]
        func encode(to encoder: Encoder) throws {
          var container = encoder.unkeyedContainer()
          try container.encode(key)
          try container.encode(self.container)
          try container.encode(other)
        }
      }
      testDecoding(CalendarDate.self, failsFor: Mock())  // Empty container array.

      for n in 1...12 {
        let date = CalendarDate(
          gregorian: GregorianMonth(ordinal: n),
          GregorianDay(n),
          2000 + n,
          at: GregorianHour(n),
          GregorianMinute(n),
          GregorianSecond(FloatMax(n))
        )
        testCustomStringConvertibleConformance(
          of: date,
          localizations: FormatLocalization.self,
          uniqueTestName: "Gregorian (" + date.dateInISOFormat() + ")",
          overwriteSpecificationInsteadOfFailing: false
        )
      }
      let bc = CalendarDate(gregorian: .january, 1, GregorianYear(−2000))
      testCustomStringConvertibleConformance(
        of: bc,
        localizations: FormatLocalization.self,
        uniqueTestName: "Gregorian (" + bc.dateInISOFormat() + ")",
        overwriteSpecificationInsteadOfFailing: false
      )
      for n in 1...12 {
        let date = CalendarDate(
          hebrew: HebrewMonth(ordinal: n, leapYear: false),
          HebrewDay(n),
          5700 + n,
          at: HebrewHour(n),
          part: HebrewPart(FloatMax(n))
        )
        testCustomStringConvertibleConformance(
          of: date,
          localizations: FormatLocalization.self,
          uniqueTestName: "Hebrew (" + date.dateInISOFormat() + ")",
          overwriteSpecificationInsteadOfFailing: false
        )
      }
      for n in 21...22 {
        let adar = CalendarDate(hebrew: .adarI, 1, 5700 + n)
        testCustomStringConvertibleConformance(
          of: adar,
          localizations: FormatLocalization.self,
          uniqueTestName: "Hebrew (" + adar.dateInISOFormat() + ")",
          overwriteSpecificationInsteadOfFailing: false
        )
      }
      let relative = CalendarDate(gregorian: .january, 1, 2001) + (100 as FloatMax).days
      testCustomStringConvertibleConformance(
        of: relative,
        localizations: FormatLocalization.self,
        uniqueTestName: "Relative (" + relative.dateInISOFormat() + ")",
        overwriteSpecificationInsteadOfFailing: false
      )

      _ = "\(CalendarDate(Date()))"

      let utc = CalendarDate(gregorian: .september, 20, 2019, at: 21, 31)
      let adjustedToZone = utc.adjusted(to: TimeZone(identifier: "Asia/Jerusalem")!)
      let timeZoneEquivalent = CalendarDate(gregorian: .september, 21, 2019, at: 0, 31)
      XCTAssertEqual(
        adjustedToZone.gregorianDateInAmericanEnglish(),
        timeZoneEquivalent.gregorianDateInAmericanEnglish()
      )
      XCTAssertEqual(
        adjustedToZone.twentyFourHourTimeInEnglish(),
        timeZoneEquivalent.twentyFourHourTimeInEnglish()
      )
      XCTAssertEqual(
        adjustedToZone.hebrewDateInAmericanEnglish(),
        timeZoneEquivalent.hebrewDateInAmericanEnglish()
      )
      XCTAssertEqual(
        adjustedToZone.gregorianSecond,
        timeZoneEquivalent.gregorianSecond
      )
      XCTAssertEqual(
        adjustedToZone.hebrewHour,
        timeZoneEquivalent.hebrewHour
      )
      XCTAssertEqual(
        adjustedToZone.hebrewPart,
        timeZoneEquivalent.hebrewPart
      )
      _ = adjustedToZone.description
      _ = adjustedToZone.debugDescription
      _ = adjustedToZone.playgroundDescription
      let longitude: Angle<Double> = 90°
      let adjustedToLongitude = utc.adjustedToMeanSolarTime(atLongitude: longitude)
      let longitudeEquivalent = CalendarDate(gregorian: .september, 21, 2019, at: 3, 31)
      XCTAssertEqual(
        adjustedToLongitude.gregorianDateInAmericanEnglish(),
        longitudeEquivalent.gregorianDateInAmericanEnglish()
      )
      XCTAssertEqual(
        adjustedToLongitude.twentyFourHourTimeInEnglish(),
        longitudeEquivalent.twentyFourHourTimeInEnglish()
      )
    #endif
  }

  func testCalendarInterval() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testMeasurementConformance(of: CalendarInterval<FloatMax>.self)
      testCustomStringConvertibleConformance(
        of: 1.days,
        localizations: FormatLocalization.self,
        uniqueTestName: "1 Day",
        overwriteSpecificationInsteadOfFailing: false
      )
      testCustomStringConvertibleConformance(
        of: 2.days,
        localizations: FormatLocalization.self,
        uniqueTestName: "2 Days",
        overwriteSpecificationInsteadOfFailing: false
      )

      XCTAssert((365.days × 400).inGregorianLeapYearCycles < 1)
      XCTAssert(28.days.inHebrewMoons < 1)
    #endif
  }

  func testGregorianDay() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: GregorianDay(12), uniqueTestName: "12")
      testCustomStringConvertibleConformance(
        of: GregorianDay(4),
        localizations: FormatLocalization.self,
        uniqueTestName: "4",
        overwriteSpecificationInsteadOfFailing: false
      )

      var day: GregorianDay = 29
      var month: GregorianMonth = .february
      day.correct(forMonth: &month, year: 2017)
      XCTAssertEqual(day, 1)
      XCTAssertEqual(month, .march)

      day = 31
      month = .november
      day.correct(forMonth: &month, year: 2017)
      XCTAssertEqual(day, 1)
      XCTAssertEqual(month, .december)
    #endif
  }

  func testGregorianHour() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: GregorianHour(12), uniqueTestName: "12")
      testDecoding(GregorianHour.self, failsFor: 600)  // Invalid raw value.
      testCustomStringConvertibleConformance(
        of: GregorianHour(6),
        localizations: FormatLocalization.self,
        uniqueTestName: "6",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testGregorianMinute() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: GregorianMinute(12), uniqueTestName: "12")
      testCustomStringConvertibleConformance(
        of: GregorianMinute(14),
        localizations: FormatLocalization.self,
        uniqueTestName: "14",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testGregorianMonth() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: GregorianMonth.january, uniqueTestName: "January")
      testDecoding(GregorianMonth.self, failsFor: 120)  // Invalid raw value.
      testCustomStringConvertibleConformance(
        of: GregorianMonth.august,
        localizations: FormatLocalization.self,
        uniqueTestName: "August",
        overwriteSpecificationInsteadOfFailing: false
      )

      let length = FloatMax(GregorianMonth.january.numberOfDays(leapYear: false))
        × (1 as FloatMax).days
      XCTAssert(length ≥ GregorianMonth.minimumDuration)
      XCTAssert(length ≤ GregorianMonth.maximumDuration)

      for month in GregorianMonth.january...GregorianMonth.december {
        XCTAssertNotEqual(month.inEnglish(), "")

        if month == .january {
          XCTAssertEqual(month.inEnglish(), "January")
        }
      }

      XCTAssertNil(HebrewMonth.adarII.numberAlreadyElapsed(leapYear: false))
      XCTAssertEqual(HebrewMonth.tishrei.ordinal(leapYear: false), 1)
      XCTAssertNil(HebrewMonth.adarII.ordinal(leapYear: false))
      XCTAssertEqual(HebrewMonth.adar.ordinal(leapYear: false), 6)
      XCTAssertEqual(HebrewMonth.elul.ordinal(leapYear: false), 12)
      XCTAssertEqual(HebrewMonth.tishrei.ordinal(leapYear: true), 1)
      XCTAssertNil(HebrewMonth.adar.ordinal(leapYear: true))
      XCTAssertEqual(HebrewMonth.adarI.ordinal(leapYear: true), 6)
      XCTAssertEqual(HebrewMonth.adarII.ordinal(leapYear: true), 7)
      XCTAssertEqual(HebrewMonth.elul.ordinal(leapYear: true), 13)
    #endif
  }

  func testGregorianSecond() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: GregorianSecond(12), uniqueTestName: "12")
      testCustomStringConvertibleConformance(
        of: GregorianSecond(12),
        localizations: FormatLocalization.self,
        uniqueTestName: "12",
        overwriteSpecificationInsteadOfFailing: false
      )

      let second: GregorianSecond = 0.0
      XCTAssertEqual(second, 0)

      XCTAssertEqual(GregorianSecond(0).inDigits(), "00")
    #endif
  }

  func testGregorianWeekday() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: GregorianWeekday.sunday, uniqueTestName: "Sunday")
      for ordinal in 1...7 {
        testCustomStringConvertibleConformance(
          of: GregorianWeekday(ordinal: ordinal),
          localizations: FormatLocalization.self,
          uniqueTestName: ordinal.inDigits(),
          overwriteSpecificationInsteadOfFailing: false
        )
      }
    #endif
  }

  func testGregorianYear() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: GregorianYear(1234), uniqueTestName: "1234")
      testCustomStringConvertibleConformance(
        of: GregorianYear(1870),
        localizations: FormatLocalization.self,
        uniqueTestName: "1870",
        overwriteSpecificationInsteadOfFailing: false
      )

      let length = FloatMax(GregorianYear(2017).numberOfDays) × (1 as FloatMax).days
      XCTAssert(length ≥ GregorianYear.minimumDuration)
      XCTAssert(length ≤ GregorianYear.maximumDuration)

      XCTAssertEqual(GregorianYear(ordinal: 1), 1)
      XCTAssertEqual(GregorianYear(2017).numberAlreadyElapsed, 2016)

      XCTAssertEqual(GregorianYear(1).inISOFormat(), "0001")
      XCTAssertEqual(GregorianYear(−1).inISOFormat(), "0000")
      XCTAssertEqual(GregorianYear(−2).inISOFormat(), "−0001")

      XCTAssertEqual(GregorianYear(−1) + 1, GregorianYear(1))
      XCTAssertEqual(GregorianYear(1) − 1, GregorianYear(−1))
      XCTAssertEqual(GregorianYear(−1) − GregorianYear(1), −1)

      XCTAssertEqual(GregorianYear(−1000).inEnglishDigits(), "1000 BC")

      XCTAssertEqual(GregorianYear(numberAlreadyElapsed: 0), 1)
      XCTAssertEqual(GregorianYear(2017).ordinal, 2017)
    #endif
  }

  func testHebrewDay() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: HebrewDay(12), uniqueTestName: "12")

      var day: HebrewDay = 30
      var month: HebrewMonth = .adar
      var year: HebrewYear = 5774
      day.correct(forMonth: &month, year: &year)
      XCTAssertEqual(day, 1)
      XCTAssertEqual(month, .nisan)

      day = 30
      month = .elul
      year = 5777
      day.correct(forMonth: &month, year: &year)
      XCTAssertEqual(day, 1)
      XCTAssertEqual(month, .tishrei)
      XCTAssertEqual(year, 5778)

      XCTAssertEqual(HebrewMonth.nisan.numberAlreadyElapsed(leapYear: true), 7)
      XCTAssertEqual(HebrewMonth.nisan.ordinal(leapYear: false), 7)
      XCTAssertEqual(HebrewMonth.nisan.ordinal(leapYear: true), 8)
    #endif
  }

  func testHebrewHour() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: HebrewHour(12), uniqueTestName: "12")
      testCustomStringConvertibleConformance(
        of: HebrewHour(3),
        localizations: FormatLocalization.self,
        uniqueTestName: "3",
        overwriteSpecificationInsteadOfFailing: false
      )

      XCTAssertEqual(HebrewHour(5).inDigits(), "5")
    #endif
  }

  func testHebrewMonth() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: HebrewMonth.tishrei, uniqueTestName: "Tishrei")
      testCodableConformance(of: HebrewMonth.adar, uniqueTestName: "Adar")
      testCodableConformance(of: HebrewMonth.adarI, uniqueTestName: "Adar I")
      testCodableConformance(of: HebrewMonth.adarII, uniqueTestName: "Adar II")
      testCodableConformance(of: HebrewMonth.elul, uniqueTestName: "Elul")
      for ordinal in 1...12 {
        let month = HebrewMonth(ordinal: ordinal, leapYear: false)
        testCustomStringConvertibleConformance(
          of: month,
          localizations: FormatLocalization.self,
          uniqueTestName: ordinal.inDigits(),
          overwriteSpecificationInsteadOfFailing: false
        )
      }
      testCustomStringConvertibleConformance(
        of: HebrewMonth.adarI,
        localizations: FormatLocalization.self,
        uniqueTestName: "Adar I",
        overwriteSpecificationInsteadOfFailing: false
      )
      testCustomStringConvertibleConformance(
        of: HebrewMonth.adarII,
        localizations: FormatLocalization.self,
        uniqueTestName: "Adar II",
        overwriteSpecificationInsteadOfFailing: false
      )

      let length = FloatMax(HebrewMonth.tishrei.numberOfDays(yearLength: .normal, leapYear: false))
        × (1 as FloatMax).days
      XCTAssert(length ≥ HebrewMonth.minimumDuration)
      XCTAssert(length ≤ HebrewMonth.maximumDuration)

      var month: HebrewMonth = .adar
      month.increment(leapYear: false)
      XCTAssertEqual(month, .nisan)
      month.decrement(leapYear: false)
      XCTAssertEqual(month, .adar)

      XCTAssertEqual(HebrewMonth.tishrei.cyclicPredecessor(leapYear: false, {}), .elul)

      month = .adar
      month.correctForYear(leapYear: true)
      XCTAssertEqual(month, .adarII)

      month = .adarII
      month.correctForYear(leapYear: false)
      XCTAssertEqual(month, .adar)

      for month in sequence(first: HebrewMonth.tishrei, next: { $0.successor() }) {
        XCTAssertNotEqual(month.inEnglish(), "")

        if month == .tishrei {
          XCTAssertEqual(month.inEnglish(), "Tishrei")
        } else if month == .adarII {
          XCTAssertEqual(month.inEnglish(), "Adar II")
        }
      }

      XCTAssertEqual(HebrewMonthAndYear(month: .elul, year: 5777).successor().month, .tishrei)
      XCTAssertEqual(HebrewMonthAndYear(month: .tishrei, year: 5777).predecessor().month, .elul)
      XCTAssertEqual(
        HebrewMonthAndYear(month: .tishrei, year: 5778)
          − HebrewMonthAndYear(month: .elul, year: 5777),
        1
      )
      XCTAssertEqual(
        HebrewMonthAndYear(month: .nisan, year: 5777)
          − HebrewMonthAndYear(month: .sivan, year: 5777),
        −2
      )
    #endif
  }

  func testHebrewMonthAndYear() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(
        of: HebrewMonthAndYear(month: .tishrei, year: 2345),
        uniqueTestName: "Tishrei, 2345"
      )
      testCustomStringConvertibleConformance(
        of: HebrewMonthAndYear(month: .nisan, year: 4460),
        localizations: FormatLocalization.self,
        uniqueTestName: "Nisan, 4460",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testHebrewPart() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: HebrewPart(124), uniqueTestName: "124")
      testCustomStringConvertibleConformance(
        of: HebrewPart(82),
        localizations: FormatLocalization.self,
        uniqueTestName: "82",
        overwriteSpecificationInsteadOfFailing: false
      )

      XCTAssertEqual(HebrewPart(102).inDigits(), "102")
    #endif
  }

  func testHebrewWeekday() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: HebrewWeekday.sunday, uniqueTestName: "Sunday")
    #endif
  }

  func testHebrewYear() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testCodableConformance(of: HebrewYear(1234), uniqueTestName: "1234")

      let length = FloatMax(HebrewYear(5777).numberOfDays) × (1 as FloatMax).days
      XCTAssert(length ≥ HebrewYear.minimumDuration)
      XCTAssert(length ≤ HebrewYear.maximumDuration)
    #endif
  }

  func testWeekday() {
    for weekday in GregorianWeekday.sunday...GregorianWeekday.saturday {
      XCTAssertNotEqual(weekday.inEnglish(), "")

      if weekday == .sunday {
        XCTAssertEqual(weekday.inEnglish(), "Sunday")
      }
    }
  }
}
