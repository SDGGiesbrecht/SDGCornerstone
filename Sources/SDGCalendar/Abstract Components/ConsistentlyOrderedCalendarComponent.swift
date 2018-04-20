/*
 ConsistentlyOrderedCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstoneLocalizations

/// A calendar component with a consistent order.
public protocol ConsistentlyOrderedCalendarComponent : CalendarComponent, FixedScaleOneDimensionalPoint {

    // [_Define Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    init(numberAlreadyElapsed: Vector)

    // [_Define Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(ordinal:)_]
    /// Creates a component from an ordinal.
    ///
    /// - Precondition: The ordinal must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - ordinal: The ordinal.
    init(ordinal: Vector)

    // [_Define Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    var numberAlreadyElapsed: Vector { get }

    // [_Define Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.ordinal_]
    /// The ordinal.
    var ordinal: Vector { get }
}

extension ConsistentlyOrderedCalendarComponent where Self : EnumerationCalendarComponent, Self.RawValue == Int {
    // MARK: - where Self : EnumerationCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    @_inlineable public init(numberAlreadyElapsed: RawValue) {
        guard let result = Self(rawValue: numberAlreadyElapsed) else {
            preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada: // [_Exempt from Test Coverage_]
                    return StrictString("Invalid raw value “\(numberAlreadyElapsed)” for \(Self.self).")
                }
            }))
        }
        self = result
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(ordinal:)_]
    /// Creates a component from an ordinal.
    ///
    /// - Precondition: The ordinal must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - ordinal: The ordinal.
    @_inlineable public init(ordinal: RawValue) {
        self.init(numberAlreadyElapsed: ordinal − 1)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    @_inlineable public var numberAlreadyElapsed: RawValue {
        return rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.ordinal_]
    /// The ordinal.
    @_inlineable public var ordinal: RawValue {
        return rawValue + 1
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    @_inlineable public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue = Self(numberAlreadyElapsed: precedingValue.numberAlreadyElapsed + followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    @_inlineable public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        return precedingValue.numberAlreadyElapsed − followingValue.numberAlreadyElapsed
    }
}

extension ConsistentlyOrderedCalendarComponent where Self : EnumerationCalendarComponent, Self.RawValue == Self.Vector {
    // MARK: - where Self : EnumerationCalendarComponent, Self.RawValue == Self.Vector

    // MARK: - Decodable

    @_inlineable @_versioned internal init(usingOrdinalFrom decoder: Decoder) throws {
        // For GregorianMonth, GregorianWeekday & HebrewWeekday
        try self.init(from: decoder, via: Vector.self, convert: { Self(rawValue: $0 − (1 as Vector)) })
    }

    // MARK: - Encodable

    @_inlineable @_versioned internal func encodeUsingOrdinal(to encoder: Encoder) throws {
        // For GregorianMonth, GregorianWeekday & HebrewWeekday
        try encode(to: encoder, via: ordinal)
    }
}
