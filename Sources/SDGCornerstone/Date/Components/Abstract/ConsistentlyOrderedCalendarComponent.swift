/*
 ConsistentlyOrderedCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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

extension ConsistentlyOrderedCalendarComponent where Self : CardinalCalendarComponent, Self.Vector == Self.RawValue {
    // MARK: - where Self : CardinalCalendarComponent, Self.Vector == Self.RawValue

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    public init(numberAlreadyElapsed: RawValue) {
        self.init(numberAlreadyElapsed)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(ordinal:)_]
    /// Creates a component from an ordinal.
    ///
    /// - Precondition: The ordinal must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - ordinal: The ordinal.
    public init(ordinal: RawValue) {
        self.init(ordinal − 1)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    public var numberAlreadyElapsed: RawValue {
        return rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.ordinal_]
    /// The ordinal.
    public var ordinal: RawValue {
        return rawValue + 1
    }
}

extension ConsistentlyOrderedCalendarComponent where Self : EnumerationCalendarComponent, Self.RawValue.Vector : ExpressibleByIntegerLiteral {
    // MARK: - where Self : OrdinalCalendarComponent, Self.RawValue.Vector : ExpressibleByIntegerLiteral

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    public init(numberAlreadyElapsed: RawValue) {
        guard let result = Self(rawValue: numberAlreadyElapsed) else {
            preconditionFailure(UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada:
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
    public init(ordinal: RawValue) {
        self.init(numberAlreadyElapsed: ordinal − 1)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    public var numberAlreadyElapsed: RawValue {
        return rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.ordinal_]
    /// The ordinal.
    public var ordinal: RawValue {
        return rawValue + 1
    }
}

extension ConsistentlyOrderedCalendarComponent where Self : OrdinalCalendarComponent, Self.Vector == Self.RawValue {
    // MARK: - where Self : OrdinalCalendarComponent, Self.Vector == Self.RawValue

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    public init(numberAlreadyElapsed: Vector) {
        self.init(numberAlreadyElapsed + 1)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(ordinal:)_]
    /// Creates a component from an ordinal.
    ///
    /// - Precondition: The ordinal must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - ordinal: The ordinal.
    public init(ordinal: Vector) {
        self.init(ordinal)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    public var numberAlreadyElapsed: Vector {
        return rawValue − 1
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.ordinal_]
    /// The ordinal.
    public var ordinal: Vector {
        return rawValue
    }
}
