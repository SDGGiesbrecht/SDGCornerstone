/*
 UInt.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The member of the `UInt` family with the largest bit field.
public typealias UIntMax = UInt64

/// A type that represents a fixed‐length unsigned integer.
///
/// This protocol exists so that extensions to it can provide shared functionality for `UInt`, `UInt64`, `UInt32`, `UInt16` and `UInt8`.
public protocol UIntFamily : BitField, CustomReflectable, CVarArg, FixedWidthInteger, UnsignedInteger, WholeNumberProtocol {}

extension UIntFamily {

    // MARK: - BitField

    // #documentation(SDGCornerstone.BitField.bitwiseNot())
    /// Returns the bits not present in `self`.
    @inlinable public func bitwiseNot() -> Self {
        return ~self
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseNot())
    /// Inverts the bits.
    @inlinable public mutating func formBitwiseNot() {
        self = bitwiseNot()
    }

    // #documentation(SDGCornerstone.BitField.bitwiseAnd(with:))
    /// Returns the bits present in both `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public func bitwiseAnd(with other: Self) -> Self {
        return self & other
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseAnd(with:))
    /// Removes the bits not also present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public mutating func formBitwiseAnd(with other: Self) {
        self = bitwiseAnd(with: other)
    }

    // #documentation(SDGCornerstone.BitField.bitwiseOr(with:))
    /// Returns the bits present in either `self` or `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public func bitwiseOr(with other: Self) -> Self {
        return self | other
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseOr(with:))
    /// Inserts the bits present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public mutating func formBitwiseOr(with other: Self) {
        self = bitwiseOr(with: other)
    }

    // #documentation(SDGCornerstone.BitField.bitwiseExclusiveOr(with:))
    /// Returns the bits present only in `self` or only in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public func bitwiseExclusiveOr(with other: Self) -> Self {
        return self ^ other
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseExclusiveOr(with:))
    /// Inserts the bits present in `other` and removes the bits present in both.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public mutating func formBitwiseExclusiveOr(with other: Self) {
        self = bitwiseExclusiveOr(with: other)
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.+)
    /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to add.
    @inlinable public static func + (precedingValue: Self, followingValue: Vector) -> Self {
        return precedingValue.advanced(by: followingValue)
    }

    // #documentation(SDGCornerstone.PointProtocol.+=)
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    @inlinable public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue = precedingValue.advanced(by: followingValue)
    }

    // #documentation(SDGCornerstone.PointProtocol.−)
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        return followingValue.distance(to: precedingValue)
    }

    // MARK: - Subtractable

    // #documentation(SDGCornerstone.Subtractable.−)
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue // @exempt(from: unicode)
    }

    // #documentation(SDGCornerstone.Subtractable.−=)
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue -= followingValue // @exempt(from: unicode)
    }

    // MARK: - WholeArithmetic

    // @documentation(SDGCornerstone.WholeArithmetic.init(uIntFamily:))
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of a type conforming to `UIntFamily`.
    @inlinable public init<U : UIntFamily>(_ uInt: U) {
        self.init(asBinaryIntegerWithUInt: uInt)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.×)
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @inlinable public static func × (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue * followingValue // @exempt(from: unicode)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.×=)
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    @inlinable public static func ×= (precedingValue: inout Self, followingValue: Self) {
        precedingValue *= followingValue // @exempt(from: unicode)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.dividedAccordingToEuclid(by:))
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @inlinable public func dividedAccordingToEuclid(by divisor: Self) -> Self {
        return self / divisor // @exempt(from: unicode)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:))
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @inlinable public mutating func divideAccordingToEuclid(by divisor: Self) {
        self /= divisor // @exempt(from: unicode)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.mod(_:))
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @inlinable public func mod(_ divisor: Self) -> Self {
        return self % divisor
    }

    // #documentation(SDGCornerstone.WholeArithmetic.formRemainder(mod:))
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @inlinable public mutating func formRemainder(mod divisor: Self) {
        self %= divisor
    }

    // #documentation(SDGCornerstone.WholeArithmetic.isEven)
    /// Returns true if `self` is an even integer.
    @inlinable public var isEven: Bool {
        return ¬isOdd
    }

    // #documentation(SDGCornerstone.WholeArithmetic.isOdd)
    /// Returns true if `self` is an odd integer.
    @inlinable public var isOdd: Bool {
        return self.bitwiseAnd(with: 1) == 1
    }
}

extension BinaryInteger {
    @inlinable internal init<U : UIntFamily>(asBinaryIntegerWithUInt uInt: U) {
        self.init(uInt)
    }
}

extension UInt : UIntFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension UInt64 : UIntFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension UInt32 : UIntFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension UInt16 : UIntFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension UInt8 : UIntFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
