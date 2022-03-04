/*
 Int.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// The member of the `Int` family with the largest bit field.
public typealias IntMax = Int64

/// A member of the `Int` family: `Int`, `Int64`, `Int32`, `Int16` or `Int8`.
public protocol IntFamily: CustomReflectable, CVarArg, FixedWidthInteger, IntegerProtocol,
  MirrorPath, SignedInteger
{}
/// A numbered member of the `Int` family: `Int64`, `Int32`, `Int16` or `Int8`.
public protocol IntXFamily: IntFamily {}

extension IntFamily {

  // MARK: - IntegralArithmetic

  @inlinable public init<I: IntFamily>(_ int: I) {
    self.init(asBinaryIntegerWithInt: int)
  }

  // MARK: - Negatable

  @inlinable public static prefix func − (operand: Self) -> Self {
    // #workaround(Swift 5.5, Should just be negative instead of minus, but for compiler bug.)
    return 0 - operand  // @exempt(from: unicode)
  }

  // MARK: - NumericAdditiveArithmetic

  @inlinable public var absoluteValue: Self {
    return abs(self)
  }

  @inlinable public mutating func formAbsoluteValue() {
    self = abs(self)
  }

  // MARK: - Subtractable

  @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
    return precedingValue - followingValue  // @exempt(from: unicode)
  }

  @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
    precedingValue -= followingValue  // @exempt(from: unicode)
  }

  // MARK: - WholeArithmetic

  @inlinable public init<U: UIntFamily>(_ uInt: U) {
    self.init(asBinaryIntegerWithUInt: uInt)
  }

  @inlinable public static func × (precedingValue: Self, followingValue: Self) -> Self {
    return precedingValue * followingValue  // @exempt(from: unicode)
  }

  @inlinable public static func ×= (precedingValue: inout Self, followingValue: Self) {
    precedingValue *= followingValue  // @exempt(from: unicode)
  }

  @inlinable public mutating func divideAccordingToEuclid(by divisor: Self) {

    let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

    let needsToWrapToPrevious = negative ∧ self % divisor ≠ 0
    // Wrap to previous if negative (ignoring when exactly even)

    self /= divisor  // @exempt(from: unicode)

    if needsToWrapToPrevious {
      self −= 1 as Self
    }
  }

  @inlinable public var isEven: Bool {
    return ¬isOdd
  }

  @inlinable public var isOdd: Bool {
    return self & 1 == 1
  }
}

extension IntXFamily {

  // MARK: - PointProtocol

  @inlinable public static func + (precedingValue: Self, followingValue: Vector) -> Self {
    return precedingValue.advanced(by: followingValue)
  }

  @inlinable public static func += (precedingValue: inout Self, followingValue: Vector) {
    precedingValue = precedingValue.advanced(by: followingValue)
  }

  @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Vector {
    return followingValue.distance(to: precedingValue)
  }
}

extension BinaryInteger {
  @inlinable internal init<I: IntFamily>(asBinaryIntegerWithInt int: I) {
    self.init(int)
  }
}

// @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
/// Eine Ganzzahl mit Vorzeichen. (`Int`)
public typealias GZahl = Int
extension Int: IntFamily & _WholeArithmeticRandomness {

  // MARK: - Negatable

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.Negatable.−)
  /// Returns the additive inverse of the operand.
  ///
  /// - Parameters:
  ///     - operand: The value to invert.
  @inlinable public static prefix func − (operand: Self) -> Self {
    return 0 - operand  // @exempt(from: unicode)
  }

  // MARK: - PointProtocol

  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(PointProtocol.Vector)
  /// The type to be used as a vector.
  public typealias Vector = Stride

  // MARK: - Subtractible

  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.Subtractible.−(_:_:))
  /// Returns the difference of the preceding value minus the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: The starting value.
  ///     - followingValue: The value to subtract.
  @inlinable public static func − (precedingValue: Int, followingValue: Int) -> Int {
    return precedingValue - followingValue  // @exempt(from: unicode)
  }

  // MARK: - WholeArithmetic

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.WholeArithmetic.×(_:_:))
  /// Returns the product of the preceding value times the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: A value.
  ///     - followingValue: Another value.
  @inlinable public static func × (precedingValue: Self, followingValue: Self) -> Self {
    return precedingValue * followingValue  // @exempt(from: unicode)
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.WholeArithmetic.isOdd)
  /// Returns true if `self` is an odd integer.
  @inlinable public var isOdd: Bool {
    return self & 1 == 1
  }
}
extension Int64: IntXFamily & _WholeArithmeticRandomness {

  // MARK: - PointProtocol

  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(PointProtocol.Vector)
  /// The type to be used as a vector.
  public typealias Vector = Stride

  // MARK: - NumericAdditiveArithmetic

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.WholeArithmetic.isPositive)
  /// Returns `true` if `self` is positive.
  @inlinable public var isPositive: Bool {
    return self > Self.zero
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.WholeArithmetic.isNegative)
  /// Returns `true` if `self` is negative.
  @inlinable public var isNegative: Bool {
    return self < Self.zero
  }

  // MARK: - Subtractable

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.Subtractible.−(_:_:))
  /// Returns the difference of the preceding value minus the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: The starting value.
  ///     - followingValue: The value to subtract.
  @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
    return precedingValue - followingValue  // @exempt(from: unicode)
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.WholeArithmetic.−=(_:_:))
  /// Subtracts the following value from the preceding value.
  ///
  /// - Parameters:
  ///     - precedingValue: The value to modify.
  ///     - followingValue: The value to subtract.
  @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
    precedingValue -= followingValue  // @exempt(from: unicode)
  }

  // MARK: - WholeArithmetic

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.WholeArithmetic.×(_:_:))
  /// Returns the product of the preceding value times the following value.
  ///
  /// - Parameters:
  ///     - precedingValue: A value.
  ///     - followingValue: Another value.
  @inlinable public static func × (precedingValue: Self, followingValue: Self) -> Self {
    return precedingValue * followingValue  // @exempt(from: unicode)
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:))
  /// Sets `self` to the integral quotient of `self` divided by `divisor`.
  ///
  /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
  ///
  /// - Parameters:
  ///     - divisor: The divisor.
  @inlinable public mutating func divideAccordingToEuclid(by divisor: Self) {

    let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

    let needsToWrapToPrevious = negative ∧ self % divisor ≠ 0
    // Wrap to previous if negative (ignoring when exactly even)

    self /= divisor  // @exempt(from: unicode)

    if needsToWrapToPrevious {
      self −= 1 as Self
    }
  }
}
extension Int32: IntXFamily & _WholeArithmeticRandomness {

  // MARK: - PointProtocol

  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(PointProtocol.Vector)
  /// The type to be used as a vector.
  public typealias Vector = Stride
}
extension Int16: IntXFamily & _WholeArithmeticRandomness {

  // MARK: - PointProtocol

  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(PointProtocol.Vector)
  /// The type to be used as a vector.
  public typealias Vector = Stride
}
extension Int8: IntXFamily & _WholeArithmeticRandomness {

  // MARK: - PointProtocol

  // #workaround(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // #documentation(PointProtocol.Vector)
  /// The type to be used as a vector.
  public typealias Vector = Stride
}
