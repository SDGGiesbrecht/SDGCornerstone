/*
 RationalArithmeticCore.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used for rational arithmetic.
///
/// Conformance Requirements:
///
/// - `IntegralArithmeticCore`
/// - `init(_ floatingPoint: FloatMax)`
/// - `static func ÷= (precedingValue: inout Self, followingValue: Self)`
public protocol RationalArithmeticCore : ExpressibleByFloatLiteral, IntegralArithmeticCore {

    // [_Define Documentation: SDGCornerstone.IntegralArithmetic.init(floatingPoint:)_]
    /// Creates an instance as close as possible to `floatingPoint`.
    ///
    /// - Properties:
    ///     - floatingPoint: An instance of `FloatMax`.
    init(_ floatingPoint: FloatMax)

    // [_Define Documentation: SDGCornerstone.RationalArithmetic.÷_]
    /// Returns the (rational) quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    static func ÷ (precedingValue: Self, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.RationalArithmetic.÷=_]
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The divisor.
    static func ÷= (precedingValue: inout Self, followingValue: Self)
}

extension RationalArithmeticCore {

    // [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷_]
    /// Returns the (rational) quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    @_inlineable public static func ÷ (precedingValue: Self, followingValue: Self) -> Self {
        return nonmutatingVariant(of: ÷=, on: precedingValue, with: followingValue)
    }

    // [_Workaround: This can be reduced to @abiPublic if SE‐0193 is implemented. (Swift 4.0.3)_]
    /// :nodoc:
    @_inlineable public mutating func _raiseRationalNumberToThePowerOf(rationalNumber exponent: Self) {

        // [_Warning: Can this can be localized? Otherwise switch to “◊(Q ↑ Z′ ∉ Q)”._]
        assert(exponent.isIntegral, /*UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return */"The result of a non‐integer exponent may be outside the set of rational numbers. Use a type that conforms to RealArithmetic instead."/*
            }
        })*/)

        if exponent.isNegative {
            self = 1 ÷ self ↑ −exponent
        } else /* exponent.isNonNegative */ {
            _raiseIntegerToThePowerOf(integer: exponent)
        }
    }
}
