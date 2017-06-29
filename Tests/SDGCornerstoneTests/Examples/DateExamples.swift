/*
 DateExamples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import SDGCornerstone

// [_Define Example: DateDefinition_]
extension CalendarDate {

    // This initializer creates a date using the number of days into the current millennium.
    public init(daysIntoMillennium: FloatMax) {
        self.init(definition: DaysIntoMillennium(daysIntoMillennium))
    }

    // This property is available to dates with any kind of definition.
    public var someMeasurement: FloatMax {
        return converted(to: DaysIntoMillennium.self).daysIntoMillennium
    }
}

private struct DaysIntoMillennium : DateDefinition {

    // The reference date is January 1, 2001 at 00:00
    fileprivate static let referenceDate = CalendarDate(gregorianYear: 2001, month: .january, day: 1, hour: 0, minute: 0)

    fileprivate let daysIntoMillennium: FloatMax
    fileprivate let intervalSinceReferenceDate: CalendarInterval<FloatMax>

    fileprivate init(_ daysIntoMillennium: FloatMax) {
        self.daysIntoMillennium = daysIntoMillennium
        intervalSinceReferenceDate = daysIntoMillennium.days
    }

    fileprivate init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate
        daysIntoMillennium = intervalSinceReferenceDate.inDays
    }
}
// [_End_]
