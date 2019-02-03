/*
 GregorianWeekdayDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

internal struct GregorianWeekdayDate : DateDefinition {

    // MARK: - Static Properties

    internal static let referenceMoment = CalendarDate(gregorian: .january, 7, 2001)
    private static let referenceWeekday: GregorianWeekday = .sunday

    // MARK: - Initialization

    internal init(week: Int, weekday: GregorianWeekday, hour: GregorianHour, minute: GregorianMinute, second: GregorianSecond) {

        self.week = week
        self.weekday = weekday
        self.hour = hour
        self.minute = minute
        self.second = second

        var interval: CalendarInterval<FloatMax> = FloatMax(week).weeks
        interval += FloatMax(weekday.numberAlreadyElapsed).days
        interval += FloatMax(hour.numberAlreadyElapsed).hours
        interval += FloatMax(minute.numberAlreadyElapsed).minutes
        interval += FloatMax(second.numberAlreadyElapsed).seconds
        intervalSinceReferenceDate = interval
    }

    // MARK: - Properties

    private let week: Int
    internal let weekday: GregorianWeekday
    private let hour: GregorianHour
    private let minute: GregorianMinute
    private let second: GregorianSecond

    // MARK: - DateDefinition

    internal static let identifier: StrictString = "settimana gregoriana"
    internal static let referenceDate: CalendarDate = referenceMoment

    internal var intervalSinceReferenceDate: CalendarInterval<FloatMax>

    internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate

        let date = GregorianWeekdayDate.referenceDate + intervalSinceReferenceDate
        hour = date.gregorianHour
        minute = date.gregorianMinute
        second = date.gregorianSecond

        let week = Int(intervalSinceReferenceDate.inWeeks.rounded(.down))
        self.week = week
        weekday = GregorianWeekday(numberAlreadyElapsed: Int((intervalSinceReferenceDate − FloatMax(week).weeks).inDays.rounded(.down)))
    }

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        unreachable() // This definition is only ever transiently created to determine the weekday of another date.
    }

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        unreachable() // This definition is only ever transiently created to determine the weekday of another date.
    }
}
