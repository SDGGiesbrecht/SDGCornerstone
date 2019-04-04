/*
 Negatable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
/// - `GenericAdditiveArithmetic`
public protocol Negatable : GenericAdditiveArithmetic {

    // @documentation(SDGCornerstone.Negatable.−)
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    static prefix func − (operand: Self) -> Self

    /// Replaces this value with its additive inverse.
    mutating func negate()
}

extension Negatable {

    @inlinable public static prefix func − (operand: Self) -> Self {
        return nonmutatingVariant(of: { $0.negate() }, on: operand)
    }

    @inlinable internal mutating func _negate() {
        self = Self.zero − self
    }
    @inlinable public mutating func negate() {
        _negate()
    }
}

extension SignedInteger {
    @inlinable internal mutating func __negate() {
        negate()
    }
}
extension Negatable where Self : SignedInteger {

    @inlinable public mutating func negate() {
        __negate()
    }
}

extension Negatable where Self : SignedNumeric {

    // #documentation(SDGCornerstone.Negatable.−)
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    @inlinable public static prefix func - (operand: Self) -> Self { // @exempt(from: unicode)
        return −operand
    }

    @inlinable public mutating func negate() {
        _negate()
    }
}
