/*
 ConsistentDurationCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
