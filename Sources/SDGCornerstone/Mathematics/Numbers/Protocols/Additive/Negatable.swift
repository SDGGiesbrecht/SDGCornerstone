/*
 Negatable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Performs additive inversion.
///
/// - MutatingVariant: −=
///
/// - RecommendedOver: -
prefix operator −

/// Modifies the operand by additive inversion.
///
/// - NonmutatingVariant: −
postfix operator −=

/// A type that can be additively inverted.
///
/// - Note: Unlike `SignedNumeric`, `Negatable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
public protocol Negatable : AdditiveArithmetic {

    // [_Define Documentation: SDGCornerstone.Negatable.−_]
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    static prefix func − (operand: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    static postfix func −= (operand: inout Self)
}

extension Negatable {

    // [_Inherit Documentation: SDGCornerstone.Negatable.−_]
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static prefix func − (operand: Self) -> Self {
        var result = operand
        result−=
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Self) {
        operand = additiveIdentity − operand
    }
}

extension Negatable where Self : FloatFamily {
    // MARK: - where Self : FloatFamily

    // [_Inherit Documentation: SDGCornerstone.Negatable.−_]
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static prefix func − (operand: Self) -> Self {
        return -operand
    }

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Self) {
        operand.negate()
    }
}

extension Negatable where Self : IntFamily {
    // MARK: - where Self : IntFamily

    // [_Inherit Documentation: SDGCornerstone.Negatable.−_]
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static prefix func − (operand: Self) -> Self {
        return -operand
    }

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Self) {
        operand.negate()
    }
}

extension Negatable where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.Negatable.−_]
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static prefix func − (operand: Self) -> Self {
        return Self(rawValue: −operand.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Self) {
        operand.rawValue−=
    }
}
