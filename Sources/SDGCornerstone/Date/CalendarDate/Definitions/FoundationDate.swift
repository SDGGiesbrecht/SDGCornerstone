/*
 FoundationDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal struct FoundationDate : DateDefinition {

    // MARK: - Initialization

    internal init(_ date: Date) {
        self.date = date
        self.intervalSinceReferenceDate = FloatMax(date.timeIntervalSinceReferenceDate).seconds
    }

    // MARK: - Properties

    internal let date: Date

    // MARK: - DateDefinition

    internal static let referenceDate = CalendarDate(gregorianYear: 2001, month: .january, day: 1, hour: 0, minute: 0, second: 0)
    internal var intervalSinceReferenceDate: CalendarInterval<FloatMax>

    internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(intervalSinceReferenceDate.inSeconds))
    }
}
