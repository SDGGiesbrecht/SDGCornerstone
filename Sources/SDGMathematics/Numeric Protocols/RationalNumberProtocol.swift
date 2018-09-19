/*
 RationalNumberProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type which *only ever* represents rational numbers.
///
/// Conformance Requirements:
///
/// - `RationalArithmetic`
/// - `func reduced() -> (numerator: Integer, denominator: Integer)`
public protocol RationalNumberProtocol : RationalArithmetic {

    // @documentation(SDGCornerstone.RationalNumberProtocol.Integer)
    /// The type to use for the numerator and denominator.
    associatedtype Integer : IntegerProtocol

    // @documentation(SDGCornerstone.RationalNumberProtocol.reducedSimpleFraction())
    /// Returns the numerator and denominator of the number as a reduced simple fraction.
    func reducedSimpleFraction() -> (numerator: Integer, denominator: Integer)
}

extension RationalNumberProtocol {

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
        precedingValue.raiseRationalNumberToThePowerOf(rationalNumber: followingValue)
    }
}
