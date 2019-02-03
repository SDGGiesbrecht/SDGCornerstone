/*
 GregorianMinute.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

/// A minute of the Gregorian hour.
public struct GregorianMinute : CardinalCalendarComponent, CodableViaRawRepresentableCalendarComponent, ConsistentDurationCalendarComponent, ICalendarComponent, ISOCalendarComponent, RawRepresentableCalendarComponent, TextualPlaygroundDisplay {

    // MARK: - Static Properties

    /// The number of minutes in an hour.
    public static let minutesPerHour: Int = 60

    // MARK: - Properties

    private var minute: Int

    // MARK: - ConsistentDurationCalendarComponent

    // @documentation(SDGCornerstone.ConsistentDurationCalendarComponent.duration)
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).minutes
    }

    // MARK: - Text Representations

    /// Returns the minite in digits with leading zeroes.
    public func inDigits() -> StrictString {
        return minute.inDigits().filled(to: 2, with: "0", from: .start)
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return String(UserFacing<StrictString, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada, .deutschDeutschland, .françaisFrance, .ελληνικάΕλλάδα, .עברית־ישראל:
                return self.inDigits()
            }
        }).resolved())
    }

    // MARK: - ISOCalendarComponent

    // #documentation(SDGCornerstone.ISOCalendarCompenent.inISOFormat())
    /// Returns a string representation in the ISO format.
    public func inISOFormat() -> StrictString {
        return minute.inDigits().filled(to: 2, with: "0", from: .start)
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Int

    // MARK: - RawRepresentableCalendarComponent

    // #documentation(SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:))
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    ///
    /// - Parameters:
    ///     - unsafeRawValue: The raw value.
    public init(unsafeRawValue: RawValue) {
        minute = unsafeRawValue
    }

    // #documentation(SDGCornerstone.RawRepresentableCalendarComponent.validRange)
    /// The valid range for raw values.
    public static let validRange: Range<RawValue>? = 0 ..< GregorianMinute.minutesPerHour

    // #documentation(SDGCornerstone.RawRepresentableCalendarComponent.rawValue)
    /// The raw value.
    public var rawValue: RawValue {
        return minute
    }
}
