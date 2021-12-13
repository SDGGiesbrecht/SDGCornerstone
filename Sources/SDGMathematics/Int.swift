/*
 Int.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    _ = self.isNegative
    //_ = (self.isNegative ∧ divisor.isPositive)
    //let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

    #if false
    let needsToWrapToPrevious = negative ∧ self % divisor ≠ 0
    // Wrap to previous if negative (ignoring when exactly even)

    self /= divisor  // @exempt(from: unicode)

    if needsToWrapToPrevious {
      self −= 1 as Self
    }
    #endif
  }

  @inlinable public var isEven: Bool {
    return ¬isOdd
  }

  @inlinable public var isOdd: Bool {
    return self & 1 == 1
  }

  // MARK: - NumericAdditiveArithmetic

  // #workaround(Swift 5.5.1, Redundant, but evades a compiler bug on Windows.)
  @inlinable public var isNegative: Bool {
    return self < 0
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
