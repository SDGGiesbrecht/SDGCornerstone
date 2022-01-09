/*
 InternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGLocalization
@testable import SDGCalendar

import XCTest

import SDGPersistenceTestUtilities
import SDGXCTestUtilities

class InternalTests: TestCase {

  func testDate() {
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
      let date = CalendarDate(gregorian: .august, 28, 8232)
      let datesDirectory = testSpecificationDirectory().appendingPathComponent("Date Formats")
      compare(
        String(date.gregorianischesDatumAufDeutsch(mitJahr: true, mitWochentag: true)),
        against: datesDirectory.appendingPathComponent("Deutsch.txt"),
        overwriteSpecificationInsteadOfFailing: false
      )
      compare(
        String(
          date.dateGrégorienneEnFrançais(.sentenceMedial, avecAn: true, avecJourDeSemaine: true)
            .html()
        ),
        against: datesDirectory.appendingPathComponent("Français.txt"),
        overwriteSpecificationInsteadOfFailing: false
      )
      compare(
        String(date.γρηγοριανήΗμερομηνίαΣεΕλληνικά(μεΧρόνο: true, μεΗμέραΤηςΕβδομάδας: true)),
        against: datesDirectory.appendingPathComponent("Ελληνικά.txt"),
        overwriteSpecificationInsteadOfFailing: false
      )
      compare(
        String(date.תאריך־גרגוריאני־בעברית(עם־שנה: true, עם־יום־שבוע: true)),
        against: datesDirectory.appendingPathComponent("עברית.txt"),
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testGregorianMonth() {
    var list = ""
    for month in GregorianMonth.january...GregorianMonth.december {
      for πτώση in [.ονομαστική, .αιτιατική, .γενική, .κλητική] as [ΓραμματικήΠτώση] {
        print(month.σεΕλληνικά(πτώση), to: &list)
      }
    }
    compare(
      list,
      against: testSpecificationDirectory().appendingPathComponent("Ελληνικά.txt"),
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testGregorianWeekdayDate() {
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
      XCTAssertEqual(
        CalendarDate(
          definition: GregorianWeekdayDate(
            week: 1,
            weekday: .tuesday,
            hour: 0,
            minute: 0,
            second: 0
          )
        ),
        CalendarDate(gregorian: .january, 16, 2001)
      )
    #endif
  }

  func testHebrewWeekdayDate() {
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
      XCTAssertEqual(
        CalendarDate(definition: HebrewWeekdayDate(week: 1, weekday: .thursday, hour: 0, part: 0)),
        CalendarDate(hebrew: .tishrei, 15, 5758)
      )
    #endif
  }

  func testHebrewYear() {
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
      InternalTests.testHebrewYear()
    #endif
  }
  static func testHebrewYear() {
    // Untracked

    #warning("Debugging...")
    let x = HebrewYear(5700)..<5800
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
    for year in HebrewYear(5700)..<5800 {

      /* assert because XCTAssert doesn’t print because the exception on the next line triggers first. */
      assert(
        HebrewDate.intervalFromReferenceDate(toStartOf: year)
          < HebrewDate.intervalFromReferenceDate(toStartOf: year + 1),
        "Years incorrectly share interval."
      )

      _ = year.length  // Throws exception if the year has an invalid length.
    }
    #endif
  }

  func testRelativeDate() {
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
      let date = CalendarDate.hebrewNow()
      XCTAssertEqual(CalendarDate(definition: date.converted(to: RelativeDate.self)), date)
    #endif
  }
}
