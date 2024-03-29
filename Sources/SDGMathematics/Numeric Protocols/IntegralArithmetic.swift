/*
 IntegralArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used for integral arithmetic.
public protocol IntegralArithmetic: Negatable, SignedNumeric, WholeArithmetic {

  /// Creates an instance equal to `int`.
  ///
  /// - Parameters:
  ///   - int: An instance of `IntMax`.
  init(_ int: IntMax)
}

extension IntegralArithmetic {

  /// Creates an instance equal to `int`.
  ///
  /// - Parameters:
  ///   - int: An instance of a member of the `Int` family.
  @inlinable public init<I: IntFamily>(_ int: I) {
    self.init(IntMax(int))
  }

  @inlinable internal mutating func raiseIntegerToThePowerOf(integer exponent: Self) {

    _assert(
      exponent.isNonNegative,
      { (localization: _APILocalization) -> String in  // @exempt(from: tests)
        switch localization {  // @exempt(from: tests)
        case .englishCanada:
          return
            "The result of a negative exponent may be outside the set of integers. Use a type that conforms to RationalArithmetic instead. (\(exponent))"
        }
      }
    )

    raiseWholeNumberToThePowerOf(wholeNumber: exponent)
  }
}
