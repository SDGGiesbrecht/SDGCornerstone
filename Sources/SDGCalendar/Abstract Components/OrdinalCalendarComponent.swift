/*
 OrdinalCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar component defined by an ordinal raw value.
public protocol OrdinalCalendarComponent : NumericCalendarComponent {}

extension OrdinalCalendarComponent {

    // MARK: - ConsistentlyOrderedCalendarComponent

    // #documentation(SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(numberAlreadyElapsed:))
    /// Creates a component from the number of complete components already elapsed.
    ///
    /// - Precondition: The number must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
    @inlinable public init(numberAlreadyElapsed: Vector) {
        self.init(numberAlreadyElapsed + (1 as Vector))
    }

    // #documentation(SDGCornerstone.ConsistentlyOrderedCalendarComponent.init(ordinal:))
    /// Creates a component from an ordinal.
    ///
    /// - Precondition: The ordinal must be valid for the particular compenent.
    ///
    /// - Parameters:
    ///     - ordinal: The ordinal.
    @inlinable public init(ordinal: Vector) {
        self.init(ordinal)
    }

    // #documentation(SDGCornerstone.ConsistentlyOrderedCalendarComponent.numberAlreadyElapsed)
    /// The number of complete components already elapsed.
    @inlinable public var numberAlreadyElapsed: Vector {
        return rawValue − (1 as Vector)
    }

    // #documentation(SDGCornerstone.ConsistentlyOrderedCalendarComponent.ordinal)
    /// The ordinal.
    @inlinable public var ordinal: Vector {
        return rawValue
    }
}
