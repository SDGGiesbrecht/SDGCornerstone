/*
 UInt.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGBinaryData

/// The member of the `UInt` family with the largest bit field.
public typealias UIntMax = UInt64

/// A type that represents a fixed‐length unsigned integer.
///
/// This protocol exists so that extensions to it can provide shared functionality for `UInt`, `UInt64`, `UInt32`, `UInt16` and `UInt8`.
public protocol UIntFamilyCore : BitField, CustomPlaygroundQuickLookable, CustomReflectable, CVarArg, FixedWidthInteger, UnsignedInteger, WholeNumberProtocolCore {

}

extension UIntFamilyCore {

    // MARK: - BitField

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseNot()_]
    /// Returns the bits not present in `self`.
    @_transparent public func bitwiseNot() -> Self {
        return ~self
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.formBitwiseNot()_]
    /// Inverts the bits.
    @_inlineable public mutating func formBitwiseNot() {
        self = bitwiseNot()
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseAnd(with:)_]
    /// Returns the bits present in both `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_transparent public func bitwiseAnd(with other: Self) -> Self {
        return self & other
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.formBitwiseAnd(with:)_]
    /// Removes the bits not also present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseAnd(with other: Self) {
        self = bitwiseAnd(with: other)
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseOr(with:)_]
    /// Returns the bits present in either `self` or `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_transparent public func bitwiseOr(with other: Self) -> Self {
        return self | other
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.formBitwiseOr(with:)_]
    /// Inserts the bits present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseOr(with other: Self) {
        self = bitwiseOr(with: other)
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseExclusiveOr(with:)_]
    /// Returns the bits present only in `self` or only in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_transparent public func bitwiseExclusiveOr(with other: Self) -> Self {
        return self ^ other
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.formBitwiseExclusiveOr(with:)_]
    /// Inserts the bits present in `other` and removes the bits present in both.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseExclusiveOr(with other: Self) {
        self = bitwiseExclusiveOr(with: other)
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to add.
    @_transparent public static func + (precedingValue: Self, followingValue: Vector) -> Self {
        return precedingValue.advanced(by: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    @_inlineable public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue = precedingValue.advanced(by: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    @_transparent public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        return followingValue.distance(to: precedingValue)
    }

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @_transparent public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    @_transparent public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue -= followingValue
    }

    // MARK: - WholeArithmetic

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(uIntFamily:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of a type conforming to `UIntFamily`.
    @_transparent public init<U : UIntFamilyCore>(_ uInt: U) {
        self.init(asBinaryIntegerWithUInt: uInt)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_transparent public static func × (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue * followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    @_transparent public static func ×= (precedingValue: inout Self, followingValue: Self) {
        precedingValue *= followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @_transparent public func dividedAccordingToEuclid(by divisor: Self) -> Self {
        return self / divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @_transparent public mutating func divideAccordingToEuclid(by divisor: Self) {
        self /= divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @_transparent public func mod(_ divisor: Self) -> Self {
        return self % divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @_transparent public mutating func formRemainder(mod divisor: Self) {
        self %= divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isEven_]
    /// Returns true if `self` is an even integer.
    @_inlineable public var isEven: Bool {
        return ¬isOdd
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isOdd_]
    /// Returns true if `self` is an odd integer.
    @_inlineable public var isOdd: Bool {
        return self.bitwiseAnd(with: 1) == 1
    }
}

extension BinaryInteger {
    @_transparent @_versioned internal init<U : UIntFamilyCore>(asBinaryIntegerWithUInt uInt: U) {
        self.init(uInt)
    }
}

extension UInt : UIntFamilyCore {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension UInt64 : UIntFamilyCore {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension UInt32 : UIntFamilyCore {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension UInt16 : UIntFamilyCore {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension UInt8 : UIntFamilyCore {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
