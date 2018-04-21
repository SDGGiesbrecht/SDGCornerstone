/*
 GregorianSecond.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

/// A second of the Gregorian minute.
public struct GregorianSecond : CardinalCalendarComponent, CodableViaRawRepresentableCalendarComponent, ConsistentDurationCalendarComponent, ICalendarComponent, ISOCalendarComponent, RawRepresentableCalendarComponent, SmallestCalendarComponent, TextualPlaygroundDisplay {

    // MARK: - Static Properties

    /// The number of seconds in a minute.
    public static let secondsPerMinute = 60

    // MARK: - Properties

    private var second: FloatMax

    // MARK: - ConsistentDurationCalendarComponent

    // [_Define Documentation: SDGCornerstone.ConsistentDurationCalendarComponent.duration_]
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).seconds
    }

    // MARK: - Text Representations

    /// Returns the second in digits, floored and with leading zeroes.
    public func inDigits() -> StrictString {
        return Int(second.rounded(.down)).inDigits().filled(to: 2, with: "0", from: .start)
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacing<StrictString, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada, .deutschDeutschland, .françaisFrance, .ελληνικάΕλλάδα, .עברית־ישראל:
                return self.inDigits()
            }
        }).resolved())
    }

    // MARK: - ISOCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ISOCalendarCompenent.inISOFormat()_]
    /// Returns a string representation in the ISO format.
    public func inISOFormat() -> StrictString {
        return Int((second + 0.000_001).rounded(.down)).inDigits().filled(to: 2, with: "0", from: .start)
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = FloatMax

    // MARK: - RawRepresentableCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:)_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    public init(unsafeRawValue: FloatMax) {
        second = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<FloatMax>? = 0 ..< FloatMax(GregorianSecond.secondsPerMinute)

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: FloatMax {
        return second
    }
}
