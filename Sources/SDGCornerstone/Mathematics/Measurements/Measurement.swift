/*
 Measurement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
public protocol Measurement : Addable, Comparable, Equatable, Negatable, NumericAdditiveArithmetic {

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
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - MutatingVariant: ×=
    static func × (lhs: Self, rhs: Scalar) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.×=_]
    /// Modifies the measurement by multiplication with a scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement to modify.
    ///     - rhs: The scalar.
    ///
    /// - NonmutatingVariant: ×
    static func ×= (lhs: inout Self, rhs: Scalar)

    // [_Define Documentation: SDGCornerstone.Measurement.÷(_:scalar:)_]
    /// Returns the (rational) quotient of a measurement divided by a scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - MutatingVariant: ×
    static func ÷ (lhs: Self, rhs: Scalar) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.÷_]
    /// Returns the (rational) scalar quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    static func ÷ (lhs: Self, rhs: Self) -> Scalar

    // [_Define Documentation: SDGCornerstone.Measurement.÷=_]
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The measurement to modify.
    ///     - rhs: The scalar divisor.
    ///
    /// - NonmutatingVariant: ÷
    static func ÷= (lhs: inout Self, rhs: Scalar)

    // A MEAUSUREMENT IS NOT AN INTEGER WITHOUT AN ARBITRARY SELECTION OF A UNIT, SO *EUCLIDEAN* DIVISON BY A SCALAR IS MEANINGLESS

    // [_Define Documentation: SDGCornerstone.Measurement.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - MutatingVariant: divideAccordingToEuclid
    func dividedAccordingToEuclid(by divisor: Self) -> Scalar

    // [_Define Documentation: SDGCornerstone.Measurement.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - MutatingVariant: formRemainder
    func mod(_ divisor: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - NonmutatingVariant: mod
    mutating func formRemainder(mod divisor: Self)

    // [_Define Documentation: SDGCornerstone.Measurement.isDivisible(by:)_]
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    func isDivisible(by divisor: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.Measurement.gcd(_:_:)_]
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: formGreatestCommonDivisor
    static func gcd(_ a: Self, _ b: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.formGreatestCommonDivisor(with:)_]
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - NonmutatingVariant: gcd
    mutating func formGreatestCommonDivisor(with other: Self)

    // [_Define Documentation: SDGCornerstone.Measurement.lcm(_:_:)_]
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: formGreatestCommonDivisor
    static func lcm(_ a: Self, _ b: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Measurement.formLeastCommonMultiple(with:)_]
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - NonmutatingVariant: lcm
    mutating func formLeastCommonMultiple(with other: Self)

    // MARK: - Rounding

    /// A rule for rounding.
    typealias RoundingRule = FloatingPointRoundingRule

    // [_Define Documentation: SDGCornerstone.Measurement.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - NonmutatingVariant: rounded
    mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self)

    // [_Define Documentation: SDGCornerstone.Measurement.rounded(_:toMultipleOf:)_]
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - MutatingVariant: round
    func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self

    // MARK: - Randomization

    // [_Define Documentation: SDGCornerstone.Measurement.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: Range<Self>)

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: ClosedRange<Self>)

    // [_Define Documentation: SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer)

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)
}

extension Measurement {

    // [_Inherit Documentation: SDGCornerstone.Measurement.init()_]
    /// Creates an empty (zero) measurement.
    public init() {
        self.init(rawValue: 0)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.×_]
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - MutatingVariant: ×=
    public static func × (lhs: Self, rhs: Scalar) -> Self {
        var result = lhs
        result ×= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.×_]
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - MutatingVariant: ×=
    public static func × (lhs: Scalar, rhs: Self) -> Self {
        return rhs × lhs
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.×=_]
    /// Modifies the measurement by multiplication with a scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement to modify.
    ///     - rhs: The scalar.
    ///
    /// - NonmutatingVariant: ×
    public static func ×= (lhs: inout Self, rhs: Scalar) {
        lhs.rawValue ×= rhs
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.÷(_:scalar:)_]
    /// Returns the (rational) quotient of a measurement divided by a scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - MutatingVariant: ×
    public static func ÷ (lhs: Self, rhs: Scalar) -> Self {
        var result = lhs
        result ÷= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.÷_]
    /// Returns the (rational) scalar quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    public static func ÷ (lhs: Self, rhs: Self) -> Scalar {
        return lhs.rawValue ÷ rhs.rawValue
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.÷=_]
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The measurement to modify.
    ///     - rhs: The scalar divisor.
    ///
    /// - NonmutatingVariant: ÷
    public static func ÷= (lhs: inout Self, rhs: Scalar) {
        lhs.rawValue ÷= rhs
    }

    // A MEAUSUREMENT IS NOT AN INTEGER WITHOUT AN ARBITRARY SELECTION OF A UNIT, SO *EUCLIDEAN* DIVISON BY A SCALAR IS MEANINGLESS

    // [_Inherit Documentation: SDGCornerstone.Measurement.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - MutatingVariant: divideAccordingToEuclid
    public func dividedAccordingToEuclid(by divisor: Self) -> Scalar {
        return rawValue.dividedAccordingToEuclid(by: divisor.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - MutatingVariant: formRemainder
    public func mod(_ divisor: Self) -> Self {
        var result = self
        result.formRemainder(mod: divisor)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - NonmutatingVariant: mod
    public mutating func formRemainder(mod divisor: Self) {
        rawValue.formRemainder(mod: divisor.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.isDivisible(by:)_]
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    public func isDivisible(by divisor: Self) -> Bool {
        return rawValue.isDivisible(by: divisor.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.gcd(_:_:)_]
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: formGreatestCommonDivisor
    public static func gcd(_ a: Self, _ b: Self) -> Self {
        var result = a
        result.formGreatestCommonDivisor(with: b)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.formGreatestCommonDivisor(with:)_]
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - NonmutatingVariant: gcd
    public mutating func formGreatestCommonDivisor(with other: Self) {
        rawValue.formGreatestCommonDivisor(with: other.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.lcm(_:_:)_]
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: formGreatestCommonDivisor
    public static func lcm(_ a: Self, _ b: Self) -> Self {
        var result = a
        result.formLeastCommonMultiple(with: b)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.formLeastCommonMultiple(with:)_]
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - NonmutatingVariant: lcm
    public mutating func formLeastCommonMultiple(with other: Self) {
        rawValue.formLeastCommonMultiple(with: other.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - NonmutatingVariant: rounded
    public mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self) {
        rawValue.round(rule, toMultipleOf: factor.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.rounded(_:toMultipleOf:)_]
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - MutatingVariant: round
    public func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self {
        var result = self
        result.round(rule, toMultipleOf: factor)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: Range<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: ClosedRange<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer) {
        let scalar = Scalar(randomInRange: range.lowerBound.rawValue ..< range.upperBound.rawValue, fromRandomizer: randomizer)
        self.init(rawValue: scalar)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let scalar = Scalar(randomInRange: range.lowerBound.rawValue ... range.upperBound.rawValue, fromRandomizer: randomizer)
        self.init(rawValue: scalar)
    }
}

// MARK: - Measurements

// [_Inherit Documentation: SDGCornerstone.Measurement.gcd(_:_:)_]
/// Returns the greatest common divisor of `a` and `b`.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - MutatingVariant: formGreatestCommonDivisor
public func gcd<M : Measurement>(_ a: M, _ b: M) -> M {
    return M.gcd(a, b)
}

// [_Inherit Documentation: SDGCornerstone.Measurement.lcm(_:_:)_]
/// Returns the least common multiple of `a` and `b`.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - MutatingVariant: formGreatestCommonDivisor
public func lcm<M : Measurement>(_ a: M, _ b: M) -> M {
    return M.lcm(a, b)
}
