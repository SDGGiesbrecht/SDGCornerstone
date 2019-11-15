/*
 XCTestManifests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !canImport(ObjectiveC)
import XCTest

extension SDGCalendarAPITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGCalendarAPITests = [
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
        ("testWeekday", testWeekday),
    ]
}

extension SDGCalendarInternalTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGCalendarInternalTests = [
        ("testDate", testDate),
        ("testGregorianMonth", testGregorianMonth),
        ("testGregorianWeekdayDate", testGregorianWeekdayDate),
        ("testHebrewWeekdayDate", testHebrewWeekdayDate),
        ("testHebrewYear", testHebrewYear),
        ("testRelativeDate", testRelativeDate),
    ]
}

extension SDGCalendarRegressionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGCalendarRegressionTests = [
        ("testCalendarEquatability", testCalendarEquatability),
        ("testWeekday", testWeekday),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGCalendarAPITests.__allTests__SDGCalendarAPITests),
        testCase(SDGCalendarInternalTests.__allTests__SDGCalendarInternalTests),
        testCase(SDGCalendarRegressionTests.__allTests__SDGCalendarRegressionTests),
    ]
}
#endif
