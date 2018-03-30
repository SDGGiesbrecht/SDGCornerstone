/*
 CardinalCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar component defined by an cardinal number raw value.
public protocol CardinalCalendarComponent : NumericCalendarComponent {

}

extension CardinalCalendarComponent {

    // MARK: - ConsistentlyOrderedCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:)_]
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    @_inlineable public init(numberAlreadyElapsed: RawValue) {
        self.init(numberAlreadyElapsed)
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(ordinal:)_]
    /// Creates a component from an ordinal.
    ///
    /// - Precondition: The ordinal must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - ordinal: The ordinal.
    @_inlineable public init(ordinal: RawValue) {
        self.init(ordinal − (1 as Vector))
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed_]
    /// The number of complete components already elapsed.
    @_inlineable public var numberAlreadyElapsed: RawValue {
        return rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.ConsistentlyOrderedCalendarComponent.ordinal_]
    /// The ordinal.
    @_inlineable public var ordinal: RawValue {
        return rawValue + (1 as Vector)
    }
}
