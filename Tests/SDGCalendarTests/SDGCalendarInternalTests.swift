/*
 SDGCalendarInternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGCalendar

import SDGXCTestUtilities

class SDGCalendarInternalTests : TestCase {

    func testGregorianWeekdayDate() {
        XCTAssertEqual(CalendarDate(definition: GregorianWeekdayDate(week: 1, weekday: .tuesday, hour: 0, minute: 0, second: 0)), CalendarDate(gregorian: .january, 16, 2001))
    }

    func testHebrewWeekdayDate() {
        XCTAssertEqual(CalendarDate(definition: HebrewWeekdayDate(week: 1, weekday: .thursday, hour: 0, part: 0)), CalendarDate(hebrew: .tishrei, 15, 5758))
    }

    func testHebrewYear() {
        SDGCalendarInternalTests.testHebrewYear()
    }
    static func testHebrewYear() {
        // Untracked

        for year in HebrewYear(5700)..<5800 {

            /* assert because XCTAssert doesn’t print because the exception on the next line triggers first. */
            assert(HebrewDate.intervalFromReferenceDate(toStartOf: year) < HebrewDate.intervalFromReferenceDate(toStartOf: year + 1), "Years incorrectly share interval.")

            _ = year.length // Throws exception if the year has an invalid length.
        }
    }

    func testRelativeDate() {
        let date = CalendarDate.hebrewNow()
        XCTAssertEqual(CalendarDate(definition: date.converted(to: RelativeDate.self)), date)
    }
}
