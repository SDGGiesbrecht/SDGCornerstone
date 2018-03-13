/*
 ConsistentDurationCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar component with a consisent duration.
public protocol ConsistentDurationCalendarComponent {

    // [_Define Documentation: SDGCornerstone.ConsistentDurationCalendarComponent.duration_]
    /// The duration.
    static var duration: CalendarInterval<FloatMax> { get }
}

extension ConsistentDurationCalendarComponent {

    // MARK: - CalendarComponent

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.meanDuration_]
    /// The mean duration.
    @_transparent public static var meanDuration: CalendarInterval<FloatMax> {
        return duration
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.minimumDuration_]
    /// The minimum duration.
    @_transparent public static var minimumDuration: CalendarInterval<FloatMax> {
        return duration
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarComponent.maximumDuration_]
    /// The maximum duration.
    @_transparent public static var maximumDuration: CalendarInterval<FloatMax> {
        return duration
    }
}
