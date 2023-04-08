/*
 RationalArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

/// A type that can be used for rational arithmetic.
public protocol RationalArithmetic: ExpressibleByFloatLiteral, IntegralArithmetic {

  /// Creates an instance as close as possible to `floatingPoint`.
  ///
  /// - Properties:
  ///     - floatingPoint: An instance of `FloatMax`.
  init(_ floatingPoint: FloatMax)

  /// Returns the (rational) quotient of the preceding value divided by the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: The dividend.
  ///     - followingValue: The divisor.
  static func ÷ (precedingValue: Self, followingValue: Self) -> Self

  /// Modifies the preceding value by dividing it by the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: The value to modify.
  ///     - followingValue: The divisor.
  static func ÷= (precedingValue: inout Self, followingValue: Self)

  // #documentation(SDGCornerstone.WholeArithmetic.random(in:))
  /// Creates a random value within a particular range.
  ///
  /// - Parameters:
  ///     - range: The allowed range for the random value.
  static func random(in range: Range<Self>) -> Self

  // #documentation(SDGCornerstone.WholeArithmetic.random(in:using:))
  /// Creates a random value within a particular range using the specified randomizer.
  ///
  /// - Parameters:
  ///     - range: The allowed range for the random value.
  ///     - generator: The randomizer to use to generate the random value.
  static func random<R>(in range: Range<Self>, using generator: inout R) -> Self
  where R: RandomNumberGenerator
}

extension RationalArithmetic {

  @inlinable public static func ÷ (precedingValue: Self, followingValue: Self) -> Self {
    return nonmutatingVariant(of: ÷=, on: precedingValue, with: followingValue)
  }

  @inlinable internal mutating func raiseRationalNumberToThePowerOf(rationalNumber exponent: Self) {

    _assert(
      exponent.isIntegral,
      { (localization: _APILocalization) -> String in  // @exempt(from: tests)
        switch localization {  // @exempt(from: tests)
        case .englishCanada:
          return
            "The result of a non‐integer exponent may be outside the set of rational numbers. Use a type that conforms to RealArithmetic instead. (\(exponent))"
        }
      }
    )

    if exponent.isNegative {
      self = 1 ÷ self ↑ −exponent
    } else /* exponent.isNonNegative */
    {
      raiseIntegerToThePowerOf(integer: exponent)
    }
  }

  @inlinable public static func random(in range: Range<Self>) -> Self {
    var generator = SystemRandomNumberGenerator()
    return random(in: range, using: &generator)
  }

  // #documentation(SDGCornerstone.WholeArithmetic.random(in:using:))
  /// Creates a random value within a particular range using the specified randomizer.
  ///
  /// - Parameters:
  ///     - range: The allowed range for the random value.
  ///     - generator: The randomizer to use to generate the random value.
  @inlinable public static func random<R>(in range: Range<Self>, using generator: inout R) -> Self
  where R: RandomNumberGenerator {

    _assert(
      ¬range.isEmpty,
      { (localization: _APILocalization) in  // @exempt(from: tests)
        switch localization {  // @exempt(from: tests)
        case .englishCanada:
          return "Empty range."
        }
      }
    )

    var result = range.upperBound

    while result == range.upperBound {
      result = Self.random(in: range.lowerBound...range.upperBound, using: &generator)
    }

    return result
  }

  // MARK: - ExpressibleByFloatLiteral

  @inlinable public init(floatLiteral: FloatMax) {
    self.init(floatLiteral)
  }
}

extension BinaryFloatingPoint where Self.RawSignificand: FixedWidthInteger {
  @inlinable internal static func _random(in range: Range<Self>) -> Self {
    return random(in: range)
  }
  @inlinable internal static func _random<R>(in range: Range<Self>, using generator: inout R)
    -> Self where R: RandomNumberGenerator
  {
    return random(in: range, using: &generator)
  }
}
extension RationalArithmetic
where Self: BinaryFloatingPoint, Self.RawSignificand: FixedWidthInteger {
  // Disambiguate

  @inlinable public static func random(in range: Range<Self>) -> Self {
    return _random(in: range)
  }

  @inlinable public static func random<R>(in range: Range<Self>, using generator: inout R) -> Self
  where R: RandomNumberGenerator {
    return _random(in: range, using: &generator)
  }
}
