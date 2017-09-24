/*
 HebrewHour.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An hour of the Hebrew day.
public struct HebrewHour : CardinalCalendarComponent, ConsistentDurationCalendarComponent, RawRepresentableCalendarComponent {

    // MARK: - Static Properties

    /// The number of hours in a day.
    public static let hoursPerDay = 24

    // MARK: - Properties

    private var hour: Int

    // MARK: - Text Representations

    /// Returns the hour in digits.
    public func inDigits() -> StrictString {
        return hour.inDigits()
    }

    // MARK: - ConsistentDurationCalendarComponent

    // [_Define Documentation: SDGCornerstone.ConsistentDurationCalendarComponent.duration_]
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).hours
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Int

    // MARK: - RawRepresentableCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:)_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    public init(unsafeRawValue: RawValue) {
        hour = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<RawValue>? = 0 ..< HebrewHour.hoursPerDay

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: RawValue {
        return hour
    }
}
