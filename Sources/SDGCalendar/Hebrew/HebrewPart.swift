/*
 HebrewPart.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

/// A part of the Hebrew hour.
public struct HebrewPart : CardinalCalendarComponent, CodableViaRawRepresentableCalendarComponent, ConsistentDurationCalendarComponent, RawRepresentableCalendarComponent, SmallestCalendarComponent, TextualPlaygroundDisplay {

    // MARK: - Static Properties

    /// The number of parts in a Hebrew hour.
    public static let partsPerHour = 1080

    // MARK: - Properties

    private var part: FloatMax

    // MARK: - Text Representations

    /// Returns the part in digits.
    public func inDigits() -> StrictString {
        return Int(part.rounded(.down)).inDigits()
    }

    // MARK: - ConsistentDurationCalendarComponent

    // [_Define Documentation: SDGCornerstone.ConsistentDurationCalendarComponent.duration_]
    /// The duration.
    public static var duration: CalendarInterval<FloatMax> {
        return (1 as FloatMax).hebrewParts
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacingText({ (localization: InterfaceLocalization) in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.inDigits()
            }
        }).resolved())
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
    public init(unsafeRawValue: RawValue) {
        part = unsafeRawValue
    }

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    public static let validRange: Range<RawValue>? = 0 ..< FloatMax(HebrewPart.partsPerHour)

    // [_Inherit Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    public var rawValue: RawValue {
        return part
    }
}
