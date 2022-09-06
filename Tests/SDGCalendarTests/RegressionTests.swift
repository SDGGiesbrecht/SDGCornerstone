/*
 RegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCalendar

import XCTest

import SDGXCTestUtilities

class RegressionTests: TestCase {

  func testCacheInvalidation() {
    var a = CalendarDate(gregorianYear: 2000)
    XCTAssertEqual(a.hebrewYear, 5760)
    let b = a
    a −= CalendarInterval(days: 100000)
    XCTAssertEqual(a.hebrewYear, 5486)
    XCTAssertEqual(b.hebrewYear, 5760)
  }

  func testCalendarEquatability() {
    // Untracked

    let tishrei = HebrewMonthAndYear(month: .tishrei, year: 5759)
    XCTAssertEqual(tishrei, HebrewMonthAndYear(month: .tishrei, year: 5759))
    let tevet = HebrewMonthAndYear(month: .tevet, year: 5759)
    XCTAssertEqual(tevet, HebrewMonthAndYear(month: .tevet, year: 5759))
    XCTAssertNotEqual(tishrei, tevet)
  }

  func testWeekday() {
    // Untracked

    var date = CalendarDate(hebrew: .tishrei, 4, 5758)
    for _ in 0..<1000 {
      date += (1 as CalendarDate.Vector.Scalar).weeks
      XCTAssertEqual(date.hebrewWeekday, .sunday)
    }
  }
}
