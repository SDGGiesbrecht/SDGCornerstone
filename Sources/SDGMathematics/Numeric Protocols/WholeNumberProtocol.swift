/*
 WholeNumberProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type which *only ever* represents whole numbers.
///
/// Conformance Requirements:
///
/// - `WholeArithmetic`
public protocol WholeNumberProtocol : WholeArithmetic {

}

extension WholeNumberProtocol {

    // #documentation(SDGCornerstone.WholeArithmetic.↑=)
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
    @inlinable public static func ↑= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.raiseWholeNumberToThePowerOf(wholeNumber: followingValue)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.isWhole)
    /// Returns `true` if `self` is a whole number.
    @inlinable public var isWhole: Bool {
        return true
    }

    // #documentation(SDGCornerstone.WholeArithmetic.isIntegral)
    /// Returns `true` if `self` is an integer.
    @inlinable public var isIntegral: Bool {
        return true
    }

    // #documentation(SDGCornerstone.WholeArithmetic.round(_:))
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @inlinable public mutating func round(_ rule: RoundingRule) {
        // self = self
    }

    // MARK: - NumericAdditiveArithmetic

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isNegative)
    /// Returns `true` if `self` is negative.
    @inlinable public var isNegative: Bool {
        return false
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isNonNegative)
    /// Returns `true` if `self` is positive or zero.
    @inlinable public var isNonNegative: Bool {
        return true
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue)
    /// Sets `self` to its absolute value.
    @inlinable public mutating func formAbsoluteValue() {
        // self = self
    }
}
