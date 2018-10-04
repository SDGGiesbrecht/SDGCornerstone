/*
 Negatable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be additively inverted.
///
/// - Note: Unlike `SignedNumeric`, `Negatable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
public protocol Negatable : AdditiveArithmetic {

    // @documentation(SDGCornerstone.Negatable.−)
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    static prefix func − (operand: Self) -> Self

    // @documentation(SDGCornerstone.Negatable.−=)
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    static postfix func −= (operand: inout Self)
}

extension Negatable {

    // #documentation(SDGCornerstone.Negatable.−)
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    @inlinable public static prefix func − (operand: Self) -> Self {
        return nonmutatingVariant(of: −=, on: operand)
    }

    // #documentation(SDGCornerstone.Negatable.−=)
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    @inlinable public static postfix func −= (operand: inout Self) {
        operand = additiveIdentity − operand
    }
}

extension Negatable where Self : SignedNumeric {

    /// Returns the additive inverse of the specified value.
    @inlinable public static prefix func - (operand: Self) -> Self {
        return −operand
    }

    /// Replaces this value with its additive inverse.
    @inlinable public mutating func negate() {
        self−=
    }
}
