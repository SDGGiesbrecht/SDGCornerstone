/*
 HebrewWeekdayDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

internal struct HebrewWeekdayDate : DateDefinition {

    // MARK: - Static Properties

    internal static let referenceMoment = CalendarDate(hebrew: .tishrei, 4, 5758)
    private static let referenceWeekday: HebrewWeekday = .sunday

    // MARK: - Properties

    private let week: Int
    internal let weekday: HebrewWeekday
    private let hour: HebrewHour
    private let part: HebrewPart

    // MARK: - Initialization

    internal init(week: Int, weekday: HebrewWeekday, hour: HebrewHour, part: HebrewPart) {

        self.week = week
        self.weekday = weekday
        self.hour = hour
        self.part = part

        var interval: CalendarInterval<FloatMax> = FloatMax(week).weeks
        interval += FloatMax(weekday.numberAlreadyElapsed).days
        interval += FloatMax(hour.numberAlreadyElapsed).hours
        interval += FloatMax(part.numberAlreadyElapsed).hebrewParts
        intervalSinceReferenceDate = interval
    }

    // MARK: - DateDefinition

    internal static let identifier: StrictString = "שבוע עברי"
    internal static let referenceDate: CalendarDate = referenceMoment

    internal var intervalSinceReferenceDate: CalendarInterval<FloatMax>

    internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate

        let date = HebrewWeekdayDate.referenceDate + intervalSinceReferenceDate
        hour = date.hebrewHour
        part = date.hebrewPart

        let week = Int(intervalSinceReferenceDate.inWeeks.rounded(.down))
        self.week = week
        weekday = HebrewWeekday(numberAlreadyElapsed: Int((intervalSinceReferenceDate − FloatMax(week).weeks).inDays.rounded(.down)))
    }

    // MARK: - Decodable

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    internal init(from decoder: Decoder) throws {
        unreachable() // This definition is only ever transiently created to determine the weekday of another date.
    }

    // MARK: - Encodable

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    internal func encode(to encoder: Encoder) throws {
        unreachable() // This definition is only ever transiently created to determine the weekday of another date.
    }
}
