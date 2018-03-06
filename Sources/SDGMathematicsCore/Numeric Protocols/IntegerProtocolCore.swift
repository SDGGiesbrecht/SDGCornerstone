/*
 IntegerProtocolCore.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type which *only ever* represents integers.
///
/// Conformance Requirements:
///
/// - `IntegralArithmeticCore`
public protocol IntegerProtocolCore : IntegralArithmeticCore {

}

extension IntegerProtocolCore {

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the preceding value by exponentiation with the following value.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `followingValue` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `followingValue` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
    ///     - `precedingValue` must be positive, or
    ///     - `followingValue` must be an integer.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The exponent.
    @_transparent public static func ↑= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.raiseIntegerToThePowerOf(integer: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isIntegral_]
    /// Returns `true` if `self` is an integer.
    @_transparent public var isIntegral: Bool {
        return true
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @_transparent public mutating func round(_ rule: RoundingRule) {
        // self = self
    }
}
