/*
 ConsistentDurationCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar component with a consisent duration.
public protocol ConsistentDurationCalendarComponent : CalendarComponent {

    /// The duration.
    static var duration: CalendarInterval<FloatMax> { get }
}

extension ConsistentDurationCalendarComponent {

    // MARK: - CalendarComponent

    @inlinable public static var meanDuration: CalendarInterval<FloatMax> {
        return duration
    }

    @inlinable public static var minimumDuration: CalendarInterval<FloatMax> {
        return duration
    }

    @inlinable public static var maximumDuration: CalendarInterval<FloatMax> {
        return duration
    }
}
