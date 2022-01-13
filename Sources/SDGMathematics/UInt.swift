/*
 UInt.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// The member of the `UInt` family with the largest bit field.
public typealias UIntMax = UInt64

/// A type that represents a fixed‐length unsigned integer.
///
/// This protocol exists so that extensions to it can provide shared functionality for `UInt`, `UInt64`, `UInt32`, `UInt16` and `UInt8`.
public protocol UIntFamily: BitField, CustomReflectable, CVarArg, FixedWidthInteger,
  UnsignedInteger, WholeNumberProtocol
{}

extension CustomReflectable {
  #warning("Debugging...")
  public func verifyCustomReflectable() {
    print(#function)
  }
}
extension CVarArg {
  #warning("Debugging...")
  public func verifyCVarArg() {
    print(#function)
  }
}
extension FixedWidthInteger {
  #warning("Debugging...")
  public func verifyFixedWidthInteger() {
    print(#function)
  }
}
extension UnsignedInteger {
  #warning("Debugging...")
  public func verifyUnsignedInteger() {
    print(#function)
  }
}
extension Equatable {
  #warning("Debugging...")
  public func verifyEquatable() {
    _ = self == self
    print(#function)
  }
}
extension Numeric {
  #warning("Debugging...")
  public func verifyNumeric() {
    print(#function)
  }
}
extension Strideable {
  #warning("Debugging...")
  public func verifyStrideable() {
    print(#function)
  }
}
extension Comparable {
  #warning("Debugging...")
  public func verifyComparable() {
    print(#function)
  }
}
extension AdditiveArithmetic {
  #warning("Debugging...")
  public func verifyAdditiveArithmetic() {
    _ = Self.zero
    print(#function, Self.self)
  }
}
import Foundation
extension Decodable {
  #warning("Debugging...")
  public func verifyDecodable() {
    try? JSONDecoder().decode(Self.self, from: Data())
    print(#function, Self.self)
  }
}
extension Encodable {
  #warning("Debugging...")
  public func verifyEncodable() {
    try? JSONEncoder().encode(self)
    print(#function, Self.self)
  }
}
extension Hashable {
  #warning("Debugging...")
  public func verifyHashable() {
    var hasher = Hasher()
    hash(into: &hasher)
    print(#function, Self.self)
  }
}

extension UIntFamily {

  #warning("Debugging...")
  public func verifyUIntFamily() {
    print(#function)
  }

  // MARK: - BitField

  @inlinable public func bitwiseNot() -> Self {
    return ~self
  }

  @inlinable public mutating func formBitwiseNot() {
    self = bitwiseNot()
  }

  @inlinable public func bitwiseAnd(with other: Self) -> Self {
    return self & other
  }

  @inlinable public mutating func formBitwiseAnd(with other: Self) {
    self = bitwiseAnd(with: other)
  }

  @inlinable public func bitwiseOr(with other: Self) -> Self {
    return self | other
  }

  @inlinable public mutating func formBitwiseOr(with other: Self) {
    self = bitwiseOr(with: other)
  }

  @inlinable public func bitwiseExclusiveOr(with other: Self) -> Self {
    return self ^ other
  }

  @inlinable public mutating func formBitwiseExclusiveOr(with other: Self) {
    self = bitwiseExclusiveOr(with: other)
  }

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

  @inlinable public func dividedAccordingToEuclid(by divisor: Self) -> Self {
    return self / divisor  // @exempt(from: unicode)
  }

  @inlinable public mutating func divideAccordingToEuclid(by divisor: Self) {
    self /= divisor  // @exempt(from: unicode)
  }

  @inlinable public func mod(_ divisor: Self) -> Self {
    return self % divisor
  }

  @inlinable public mutating func formRemainder(mod divisor: Self) {
    self %= divisor
  }

  @inlinable public var isEven: Bool {
    return ¬isOdd
  }

  @inlinable public var isOdd: Bool {
    return self.bitwiseAnd(with: 1) == 1
  }
}

extension BinaryInteger {
  @inlinable internal init<U: UIntFamily>(asBinaryIntegerWithUInt uInt: U) {
    self.init(uInt)
  }
}

// @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
/// Eine natürliche Zahl ohne Vorzeichen. (`UInt`)
public typealias NZahl = UInt
extension UInt: UIntFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
extension UInt64: UIntFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
extension UInt32: UIntFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
extension UInt16: UIntFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
extension UInt8: UIntFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride
}
