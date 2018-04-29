/*
 XCTestManifests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

extension SDGCalendarAPITests {
    static let __allTests = [
        ("testCalendarComponent", testCalendarComponent),
        ("testCalendarDate", testCalendarDate),
        ("testCalendarInterval", testCalendarInterval),
        ("testGregorianDay", testGregorianDay),
        ("testGregorianHour", testGregorianHour),
        ("testGregorianMinute", testGregorianMinute),
        ("testGregorianMonth", testGregorianMonth),
        ("testGregorianSecond", testGregorianSecond),
        ("testGregorianWeekday", testGregorianWeekday),
        ("testGregorianYear", testGregorianYear),
        ("testHebrewDay", testHebrewDay),
        ("testHebrewHour", testHebrewHour),
        ("testHebrewMonth", testHebrewMonth),
        ("testHebrewMonthAndYear", testHebrewMonthAndYear),
        ("testHebrewPart", testHebrewPart),
        ("testHebrewWeekday", testHebrewWeekday),
        ("testHebrewYear", testHebrewYear),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testWeekday", testWeekday),
    ]
}

extension SDGCalendarInternalTests {
    static let __allTests = [
        ("testGregorianWeekdayDate", testGregorianWeekdayDate),
        ("testHebrewWeekdayDate", testHebrewWeekdayDate),
        ("testHebrewYear", testHebrewYear),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testRelativeDate", testRelativeDate),
    ]
}

extension SDGCalendarRegressionTests {
    static let __allTests = [
        ("testCalendarEquatability", testCalendarEquatability),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testWeekday", testWeekday),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGCalendarAPITests.__allTests),
        testCase(SDGCalendarInternalTests.__allTests),
        testCase(SDGCalendarRegressionTests.__allTests),
    ]
}
#endif
