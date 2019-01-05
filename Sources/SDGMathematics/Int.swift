/*
 Int.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The member of the `Int` family with the largest bit field.
public typealias IntMax = Int64

/// A member of the `Int` family: `Int`, `Int64`, `Int32`, `Int16` or `Int8`.
public protocol IntFamily : CustomReflectable, CVarArg, FixedWidthInteger, IntegerProtocol, MirrorPath, SignedInteger {

}
/// A numbered member of the `Int` family: `Int64`, `Int32`, `Int16` or `Int8`.
public protocol IntXFamily : IntFamily {

}

extension IntFamily {

    // MARK: - IntegralArithmetic

    // #documentation(SDGCornerstone.IntegralArithmetic.init(intFamily:))
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of a member of the `Int` family.
    @inlinable public init<I : IntFamily>(_ int: I) {
        self.init(asBinaryIntegerWithInt: int)
    }

    // MARK: - Negatable

    // #documentation(SDGCornerstone.Negatable.−)
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    @inlinable public static prefix func − (operand: Self) -> Self {
        return -operand
    }

    // MARK: - NumericAdditiveArithmetic

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.absoluteValue)
    /// The absolute value.
    @inlinable public var absoluteValue: Self {
        return abs(self)
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue)
    /// Sets `self` to its absolute value.
    @inlinable public mutating func formAbsoluteValue() {
        self = abs(self)
    }

    // MARK: - Subtractable

    // #documentation(SDGCornerstone.Subtractable.−)
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue
    }

    // #documentation(SDGCornerstone.Subtractable.−=)
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue -= followingValue
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
        return precedingValue * followingValue
    }

    // #documentation(SDGCornerstone.WholeArithmetic.×=)
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    @inlinable public static func ×= (precedingValue: inout Self, followingValue: Self) {
        precedingValue *= followingValue
    }

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

        // func divideAccordingToEuclid
        self /= divisor

        if needsToWrapToPrevious {
            self −= 1 as Self
        }
    }

    // #documentation(SDGCornerstone.WholeArithmetic.isEven)
    /// Returns true if `self` is an even integer.
    @inlinable public var isEven: Bool {
        return ¬isOdd
    }

    // #documentation(SDGCornerstone.WholeArithmetic.isOdd)
    /// Returns true if `self` is an odd integer.
    @inlinable public var isOdd: Bool {
        return self & 1 == 1
    }
}

extension IntXFamily {

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
}

extension BinaryInteger {
    @inlinable internal init<I : IntFamily>(asBinaryIntegerWithInt int: I) {
        self.init(int)
    }
}

extension Int : IntFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - Subtractible

    // #documentation(SDGCornerstone.Subtractable.−)
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @inlinable public static func − (precedingValue: Int, followingValue: Int) -> Int {
        return precedingValue - followingValue
    }
}
extension Int64 : IntXFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension Int32 : IntXFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension Int16 : IntXFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension Int8 : IntXFamily {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
