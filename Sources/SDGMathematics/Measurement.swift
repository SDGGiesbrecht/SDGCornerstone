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

    // [_Define Documentation: SDGCornerstone.Measurement.Scalar_]
    /// The numeric type used to express the value in any given unit.
    associatedtype Scalar : RationalArithmetic

    // MARK: - Internal Values

    // [_Define Documentation: SDGCornerstone.Measurement.init(rawValue:)_]
    /// Creates a measurement from a raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    init(rawValue: Scalar)

    // [_Define Documentation: SDGCornerstone.Measurement.rawValue_]
    /// A raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    var rawValue: Scalar { get set }

    // MARK: - Initialization

    // [_Define Documentation: SDGCornerstone.Measurement.init()_]
    /// Creates an empty (zero) measurement.
    init()

    // MARK: - Operations

    // [_Define Documentation: SDGCornerstone.Measurement.×_]
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    static func × (precedingValue: Self, followingValue: Scalar) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.×=_]
    /// Modifies the measurement by multiplication with a scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement to modify.
    ///     - followingValue: The scalar.
    static func ×= (precedingValue: inout Self, followingValue: Scalar)

    // [_Define Documentation: SDGCornerstone.Measurement.÷(_:scalar:)_]
    /// Returns the (rational) quotient of a measurement divided by a scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    static func ÷ (precedingValue: Self, followingValue: Scalar) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.÷_]
    /// Returns the (rational) scalar quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    static func ÷ (precedingValue: Self, followingValue: Self) -> Scalar

    // [_Define Documentation: SDGCornerstone.Measurement.÷=_]
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement to modify.
    ///     - followingValue: The scalar divisor.
    static func ÷= (precedingValue: inout Self, followingValue: Scalar)

    // A MEAUSUREMENT IS NOT AN INTEGER WITHOUT AN ARBITRARY SELECTION OF A UNIT, SO *EUCLIDEAN* DIVISON BY A SCALAR IS MEANINGLESS

    // [_Define Documentation: SDGCornerstone.Measurement.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    func dividedAccordingToEuclid(by divisor: Self) -> Scalar

    // [_Define Documentation: SDGCornerstone.Measurement.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    func mod(_ divisor: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    mutating func formRemainder(mod divisor: Self)

    // [_Define Documentation: SDGCornerstone.Measurement.isDivisible(by:)_]
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    func isDivisible(by divisor: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.Measurement.gcd(_:_:)_]
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    static func gcd(_ a: Self, _ b: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.formGreatestCommonDivisor(with:)_]
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    mutating func formGreatestCommonDivisor(with other: Self)

    // [_Define Documentation: SDGCornerstone.Measurement.lcm(_:_:)_]
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    static func lcm(_ a: Self, _ b: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.formLeastCommonMultiple(with:)_]
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    mutating func formLeastCommonMultiple(with other: Self)

    // MARK: - Rounding

    /// A rule for rounding.
    typealias RoundingRule = WholeArithmetic.RoundingRule

    // [_Define Documentation: SDGCornerstone.Measurement.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self)

    // [_Define Documentation: SDGCornerstone.Measurement.rounded(_:toMultipleOf:)_]
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self
}

extension Measurement {

    // [_Inherit Documentation: SDGCornerstone.Measurement.init()_]
    /// Creates an empty (zero) measurement.
    @_inlineable public init() {
        self.init(rawValue: 0)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.×_]
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    @_inlineable public static func × (precedingValue: Self, followingValue: Scalar) -> Self {
        return nonmutatingVariant(of: ×=, on: precedingValue, with: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.×_]
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    @_transparent public static func × (precedingValue: Scalar, followingValue: Self) -> Self {
        return followingValue × precedingValue
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.×=_]
    /// Modifies the measurement by multiplication with a scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement to modify.
    ///     - followingValue: The scalar.
    @_inlineable public static func ×= (precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.rawValue ×= followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.÷(_:scalar:)_]
    /// Returns the (rational) quotient of a measurement divided by a scalar.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement.
    ///     - followingValue: The scalar.
    @_inlineable public static func ÷ (precedingValue: Self, followingValue: Scalar) -> Self {
        return nonmutatingVariant(of: ÷=, on: precedingValue, with: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.÷_]
    /// Returns the (rational) scalar quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    @_inlineable public static func ÷ (precedingValue: Self, followingValue: Self) -> Scalar {
        return precedingValue.rawValue ÷ followingValue.rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.÷=_]
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The measurement to modify.
    ///     - followingValue: The scalar divisor.
    @_inlineable public static func ÷= (precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.rawValue ÷= followingValue
    }

    // A MEAUSUREMENT IS NOT AN INTEGER WITHOUT AN ARBITRARY SELECTION OF A UNIT, SO *EUCLIDEAN* DIVISON BY A SCALAR IS MEANINGLESS

    // [_Inherit Documentation: SDGCornerstone.Measurement.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @_inlineable public func dividedAccordingToEuclid(by divisor: Self) -> Scalar {
        return rawValue.dividedAccordingToEuclid(by: divisor.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @_inlineable public func mod(_ divisor: Self) -> Self {
        return nonmutatingVariant(of: Self.formRemainder, on: self, with: divisor)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @_inlineable public mutating func formRemainder(mod divisor: Self) {
        rawValue.formRemainder(mod: divisor.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.isDivisible(by:)_]
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    @_inlineable public func isDivisible(by divisor: Self) -> Bool {
        return rawValue.isDivisible(by: divisor.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.gcd(_:_:)_]
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func gcd(_ a: Self, _ b: Self) -> Self {
        return nonmutatingVariant(of: Self.formGreatestCommonDivisor, on: a, with: b)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.formGreatestCommonDivisor(with:)_]
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    @_inlineable public mutating func formGreatestCommonDivisor(with other: Self) {
        rawValue.formGreatestCommonDivisor(with: other.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.lcm(_:_:)_]
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func lcm(_ a: Self, _ b: Self) -> Self {
        return nonmutatingVariant(of: Self.formLeastCommonMultiple, on: a, with: b)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.formLeastCommonMultiple(with:)_]
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    @_inlineable public mutating func formLeastCommonMultiple(with other: Self) {
        rawValue.formLeastCommonMultiple(with: other.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @_inlineable public mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self) {
        rawValue.round(rule, toMultipleOf: factor.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.rounded(_:toMultipleOf:)_]
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @_inlineable public func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self {
        return nonmutatingVariant(of: Self.round, on: self, with: (rule, factor))
    }

    // MARK: - Addable

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func + (precedingValue: Self, followingValue: Self) -> Self {
        return Self(rawValue: precedingValue.rawValue + followingValue.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+=_]
    /// Adds the following value to the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    @_inlineable public static func += (precedingValue: inout Self, followingValue: Self) {
        precedingValue.rawValue += followingValue.rawValue
    }

    // MARK: - AdditiveArithmetic

    // [_Inherit Documentation: SDGCornerstone.AdditiveArithmetic.additiveIdentity_]
    /// The additive identity (origin).
    @_inlineable public static var additiveIdentity: Self {
        return Self(rawValue: 0)
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func < (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue < followingValue.rawValue
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func == (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue == followingValue.rawValue
    }

    // MARK: - Hashable

    // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
    /// The hash value.
    @_inlineable public var hashValue: Int {
        return rawValue.hashValue
    }

    // MARK: - Negatable

    // [_Inherit Documentation: SDGCornerstone.Negatable.−_]
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    @_inlineable public static prefix func − (operand: Self) -> Self {
        return Self(rawValue: −operand.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    @_inlineable public static postfix func −= (operand: inout Self) {
        operand.rawValue−=
    }

    // MARK: - NumericAdditiveArithmetic

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isPositive_]
    /// Returns `true` if `self` is positive.
    @_inlineable public var isPositive: Bool {
        return rawValue.isPositive
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    @_inlineable public var isNegative: Bool {
        return rawValue.isNegative
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    @_inlineable public var isNonNegative: Bool {
        return rawValue.isNonNegative
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNonPositive_]
    /// Returns `true` if `self` is negative or zero.
    @_inlineable public var isNonPositive: Bool {
        return rawValue.isNonPositive
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    @_inlineable public var absoluteValue: Self {
        return Self(rawValue: rawValue.absoluteValue)
    }

    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    @_inlineable public mutating func formAbsoluteValue() {
        rawValue.formAbsoluteValue()
    }

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @_inlineable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return Self(rawValue: precedingValue.rawValue − followingValue.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    @_inlineable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.rawValue −= followingValue.rawValue
    }
}

// MARK: - Measurements

// [_Inherit Documentation: SDGCornerstone.Measurement.gcd(_:_:)_]
/// Returns the greatest common divisor of `a` and `b`.
///
/// - Parameters:
///     - precedingValue: A value.
///     - followingValue: Another value.
@_transparent public func gcd<M : Measurement>(_ a: M, _ b: M) -> M {
    return M.gcd(a, b)
}

// [_Inherit Documentation: SDGCornerstone.Measurement.lcm(_:_:)_]
/// Returns the least common multiple of `a` and `b`.
///
/// - Parameters:
///     - precedingValue: A value.
///     - followingValue: Another value.
@_transparent public func lcm<M : Measurement>(_ a: M, _ b: M) -> M {
    return M.lcm(a, b)
}

/// A type that conforms to `Codable` through its `Measurement` interface.
///
/// Coding occurs via the `rawValue` property. If its scale changes, the provided implementation will not be backwards compatible.
///
/// Conformance Requirements:
///     - `Measurement`
public protocol CodableViaMeasurement : Measurement {

}

extension CodableViaMeasurement {

    // These will be inlined by the conformance declaration in the module which declares the conformance. Only those inlined specializations will ever be called.

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @_inlineable public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @_inlineable public init(from decoder: Decoder) throws {
        try self.init(rawValue: Scalar(from: decoder))
    }
}
