/*
 InternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

@testable import SDGCornerstone

class InternalTests : TestCase {

    func testGregorianWeekdayDate() {
        XCTAssertEqual(CalendarDate(definition: GregorianWeekdayDate(week: 1, weekday: .tuesday, hour: 0, minute: 0, second: 0)), CalendarDate(gregorian: .january, 16, 2001))
    }

    func testHebrewWeekdayDate() {
        XCTAssertEqual(CalendarDate(definition: HebrewWeekdayDate(week: 1, weekday: .thursday, hour: 0, part: 0)), CalendarDate(hebrew: .tishrei, 15, 5758))
    }

    func testHebrewYear() {
        InternalTests.testHebrewYear()
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

    func testLocalizationSetting() {
        XCTAssertNotNil(LocalizationSetting.osSystemWidePreferences.value?.asArray(of: String.self), "Failed to detect operating system localization setting.")

        LocalizationSetting.internalUseSetSystemWidePreferences(to: nil)
        LocalizationSetting.setApplicationPreferences(to: nil)

        LocalizationSetting.internalUseSetSystemWidePreferences(to: LocalizationSetting(orderOfPrecedence: ["en"]))
        XCTAssertEqual(LocalizationSetting.current.value.resolved() as LocalizationExample, .englishUnitedKingdom)
        LocalizationSetting.internalUseSetSystemWidePreferences(to: LocalizationSetting(orderOfPrecedence: ["fr"]))
        XCTAssertEqual(LocalizationSetting.current.value.resolved() as LocalizationExample, .français)

        LocalizationSetting.internalUseSetSystemWidePreferences(to: nil)
    }

    func testUIntHalvesView() {
        XCTAssertEqual((0 as UInt).halves.index(before: 1), 0)
    }

    func testWholeNumberBinaryView() {
        XCTAssertEqual((WholeNumber.BinaryView.Index(digit: 1, bit: 0) − WholeNumber.BinaryView.Index(digit: 0, bit: 63)).digitDistance, 0)

        var index = WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 0)
        index += 1
        XCTAssertEqual(index, WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 1))

        index += WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: BinaryView<WholeNumber.Digit>.count − 1)
        XCTAssertEqual(index, WholeNumber.BinaryView.IndexDistance(digitDistance: 1, bitDistance: 0))

        index −= WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 1)
        XCTAssertEqual(index.digitDistance, 0)

        XCTAssertEqual(WholeNumber.BinaryView(0).endIndex, WholeNumber.BinaryView.Index(digit: 0, bit: 0))

        XCTAssert(WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 0).hashValue ≤ Int.max)
    }

    static var allTests: [(String, (InternalTests) -> () throws -> Void)] {
        return [
            ("testGregorianWeekdayDate", testGregorianWeekdayDate),
            ("testHebrewWeekdayDate", testHebrewWeekdayDate),
            ("testHebrewYear", testHebrewYear),
            ("testLocalizationSetting", testLocalizationSetting),
            ("testRelativeDate", testRelativeDate),
            ("testUIntHalvesView", testUIntHalvesView),
            ("testWholeNumberBinaryView", testWholeNumberBinaryView)
        ]
    }
}
