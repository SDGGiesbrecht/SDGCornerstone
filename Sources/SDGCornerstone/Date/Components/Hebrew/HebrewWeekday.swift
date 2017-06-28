/*
 HebrewWeekday.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A day of the Hebrew week.
public enum HebrewWeekday : Int, ConsistentlyOrderedCalendarComponent, EnumerationCalendarComponent {

    // MARK: - Cases

    /// Sunday.
    case sunday
    /// Monday.
    case monday
    /// Tuesday.
    case tuesday
    /// Wednesday.
    case wednesday
    /// Thursday.
    case thursday
    /// Friday.
    case friday
    /// Saturday.
    case saturday

    // MARK: - Static Properties

    /// The number of days in a week.
    public static let daysPerWeek: Int = cases.count

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = RawValue

    // MARK: - RawRepresentable

    // [_Inherit Documentation: SDGCornerstone.RawRepresentable.RawValue_]
    /// The raw value type.
    public typealias RawValue = Int
}
