/*
 WholeArithmeticCore.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used for whole‐number arithmetic.
///
/// Conformance Requirements:
///
/// - `NumericAdditiveArithmetic`
/// - `FixedScaleOneDimensionalPoint`
/// - `init(_ uInt: UIntMax)`
/// - `init?<T>(exactly source: T) where T : BinaryInteger`
/// - `static func ×= (precedingValue: inout Self, followingValue: Self)`
/// - `mutating func divideAccordingToEuclid(by divisor: Self)`
/// - `WholeNumberProtocol`, `IntegerProtocol`, `RationalNumberProtocol` or `static func ↑= (precedingValue: inout Self, followingValue: Self)`
public protocol WholeArithmeticCore : FixedScaleOneDimensionalPoint, Numeric, NumericAdditiveArithmetic {

    // MARK: - Initialization

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(uInt:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of `UIntMax`.
    init(_ uInt: UIntMax)

    // MARK: - Operations

    // [_Workaround: Duplicates Subtractable, but works around disambiguation bugs. (Swift 4.0.3)_]
    /// :nodoc:
    static func − (precedingValue: Self, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    static func × (precedingValue: Self, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    static func ×= (precedingValue: inout Self, followingValue: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    mutating func divideAccordingToEuclid(by divisor: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    func dividedAccordingToEuclid(by divisor: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    func mod(_ divisor: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    mutating func formRemainder(mod divisor: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.isDivisible(by:)_]
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    func isDivisible(by divisor: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.gcd(_:_:)_]
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    static func gcd(_ a: Self, _ b: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.formGreatestCommonDivisor(with:)_]
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    mutating func formGreatestCommonDivisor(with other: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.lcm(_:_:)_]
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    static func lcm(_ a: Self, _ b: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.formLeastCommonMultiple(with:)_]
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    mutating func formLeastCommonMultiple(with other: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.↑_]
    /// Returns the result of the preceding value to the power of the following value.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `followingValue` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `followingValue` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
    ///     - `precedingValue` must be positive, or
    ///     - `followingValue` must be an integer.
    ///
    /// - Parameters:
    ///     - precedingValue: The base.
    ///     - followingValue: The exponent.
    static func ↑ (precedingValue: Self, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the preceding value by exponentiation with the following value.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `followingValue` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `followingValue` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
    ///     - `precedingValue` must be positive, or
    ///     - `followingValue` must be an integer.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The exponent.
    static func ↑= (precedingValue: inout Self, followingValue: Self)

    // MARK: - Classification

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.isNatural_]
    /// Returns `true` if `self` is a natural number.
    var isNatural: Bool { get }

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.isWhole_]
    /// Returns `true` if `self` is a whole number.
    var isWhole: Bool { get }

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.isIntegral_]
    /// Returns `true` if `self` is an integer.
    var isIntegral: Bool { get }

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.isEven_]
    /// Returns true if `self` is an even integer.
    var isEven: Bool { get }

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.isOdd_]
    /// Returns true if `self` is an odd integer.
    var isOdd: Bool { get }

    // MARK: - Rounding

    /// A rule for rounding.
    typealias RoundingRule = FloatingPointRoundingRule

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    mutating func round(_ rule: RoundingRule)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    func rounded(_ rule: RoundingRule) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:)_]
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self
}

extension WholeArithmeticCore {

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(uIntFamily:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of a type conforming to `UIntFamily`.
    @_inlineable public init<U : UIntFamilyCore>(_ uInt: U) {
        self.init(UIntMax(uInt))
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func × (precedingValue: Self, followingValue: Self) -> Self {
        return nonmutatingVariant(of: ×=, on: precedingValue, with: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @_inlineable public func dividedAccordingToEuclid(by divisor: Self) -> Self {
        return nonmutatingVariant(of: Self.divideAccordingToEuclid, on: self, with: divisor)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @_inlineable public func mod(_ divisor: Self) -> Self {
        return nonmutatingVariant(of: Self.formRemainder, on: self, with: divisor)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    @_inlineable public mutating func formRemainder(mod divisor: Self) {
        self −= dividedAccordingToEuclid(by: divisor) × divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isDivisible(by:)_]
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    @_inlineable public func isDivisible(by divisor: Self) -> Bool {
        return mod(divisor) == 0
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.gcd(_:_:)_]
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func gcd(_ a: Self, _ b: Self) -> Self {
        return nonmutatingVariant(of: Self.formGreatestCommonDivisor, on: a, with: b)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formGreatestCommonDivisor(with:)_]
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    @_inlineable public mutating func formGreatestCommonDivisor(with other: Self) {
        if self.isNegative ∨ other.isNegative {
            self.formAbsoluteValue()
            formGreatestCommonDivisor(with: |other|)
        } else if other == 0 /* finished */ {
            // self = self
        } else {
            self = Self.gcd(other, mod(other))
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.lcm(_:_:)_]
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func lcm(_ a: Self, _ b: Self) -> Self {
        return nonmutatingVariant(of: Self.formLeastCommonMultiple, on: a, with: b)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formLeastCommonMultiple(with:)_]
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    @_inlineable public mutating func formLeastCommonMultiple(with other: Self) {
        self ×= other.dividedAccordingToEuclid(by: Self.gcd(self, other))
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑_]
    /// Returns the result of the preceding value to the power of the following value.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `followingValue` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `followingValue` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
    ///     - `precedingValue` must be positive, or
    ///     - `followingValue` must be an integer.
    ///
    /// - Parameters:
    ///     - precedingValue: The base.
    ///     - followingValue: The exponent.
    @_inlineable public static func ↑ (precedingValue: Self, followingValue: Self) -> Self {
        return nonmutatingVariant(of: ↑=, on: precedingValue, with: followingValue)
    }

    @_inlineable @_versioned internal mutating func raiseWholeNumberToThePowerOf(wholeNumber exponent: Self) {
        if exponent == 0 {
            self = 1
        } else if exponent == 1 {
            // self = self
        } else if exponent.isEven {
            // p = (b ↑ 2) ↑ (e ÷ 2)
            self ×= self
            self ↑= (exponent.dividedAccordingToEuclid(by: 2))
        } else /* followingValue.isOdd */ {
            // p = b × b ↑ (e − 1)
            self ×= (self ↑ (exponent − (1 as Self)))
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isNatural_]
    /// Returns `true` if `self` is a natural number.
    @_inlineable public var isNatural: Bool {
        return isWhole ∧ self ≠ 0
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isWhole_]
    /// Returns `true` if `self` is a whole number.
    @_inlineable public var isWhole: Bool {
        return isIntegral ∧ isNonNegative
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isIntegral_]
    /// Returns `true` if `self` is an integer.
    @_inlineable public var isIntegral: Bool {
        return isDivisible(by: 1)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isEven_]
    /// Returns true if `self` is an even integer.
    @_inlineable public var isEven: Bool {
        return isDivisible(by: 2)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isOdd_]
    /// Returns true if `self` is an odd integer.
    @_inlineable public var isOdd: Bool {
        return isIntegral ∧ ¬isEven
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @_inlineable public mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self) {
        switch rule {
        case .down:
            self.divideAccordingToEuclid(by: factor)
            self ×= factor
        case .up:
            if ¬isDivisible(by: factor) {
                round(.down, toMultipleOf: factor)
                self += factor
            }
        case .towardZero:
            if isNegative {
                round(.up, toMultipleOf: factor)
            } else {
                round(.down, toMultipleOf: factor)
            }
        case .awayFromZero:
            if isNegative {
                round(.down, toMultipleOf: factor)
            } else {
                round(.up, toMultipleOf: factor)
            }
        default:
            let floor = rounded(.down, toMultipleOf: factor)
            let portion: Self = self − floor
            let double = portion × 2

            if double < factor /* portion < half */ {
                self = floor
            } else if double > factor /* portion > half */ {
                self = floor + factor
            } else {
                // portion == half
                switch rule {
                case .toNearestOrAwayFromZero:
                    if isNegative {
                        self = floor
                    } else {
                        self = floor + factor
                    }
                case .toNearestOrEven:
                    if floor.dividedAccordingToEuclid(by: factor).isEven {
                        self = floor
                    } else {
                        self = floor + factor
                    }
                default:
                    _unreachable()
                }
            }
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:)_]
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @_inlineable public func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self {
        return nonmutatingVariant(of: Self.round, on: self, with: (rule, factor))
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @_inlineable public mutating func round(_ rule: RoundingRule) {
        round(rule, toMultipleOf: 1)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @_inlineable public func rounded(_ rule: RoundingRule) -> Self {
        return nonmutatingVariant(of: Self.round, on: self, with: rule)
    }

    // MARK: - Numeric

    // [_Define Documentation: SDGCornerstone.Numeric.init(exactly:)_]
    /// Creates a new instance from the given integer, if it can be represented exactly.

    /// Multiplies two values and produces their product.
    @_transparent public static func * (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue × followingValue
    }

    /// Multiplies two values and stores the result in the left‐hand‐side variable.
    @_transparent public static func *= (precedingValue: inout Self, followingValue: Self) {
        precedingValue ×= followingValue
    }
}

// MARK: - Whole Arithmetic

// [_Inherit Documentation: SDGCornerstone.WholeArithmetic.gcd(_:_:)_]
/// Returns the greatest common divisor of `a` and `b`.
///
/// - Parameters:
///     - precedingValue: A value.
///     - followingValue: Another value.
@_transparent public func gcd<N : WholeArithmeticCore>(_ a: N, _ b: N) -> N {
    return N.gcd(a, b)
}

// [_Inherit Documentation: SDGCornerstone.WholeArithmetic.lcm(_:_:)_]
/// Returns the least common multiple of `a` and `b`.
///
/// - Parameters:
///     - precedingValue: A value.
///     - followingValue: Another value.
@_transparent public func lcm<N : WholeArithmeticCore>(_ a: N, _ b: N) -> N {
    return N.lcm(a, b)
}
