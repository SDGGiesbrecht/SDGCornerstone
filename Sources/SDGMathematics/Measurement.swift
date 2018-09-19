/*
 Measurement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that represents a measurement that can be expressed in various units.
///
/// See `Angle` and `CalendarInterval` for examples.
///
/// - Requires: A `Measurement`’s units must be definable as ratios of one another. (For example, `Measurement` can describe angles as radians, degrees and gradians, but not temperature as Kelvins, Celsius and Fahrenheit.)
///
/// Conformance Requirements:
///
/// - `init(rawValue: Scalar)`
/// - `var rawValue: Scalar { get set }`
public protocol Measurement : Negatable, NumericAdditiveArithmetic {

    // MARK: - Scalar Type

    // @documentation(SDGCornerstone.Measurement.Scalar)
    /// The numeric type used to express the value in any given unit.
    associatedtype Scalar : RationalArithmetic

    // MARK: - Internal Values

    // @documentation(SDGCornerstone.Measurement.init(rawValue:))
    /// Creates a measurement from a raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    init(rawValue: Scalar)

    // @documentation(SDGCornerstone.Measurement.rawValue)
    /// A raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    var rawValue: Scalar { get set }

    // MARK: - Initialization

    // @documentation(SDGCornerstone.Measurement.init())
    /// Creates an empty (zero) measurement.
    init()

    // MARK: - Operations

    // @documentation(SDGCornerstone.Measurement.×)
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    static func × (precedingValue: Self, followingValue: Scalar) -> Self

    // @documentation(SDGCornerstone.Measurement.×=)
    /// Modifies the measurement by multiplication with a scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement to modify.
    ///     - followingValue: The scalar.
    static func ×= (precedingValue: inout Self, followingValue: Scalar)

    // @documentation(SDGCornerstone.Measurement.÷(_:scalar:))
    /// Returns the (rational) quotient of a measurement divided by a scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    static func ÷ (precedingValue: Self, followingValue: Scalar) -> Self

    // @documentation(SDGCornerstone.Measurement.÷)
    /// Returns the (rational) scalar quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    static func ÷ (precedingValue: Self, followingValue: Self) -> Scalar

    // @documentation(SDGCornerstone.Measurement.÷=)
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement to modify.
    ///     - followingValue: The scalar divisor.
    static func ÷= (precedingValue: inout Self, followingValue: Scalar)

    // A MEAUSUREMENT IS NOT AN INTEGER WITHOUT AN ARBITRARY SELECTION OF A UNIT, SO *EUCLIDEAN* DIVISON BY A SCALAR IS MEANINGLESS

    // @documentation(SDGCornerstone.Measurement.dividedAccordingToEuclid(by:))
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    func dividedAccordingToEuclid(by divisor: Self) -> Scalar

    // @documentation(SDGCornerstone.Measurement.mod(_:))
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    func mod(_ divisor: Self) -> Self

    // @documentation(SDGCornerstone.Measurement.formRemainder(mod:))
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    mutating func formRemainder(mod divisor: Self)

    // @documentation(SDGCornerstone.Measurement.isDivisible(by:))
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    func isDivisible(by divisor: Self) -> Bool

    // @documentation(SDGCornerstone.Measurement.gcd(_:_:))
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    static func gcd(_ a: Self, _ b: Self) -> Self

    // @documentation(SDGCornerstone.Measurement.formGreatestCommonDivisor(with:))
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    mutating func formGreatestCommonDivisor(with other: Self)

    // @documentation(SDGCornerstone.Measurement.lcm(_:_:))
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    static func lcm(_ a: Self, _ b: Self) -> Self

    // @documentation(SDGCornerstone.Measurement.formLeastCommonMultiple(with:))
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    mutating func formLeastCommonMultiple(with other: Self)

    // MARK: - Rounding

    /// A rule for rounding.
    typealias RoundingRule = WholeArithmetic.RoundingRule

    // @documentation(SDGCornerstone.Measurement.round(_:toMultipleOf:))
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self)

    // @documentation(SDGCornerstone.Measurement.rounded(_:toMultipleOf:))
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self
}

extension Measurement {

    // #documentation(SDGCornerstone.Measurement.init())
    /// Creates an empty (zero) measurement.
    @inlinable public init() {
        self.init(rawValue: 0)
    }

    // #documentation(SDGCornerstone.Measurement.×)
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    @inlinable public static func × (precedingValue: Self, followingValue: Scalar) -> Self {
        return nonmutatingVariant(of: ×=, on: precedingValue, with: followingValue)
    }

    // #documentation(SDGCornerstone.Measurement.×)
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    @inlinable public static func × (precedingValue: Scalar, followingValue: Self) -> Self {
        return followingValue × precedingValue
    }

    // #documentation(SDGCornerstone.Measurement.×=)
    /// Modifies the measurement by multiplication with a scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement to modify.
    ///     - followingValue: The scalar.
    @inlinable public static func ×= (precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.rawValue ×= followingValue
    }

    // #documentation(SDGCornerstone.Measurement.÷(_:scalar:))
    /// Returns the (rational) quotient of a measurement divided by a scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    @inlinable public static func ÷ (precedingValue: Self, followingValue: Scalar) -> Self {
        return nonmutatingVariant(of: ÷=, on: precedingValue, with: followingValue)
    }

    // #documentation(SDGCornerstone.Measurement.÷)
    /// Returns the (rational) scalar quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    @inlinable public static func ÷ (precedingValue: Self, followingValue: Self) -> Scalar {
        return precedingValue.rawValue ÷ followingValue.rawValue
    }

    // #documentation(SDGCornerstone.Measurement.÷=)
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement to modify.
    ///     - followingValue: The scalar divisor.
    @inlinable public static func ÷= (precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.rawValue ÷= followingValue
    }

    // A MEAUSUREMENT IS NOT AN INTEGER WITHOUT AN ARBITRARY SELECTION OF A UNIT, SO *EUCLIDEAN* DIVISON BY A SCALAR IS MEANINGLESS

    // #documentation(SDGCornerstone.Measurement.dividedAccordingToEuclid(by:))
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @inlinable public func dividedAccordingToEuclid(by divisor: Self) -> Scalar {
        return rawValue.dividedAccordingToEuclid(by: divisor.rawValue)
    }

    // #documentation(SDGCornerstone.Measurement.mod(_:))
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @inlinable public func mod(_ divisor: Self) -> Self {
        return nonmutatingVariant(of: { $0.formRemainder(mod: $1) }, on: self, with: divisor)
    }

    // #documentation(SDGCornerstone.Measurement.formRemainder(mod:))
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @inlinable public mutating func formRemainder(mod divisor: Self) {
        rawValue.formRemainder(mod: divisor.rawValue)
    }

    // #documentation(SDGCornerstone.Measurement.isDivisible(by:))
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    @inlinable public func isDivisible(by divisor: Self) -> Bool {
        return rawValue.isDivisible(by: divisor.rawValue)
    }

    // #documentation(SDGCornerstone.Measurement.gcd(_:_:))
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @inlinable public static func gcd(_ a: Self, _ b: Self) -> Self {
        return nonmutatingVariant(of: { $0.formGreatestCommonDivisor(with: $1) }, on: a, with: b)
    }

    // #documentation(SDGCornerstone.Measurement.formGreatestCommonDivisor(with:))
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    @inlinable public mutating func formGreatestCommonDivisor(with other: Self) {
        rawValue.formGreatestCommonDivisor(with: other.rawValue)
    }

    // #documentation(SDGCornerstone.Measurement.lcm(_:_:))
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @inlinable public static func lcm(_ a: Self, _ b: Self) -> Self {
        return nonmutatingVariant(of: { $0.formLeastCommonMultiple(with: $1) }, on: a, with: b)
    }

    // #documentation(SDGCornerstone.Measurement.formLeastCommonMultiple(with:))
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    @inlinable public mutating func formLeastCommonMultiple(with other: Self) {
        rawValue.formLeastCommonMultiple(with: other.rawValue)
    }

    // #documentation(SDGCornerstone.Measurement.round(_:toMultipleOf:))
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @inlinable public mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self) {
        rawValue.round(rule, toMultipleOf: factor.rawValue)
    }

    // #documentation(SDGCornerstone.Measurement.rounded(_:toMultipleOf:))
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @inlinable public func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self {
        return nonmutatingVariant(of: { $0.round($1, toMultipleOf: $2) }, on: self, with: (rule, factor))
    }

    // MARK: - Addable

    // #documentation(SDGCornerstone.Addable(Summation).+)
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @inlinable public static func + (precedingValue: Self, followingValue: Self) -> Self {
        return Self(rawValue: precedingValue.rawValue + followingValue.rawValue)
    }

    // #documentation(SDGCornerstone.Addable(Summation).+=)
    /// Adds the following value to the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    @inlinable public static func += (precedingValue: inout Self, followingValue: Self) {
        precedingValue.rawValue += followingValue.rawValue
    }

    // MARK: - AdditiveArithmetic

    // #documentation(SDGCornerstone.AdditiveArithmetic.additiveIdentity)
    /// The additive identity (origin).
    @inlinable public static var additiveIdentity: Self {
        return Self(rawValue: 0)
    }

    // MARK: - Comparable

    // #documentation(SDGCornerstone.Comparable.<)
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @inlinable public static func < (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue < followingValue.rawValue
    }

    // MARK: - Equatable

    // #documentation(SDGCornerstone.Equatable.==)
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @inlinable public static func == (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue == followingValue.rawValue
    }

    // MARK: - Hashable

    // #documentation(SDGCornerstone.Hashable.hashValue)
    /// The hash value.
    @inlinable public var hashValue: Int {
        return rawValue.hashValue
    }

    // MARK: - Negatable

    // #documentation(SDGCornerstone.Negatable.−)
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    @inlinable public static prefix func − (operand: Self) -> Self {
        return Self(rawValue: −operand.rawValue)
    }

    // #documentation(SDGCornerstone.Negatable.−=)
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    @inlinable public static postfix func −= (operand: inout Self) {
        operand.rawValue−=
    }

    // MARK: - NumericAdditiveArithmetic

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isPositive)
    /// Returns `true` if `self` is positive.
    @inlinable public var isPositive: Bool {
        return rawValue.isPositive
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isNegative)
    /// Returns `true` if `self` is negative.
    @inlinable public var isNegative: Bool {
        return rawValue.isNegative
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isNonNegative)
    /// Returns `true` if `self` is positive or zero.
    @inlinable public var isNonNegative: Bool {
        return rawValue.isNonNegative
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.isNonPositive)
    /// Returns `true` if `self` is negative or zero.
    @inlinable public var isNonPositive: Bool {
        return rawValue.isNonPositive
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.absoluteValue)
    /// The absolute value.
    @inlinable public var absoluteValue: Self {
        return Self(rawValue: rawValue.absoluteValue)
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue)
    /// Sets `self` to its absolute value.
    @inlinable public mutating func formAbsoluteValue() {
        rawValue.formAbsoluteValue()
    }

    // MARK: - Subtractable

    // #documentation(SDGCornerstone.Subtractable.−)
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return Self(rawValue: precedingValue.rawValue − followingValue.rawValue)
    }

    // #documentation(SDGCornerstone.Subtractable.−=)
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.rawValue −= followingValue.rawValue
    }
}

// MARK: - Measurements

// #documentation(SDGCornerstone.Measurement.gcd(_:_:))
/// Returns the greatest common divisor of `a` and `b`.
///
/// - Parameters:
///     - precedingValue: A value.
///     - followingValue: Another value.
@inlinable public func gcd<M : Measurement>(_ a: M, _ b: M) -> M {
    return M.gcd(a, b)
}

// #documentation(SDGCornerstone.Measurement.lcm(_:_:))
/// Returns the least common multiple of `a` and `b`.
///
/// - Parameters:
///     - precedingValue: A value.
///     - followingValue: Another value.
@inlinable public func lcm<M : Measurement>(_ a: M, _ b: M) -> M {
    return M.lcm(a, b)
}

/// A type that conforms to `Codable` through its `Measurement` interface.
///
/// Coding occurs via the `rawValue` property. If its scale changes, the provided implementation will not be backwards compatible.
///
/// Conformance Requirements:
///
/// - `Measurement`
public protocol CodableViaMeasurement : Measurement {

}

extension CodableViaMeasurement {

    // These will be inlined by the conformance declaration in the module which declares the conformance. Only those inlined specializations will ever be called.

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @inlinable public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @inlinable public init(from decoder: Decoder) throws {
        try self.init(rawValue: Scalar(from: decoder))
    }
}
