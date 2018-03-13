/*
 CalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A component of a particular calendar.
public protocol CalendarComponent : Codable {

    // [_Define Documentation: SDGCornerstone.CalendarComponent.meanDuration_]
    /// The mean duration.
    static var meanDuration: CalendarInterval<FloatMax> { get }

    // [_Define Documentation: SDGCornerstone.CalendarComponent.minimumDuration_]
    /// The minimum duration.
    static var minimumDuration: CalendarInterval<FloatMax> { get }

    // [_Define Documentation: SDGCornerstone.CalendarComponent.maximumDuration_]
    /// The maximum duration.
    static var maximumDuration: CalendarInterval<FloatMax> { get }
}
