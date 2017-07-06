/*
 DateTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

class DateTests : TestCase {

    func testCalendarDate() {
        // Force these to take place first.
        InternalTests.testHebrewYear()

        XCTAssertEqual(CalendarDate(hebrewYear: 5751, month: .iyar, day: 4, hour: 0, part: 0), CalendarDate(gregorianYear: 1991, month: .april, day: 17, hour: 18, minute: 0, second: 0), "Date conversion failed.")
        XCTAssertEqual(CalendarDate(hebrewYear: 5751, month: .iyar, day: 4, hour: 6, part: 0), CalendarDate(gregorianYear: 1991, month: .april, day: 18, hour: 0, minute: 0, second: 0), "Date conversion failed.")

        XCTAssertEqual(CalendarDate(hebrewYear: 5776, month: .tevet, day: 10, hour: 3, part: 0), CalendarDate(gregorianYear: 2015, month: .december, day: 21, hour: 21, minute: 0, second: 0), "Date conversion failed.")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy‐MM‐dd hh:mm:ss +zzzz"
        XCTAssertEqual(Date(CalendarDate(gregorianYear: 1991, month: .april, day: 18, hour: 0, minute: 0, second: 0)), formatter.date(from: "1991‐04‐18 00:00:00 +0000"), "CalendarDate does not match Foundation.")

        XCTAssertEqual(CalendarDate(gregorianYear: 2015, month: .december, day: 23, hour: 0, minute: 0, second: 0).gregorianWeekday, .wednesday, "Weekday failure.")
        XCTAssertEqual(CalendarDate(hebrewYear: 5776, month: .tevet, day: 11, hour: 0, part: 0).hebrewWeekday, .wednesday, "Weekday failure.")

        XCTAssertNotEqual(GregorianMonth.january, GregorianMonth.december)

        let referenceDate = CalendarDate(gregorianYear: 2001, month: .january, day: 1, hour: 0, minute: 0, second: 0)
        XCTAssertEqual(referenceDate.gregorianMonth, .january)
        XCTAssertEqual(referenceDate.gregorianDay, 1)
        XCTAssertEqual(referenceDate.gregorianYear, 2001)
        XCTAssertEqual(referenceDate.gregorianHour, 0)
        XCTAssertEqual(referenceDate.gregorianMinute, 0)
        XCTAssertEqual(referenceDate.gregorianSecond, 0)

        let anotherDate = CalendarDate(gregorianYear: 2015, month: .december, day: 31, hour: 0, minute: 0, second: 0)
        XCTAssertEqual(anotherDate.gregorianMonth, .december)
        XCTAssertEqual(anotherDate.gregorianDay, 31)
        XCTAssertEqual(anotherDate.gregorianYear, 2015)
        XCTAssertEqual(anotherDate.gregorianHour, 0)
        XCTAssertEqual(anotherDate.gregorianMinute, 0)
        XCTAssertEqual(anotherDate.gregorianSecond, 0)

        XCTAssert(CalendarDate.hebrewNow() > CalendarDate(hebrewYear: 5777))
        XCTAssert(CalendarDate.gregorianNow() > CalendarDate(gregorianYear: 2017))

        let yetAnotherDate = CalendarDate(gregorianYear: 2017, month: .july, day: 5, hour: 18, minute: 0, second: 0)
        XCTAssertEqual(yetAnotherDate.hebrewYear, 5777)
        XCTAssertEqual(yetAnotherDate.hebrewMonth, .tammuz)
        XCTAssertEqual(yetAnotherDate.hebrewDay, 12)
        XCTAssertEqual(yetAnotherDate.hebrewHour, 0)
        XCTAssertEqual(yetAnotherDate.hebrewPart, 0)

        XCTAssertEqual(yetAnotherDate.dateInISOFormat(), "2017‐07‐05")
        XCTAssertEqual(yetAnotherDate.hebrewDateInBritishEnglish(withWeekday: true), "Thursday, 12 Tammuz 5777")
        XCTAssertEqual(yetAnotherDate.gregorianDateInBritishEnglish(withWeekday: true), "Wednesday, 5 July 2017")
        XCTAssertEqual(yetAnotherDate.hebrewDateInAmericanEnglish(withWeekday: true), "Thursday, Tammuz 12, 5777")
        XCTAssertEqual(yetAnotherDate.gregorianDateInAmericanEnglish(withWeekday: true), "Wednesday, July 5, 2017")
        XCTAssertEqual(yetAnotherDate.hebräischesDatumAufDeutsch(mitWochentag: true), "Donnerstag, 12. Tammus 5777")
        XCTAssertEqual(yetAnotherDate.gregorianischesDatumAufDeutsch(mitWochentag: true), "Mittwoch, 5. Juli 2017")
        XCTAssertEqual(yetAnotherDate.dateHébraïqueEnFrançais(.sentenceMedial, avecJourDeSemaine: true), "jeudi, le 12 tamouz 5777")
        XCTAssertEqual(yetAnotherDate.dateGrégorienneEnFrançais(.sentenceMedial, avecJourDeSemaine: true), "mercredi, le 5 juillet 2017")
        XCTAssertEqual(yetAnotherDate.εβραϊκήΗμερομηνίαΣεΕλληνικά(μεΗμέραΤηςΕβδομάδας: true), "Πέμπτη, 12 Θαμμούζ 5777")
        XCTAssertEqual(yetAnotherDate.γρηγοριανήΗμερομηνίαΣεΕλληνικά(μεΗμέραΤηςΕβδομάδας: true), "Τετάρτη, 5 Ιουλίου 2017")
        XCTAssertEqual(yetAnotherDate.תאריך־עברי־בעברית(עם־יום־שבוע: true), "יום חמישי, 12 בתמוז 5777")
        XCTAssertEqual(yetAnotherDate.תאריך־גרגוריאני־בעברית(עם־יום־שבוע: true), "יום רביעי, 5 ביולי 2017")

        let exception = CalendarDate(gregorianYear: 2017, month: .july, day: 1)
        XCTAssertEqual(exception.dateGrégorienneEnFrançais(.sentenceMedial), "le 1er juillet 2017")

        let time = CalendarDate(gregorianYear: 2017, month: .july, day: 6, hour: 2, minute: 5, second: 6)
        let time2 = CalendarDate(gregorianYear: 2017, month: .july, day: 6, hour: 23, minute: 55, second: 58)
        let time3 = CalendarDate(gregorianYear: 2017, month: .july, day: 6, hour: 0, minute: 0, second: 0)
        XCTAssertEqual(time.timeInISOFormat(includeSeconds: true), "02:05:06")
        XCTAssertEqual(time2.timeInISOFormat(includeSeconds: true), "23:55:58")
        XCTAssertEqual(time3.timeInISOFormat(includeSeconds: true), "00:00:00")

        XCTAssertEqual(time.twentyFourHourTimeInEnglish(), "2:05")
        XCTAssertEqual(time2.twentyFourHourTimeInEnglish(), "23:55")
        XCTAssertEqual(time3.twentyFourHourTimeInEnglish(), "0:00")

        XCTAssertEqual(time.twelveHourTimeInEnglish(), "2:05 a.m.")
        XCTAssertEqual(time2.twelveHourTimeInEnglish(), "11:55 p.m.")
        XCTAssertEqual(time3.twelveHourTimeInEnglish(), "12:00 a.m.")

        XCTAssertEqual(time.uhrzeitAufDeutsch(), "2.05")
        XCTAssertEqual(time2.uhrzeitAufDeutsch(), "23.55")
        XCTAssertEqual(time3.uhrzeitAufDeutsch(), "0.00")

        XCTAssertEqual(time.heureEnFrançais(), "2 h 05")
        XCTAssertEqual(time2.heureEnFrançais(), "23 h 55")
        XCTAssertEqual(time3.heureEnFrançais(), "0 h 00")

        XCTAssertEqual(time.ώραΣεΕλληνικά(), "2:05")
        XCTAssertEqual(time2.ώραΣεΕλληνικά(), "23:55")
        XCTAssertEqual(time3.ώραΣεΕλληνικά(), "0:00")

        XCTAssertEqual(time.שעה־בעברית(), "2:05")
        XCTAssertEqual(time2.שעה־בעברית(), "23:55")
        XCTAssertEqual(time3.שעה־בעברית(), "0:00")

        XCTAssertEqual(time.iCalendarFormat(), "20170706T020506Z")
        XCTAssertEqual(time2.iCalendarFormat(), "20170706T235558Z")
        XCTAssertEqual(time3.iCalendarFormat(), "20170706T000000Z")

        XCTAssertEqual(time.floatingICalendarFormat(), "20170706T020506")
        XCTAssertEqual(time2.floatingICalendarFormat(), "20170706T235558")
        XCTAssertEqual(time3.floatingICalendarFormat(), "20170706T000000")
    }

    func testGregorianSecond() {
        let second: GregorianSecond = 0.0
        XCTAssertEqual(second, 0)
    }

    static var allTests: [(String, (DateTests) -> () throws -> Void)] {
        return [
            ("testCalendarDate", testCalendarDate),
            ("testGregorianSecond", testGregorianSecond)
        ]
    }
}
