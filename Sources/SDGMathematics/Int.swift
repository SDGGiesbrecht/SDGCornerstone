/*
 Int.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    // [_Inherit Documentation: SDGCornerstone.IntegralArithmetic.init(intFamily:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of a member of the `Int` family.
    @_inlineable public init<I : IntFamily>(_ int: I) {
        self.init(asBinaryIntegerWithInt: int)
    }

    // MARK: - Negatable

    // [_Inherit Documentation: SDGCornerstone.Negatable.−_]
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    @_inlineable public static prefix func − (operand: Self) -> Self {
        return -operand
    }

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    @_inlineable public static postfix func −= (operand: inout Self) {
        operand.negate()
    }

    // MARK: - NumericAdditiveArithmetic

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    @_inlineable public var absoluteValue: Self {
        return abs(self)
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    @_inlineable public mutating func formAbsoluteValue() {
        self = abs(self)
    }

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @_inlineable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    @_inlineable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue -= followingValue
    }

    // MARK: - WholeArithmetic

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(uIntFamily:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of a type conforming to `UIntFamily`.
    @_inlineable public init<U : UIntFamily>(_ uInt: U) {
        self.init(asBinaryIntegerWithUInt: uInt)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func × (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue * followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    @_inlineable public static func ×= (precedingValue: inout Self, followingValue: Self) {
        precedingValue *= followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @_inlineable public mutating func divideAccordingToEuclid(by divisor: Self) {

        let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

        let needsToWrapToPrevious = negative ∧ self % divisor ≠ 0
        // Wrap to previous if negative (ignoring when exactly even)

        // func divideAccordingToEuclid
        self /= divisor

        if needsToWrapToPrevious {
            self −= 1 as Self
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isEven_]
    /// Returns true if `self` is an even integer.
    @_inlineable public var isEven: Bool {
        return ¬isOdd
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isOdd_]
    /// Returns true if `self` is an odd integer.
    @_inlineable public var isOdd: Bool {
        return self & 1 == 1
    }
}

extension IntXFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to add.
    @_inlineable public static func + (precedingValue: Self, followingValue: Vector) -> Self {
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
    @_inlineable public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        return followingValue.distance(to: precedingValue)
    }
}

extension BinaryInteger {
    @_inlineable @_versioned internal init<I : IntFamily>(asBinaryIntegerWithInt int: I) {
        self.init(int)
    }
}

extension Int : IntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - Subtractible

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @_inlineable public static func − (precedingValue: Int, followingValue: Int) -> Int {
        return precedingValue - followingValue
    }
}
extension Int64 : IntXFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension Int32 : IntXFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension Int16 : IntXFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
extension Int8 : IntXFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}
