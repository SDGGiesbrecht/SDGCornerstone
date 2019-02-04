/*
 Measurement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    /// Creates a measurement from a raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    ///
    /// - Parameters:
    ///     - rawValue: The raw value.
    init(rawValue: Scalar)

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
    ///
    /// - Parameters:
    ///     - divisor: The divisor to check.
    func isDivisible(by divisor: Self) -> Bool

    // @documentation(SDGCornerstone.Measurement.gcd(_:_:))
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - a: A value.
    ///     - b: Another value.
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
    ///     - a: A value.
    ///     - b: Another value.
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
    ///
    /// - Parameters:
    ///     - divisor: The divisor to check.
    @inlinable public func isDivisible(by divisor: Self) -> Bool {
        return rawValue.isDivisible(by: divisor.rawValue)
    }

    // #documentation(SDGCornerstone.Measurement.gcd(_:_:))
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - a: A value.
    ///     - b: Another value.
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
    ///     - a: A value.
    ///     - b: Another value.
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

    // @documentation(SDGCornerstone.Measurement.init(randomInRange:))
    /// Returns a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @inlinable public static func random(in range: Range<Self>) -> Self {
        var generator = SystemRandomNumberGenerator()
        return random(in: range, using: &generator)
    }

    // #documentation(SDGCornerstone.Measurement.init(randomInRange:))
    /// Returns a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @inlinable public static func random(in range: ClosedRange<Self>) -> Self {
        var generator = SystemRandomNumberGenerator()
        return random(in: range, using: &generator)
    }

    // @documentation(SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - generator: The randomizer to use to generate the random value.
    @inlinable public static func random<R>(in range: Range<Self>, using generator: inout R) -> Self where R : RandomNumberGenerator {
        let scalar = Scalar.random(in: range.lowerBound.rawValue ..< range.upperBound.rawValue, using: &generator)
        return Self(rawValue: scalar)
    }

    // #documentation(SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - generator: The randomizer to use to generate the random value.
    @inlinable public static func random<R>(in range: ClosedRange<Self>, using generator: inout R) -> Self where R : RandomNumberGenerator {
        let scalar = Scalar.random(in: range.lowerBound.rawValue ... range.upperBound.rawValue, using: &generator)
        return Self(rawValue: scalar)
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

    @inlinable public static func < (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue < followingValue.rawValue
    }

    // MARK: - Equatable

    @inlinable public static func == (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue == followingValue.rawValue
    }

    // MARK: - Hashable

    // #documentation(SDGCornerstone.Hashable.hash(into:))
    /// Hashes the essential components of this value by feeding them into the given hasher.
    @inlinable public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }

    // MARK: - Negatable

    @inlinable public static prefix func − (operand: Self) -> Self {
        return Self(rawValue: −operand.rawValue)
    }

    @inlinable public mutating func negate() {
        rawValue.negate()
    }

    // MARK: - NumericAdditiveArithmetic

    @inlinable public var isPositive: Bool {
        return rawValue.isPositive
    }

    @inlinable public var isNegative: Bool {
        return rawValue.isNegative
    }

    @inlinable public var isNonNegative: Bool {
        return rawValue.isNonNegative
    }

    @inlinable public var isNonPositive: Bool {
        return rawValue.isNonPositive
    }

    @inlinable public var absoluteValue: Self {
        return Self(rawValue: rawValue.absoluteValue)
    }

    @inlinable public mutating func formAbsoluteValue() {
        rawValue.formAbsoluteValue()
    }

    // MARK: - Subtractable

    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return Self(rawValue: precedingValue.rawValue − followingValue.rawValue)
    }

    @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.rawValue −= followingValue.rawValue
    }
}

// MARK: - Measurements

// #documentation(SDGCornerstone.Measurement.gcd(_:_:))
/// Returns the greatest common divisor of `a` and `b`.
///
/// - Parameters:
///     - a: A value.
///     - b: Another value.
@inlinable public func gcd<M : Measurement>(_ a: M, _ b: M) -> M {
    return M.gcd(a, b)
}

// #documentation(SDGCornerstone.Measurement.lcm(_:_:))
/// Returns the least common multiple of `a` and `b`.
///
/// - Parameters:
///     - a: A value.
///     - b: Another value.
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
public protocol CodableViaMeasurement : Measurement {}

extension CodableViaMeasurement {

    // These will be inlined by the conformance declaration in the module which declares the conformance. Only those inlined specializations will ever be called.

    @inlinable public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }

    @inlinable public init(from decoder: Decoder) throws {
        try self.init(rawValue: Scalar(from: decoder))
    }
}
