/*
 GregorianMinute.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A minute of the Gregorian hour.
public struct GregorianMinute : CardinalCalendarComponent, CodableViaRawRepresentableCalendarComponent, ConsistentDurationCalendarComponent, ICalendarComponent, ISOCalendarComponent, RawRepresentableCalendarComponent {

    // MARK: - Static Properties

    /// The number of minutes in an hour.
    public static let minutesPerHour = 60

    // MARK: - Properties

    private var minute: Int

    // MARK: - ConsistentDurationCalendarComponent

    // [_Define Documentation: SDGCornerstone.ConsistentDurationCalendarComponent.duration_]
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).minutes
    }

    // MARK: - Text Representations

    /// Returns the minite in digits with leading zeroes.
    public func inDigits() -> StrictString {
        return minute.inDigits().filled(to: 2, with: "0", from: .start)
    }

    // MARK: - ISOCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ISOCalendarCompenent.inISOFormat()_]
    /// Returns a string representation in the ISO format.
    public func inISOFormat() -> StrictString {
        return minute.inDigits().filled(to: 2, with: "0", from: .start)
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
        minute = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<RawValue>? = 0 ..< GregorianMinute.minutesPerHour

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: RawValue {
        return minute
    }
}
