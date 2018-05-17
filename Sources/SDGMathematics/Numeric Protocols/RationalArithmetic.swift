/*
 RationalArithmetic.swift

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
/// - `IntegralArithmetic`
/// - `init(_ floatingPoint: FloatMax)`
/// - `static func ÷= (precedingValue: inout Self, followingValue: Self)`
public protocol RationalArithmetic : ExpressibleByFloatLiteral, IntegralArithmetic {

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

extension RationalArithmetic {

    // [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷_]
    /// Returns the (rational) quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    @_inlineable public static func ÷ (precedingValue: Self, followingValue: Self) -> Self {
        return nonmutatingVariant(of: ÷=, on: precedingValue, with: followingValue)
    }

    @_inlineable @_versioned internal mutating func raiseRationalNumberToThePowerOf(rationalNumber exponent: Self) {

        _assert(exponent.isIntegral, { (localization: _APILocalization) -> String in
            switch localization { // [_Exempt from Test Coverage_]
            case .englishCanada:
                return "The result of a non‐integer exponent may be outside the set of rational numbers. Use a type that conforms to RealArithmetic instead. (\(exponent))"
            }
        })

        if exponent.isNegative {
            self = 1 ÷ self ↑ −exponent
        } else /* exponent.isNonNegative */ {
            raiseIntegerToThePowerOf(integer: exponent)
        }
    }

    // MARK: - ExpressibleByFloatLiteral

    // [_Define Documentation: SDGCornerstone.ExpressibleByFloatLiteral.init(floatLiteral:)_]
    /// Creates an instance from a floating‐point literal.
    ///
    /// - Parameters:
    ///     - floatLiteral: The floating point literal.
    @_inlineable public init(floatLiteral: FloatMax) {
        self.init(floatLiteral)
    }
}
