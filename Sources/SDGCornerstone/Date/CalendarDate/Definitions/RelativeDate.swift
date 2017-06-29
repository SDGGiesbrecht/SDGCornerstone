/*
 RelativeDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal struct RelativeDate : DateDefinition {

    // MARK: - Initialization

    internal init(_ interval: CalendarInterval<FloatMax>, after date: CalendarDate) {
        baseDate = date
        intervalSince = interval

        intervalSinceReferenceDate = (date − RelativeDate.referenceDate) + interval
    }

    // MARK: - Properties

    private let baseDate: CalendarDate
    private let intervalSince: CalendarInterval<FloatMax>

    // MARK: - DateDefinition

    internal static let referenceDate: CalendarDate = CalendarDate.epoch

    internal let intervalSinceReferenceDate: CalendarInterval<FloatMax>

    internal init(intervalSinceReferenceDate: CalendarInterval<FloatMax>) {
        self.intervalSinceReferenceDate = intervalSinceReferenceDate

        self.baseDate = RelativeDate.referenceDate
        self.intervalSince = intervalSinceReferenceDate
    }
}
