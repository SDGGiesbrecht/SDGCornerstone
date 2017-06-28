/*
 GregorianSecond.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A second of the Gregorian minute.
public struct GregorianSecond : CardinalCalendarComponent, RawRepresentableCalendarComponent, SmallestCalendarComponent {

    // MARK: - Static Properties

    /// The number of seconds in a minute.
    public static let secondsPerMinute = SDGCornerstone.secondsPerMinute

    // MARK: - Properties

    private var second: Double

    // MARK: - iCalendar

    /// Returns a string representation in the iCalendar format.
    public var iCalendarRepresentation: StrictString {
        return StrictString(String(format: "%02d", Int(second.rounded(.towardZero))))
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Double

    // MARK: - RawRepresentableCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:)_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    public init(unsafeRawValue: Double) {
        second = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<Double>? = 0 ..< Double(GregorianSecond.secondsPerMinute)

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: Double {
        return second
    }
}
