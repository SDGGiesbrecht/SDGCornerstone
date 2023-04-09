/*
 Int.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

  @inlinable internal static func negate<Number>(_ operand: Number) -> Number
  where Number: SignedNumeric {
    return -operand  // @exempt(from: unicode)
  }
  @inlinable public static prefix func − (operand: Self) -> Self {
    return negate(operand)
  }

  // MARK: - NumericAdditiveArithmetic

  @inlinable public var absoluteValue: Self {
    return abs(self)
  }

  @inlinable public mutating func formAbsoluteValue() {
    self = abs(self)
  }

  // MARK: - Subtractable

  // #documentation(Subtractable.−)
  /// Returns the difference of the preceding value minus the following value.
  ///
  /// - Parameters:
  ///   - precedingValue: The starting value.
  ///   - followingValue: The value to subtract.
  @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
    return precedingValue - followingValue  // @exempt(from: unicode)
  }

  // #documentation(Subtractable.−=)
  /// Subtracts the following value from the preceding value.
  ///
  /// - Parameters:
  ///   - precedingValue: The value to modify.
  ///   - followingValue: The value to subtract.
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

  // #documentation(PointProtocol.+(Self, Vector))
  /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
  ///
  /// - Parameters:
  ///   - precedingValue: The starting point.
  ///   - followingValue: The vector to add.
  @inlinable public static func + (precedingValue: Self, followingValue: Vector) -> Self {
    return precedingValue.advanced(by: followingValue)
  }

  // #documentation(PointProtocol.+=(Self, Vector))
  /// Moves the preceding point by the following vector.
  ///
  /// - Parameters:
  ///   - precedingValue: The point to modify.
  ///   - followingValue: The vector to add.
  @inlinable public static func += (precedingValue: inout Self, followingValue: Vector) {
    precedingValue = precedingValue.advanced(by: followingValue)
  }

  // #documentation(PointProtocol.−(Self, Self))
  /// Returns the vector that leads from the preceding point to the following point.
  ///
  /// - Parameters:
  ///   - precedingValue: The endpoint.
  ///   - followingValue: The startpoint.
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
extension Int: IntFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride

  // MARK: - Subtractible

  @inlinable public static func − (precedingValue: Int, followingValue: Int) -> Int {
    return precedingValue - followingValue  // @exempt(from: unicode)
  }
}
extension Int64: IntXFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
extension Int32: IntXFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
extension Int16: IntXFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
extension Int8: IntXFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
