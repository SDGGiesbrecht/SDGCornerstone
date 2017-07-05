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

        XCTAssert(CalendarDate(hebrewYear: 5751, month: .iyar, day: 4, hour: 0, part: 0) == CalendarDate(gregorianYear: 1991, month: .april, day: 17, hour: 18, minute: 0, second: 0), "Date conversion failed.")
        XCTAssert(CalendarDate(hebrewYear: 5751, month: .iyar, day: 4, hour: 6, part: 0) == CalendarDate(gregorianYear: 1991, month: .april, day: 18, hour: 0, minute: 0, second: 0), "Date conversion failed.")

        XCTAssert(CalendarDate(hebrewYear: 5776, month: .tevet, day: 10, hour: 3, part: 0) == CalendarDate(gregorianYear: 2015, month: .december, day: 21, hour: 21, minute: 0, second: 0), "Date conversion failed.")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy‐MM‐dd hh:mm:ss +zzzz"
        XCTAssert(Date(CalendarDate(gregorianYear: 1991, month: .april, day: 18, hour: 0, minute: 0, second: 0)) == formatter.date(from: "1991‐04‐18 00:00:00 +0000"), "CalendarDate does not match Foundation.")

        let anotherFormatter = DateFormatter()
        anotherFormatter.dateFormat = "yyyy‐MM‐dd hh:mm:ss +zzzz"
        anotherFormatter.calendar = Calendar(identifier: Calendar.Identifier.hebrew)
        XCTAssert(Date(CalendarDate(hebrewYear: 5751, month: .iyar, day: 4, hour: 0, part: 0)) == anotherFormatter.date(from: "5751‐08‐03 18:00:00 +0000"), "Sundown (SDG) to midnight (Foundation) offset out of sync.")
        XCTAssert(Date(CalendarDate(hebrewYear: 5776, month: .tevet, day: 10, hour: 0, part: 0)) == anotherFormatter.date(from: "5776‐04‐9 18:00:00 +0000"), "Sundown (SDG) to midnight (Foundation) offset out of sync.")

        XCTAssert(CalendarDate(gregorianYear: 2015, month: .december, day: 23, hour: 0, minute: 0, second: 0).gregorianWeekday == .wednesday, "Weekday failure.")
        XCTAssert(CalendarDate(hebrewYear: 5776, month: .tevet, day: 11, hour: 0, part: 0).hebrewWeekday == .wednesday, "Weekday failure.")

        XCTAssert(GregorianMonth.january ≠ GregorianMonth.december, "Equality problem.")

        let referenceDate = CalendarDate(gregorianYear: 2001, month: .january, day: 1, hour: 0, minute: 0, second: 0)
        XCTAssert(referenceDate.gregorianMonth == .january)
        XCTAssert(referenceDate.gregorianDay == 1)
        XCTAssert(referenceDate.gregorianYear == 2001)
        XCTAssert(referenceDate.gregorianHour == 0)
        XCTAssert(referenceDate.gregorianMinute == 0)
        XCTAssert(referenceDate.gregorianSecond == 0)

        let anotherDate = CalendarDate(gregorianYear: 2015, month: .december, day: 31, hour: 0, minute: 0, second: 0)
        XCTAssert(anotherDate.gregorianMonth == .december)
        XCTAssert(anotherDate.gregorianDay == 31)
        XCTAssert(anotherDate.gregorianYear == 2015)
        XCTAssert(anotherDate.gregorianHour == 0)
        XCTAssert(anotherDate.gregorianMinute == 0)
        XCTAssert(anotherDate.gregorianSecond == 0)
    }

    static var allTests: [(String, (DateTests) -> () throws -> Void)] {
        return [
            ("testCalendarDate", testCalendarDate)
        ]
    }
}
