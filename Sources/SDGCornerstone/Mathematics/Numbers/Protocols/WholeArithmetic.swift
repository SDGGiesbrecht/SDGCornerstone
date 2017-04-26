/*
 WholeArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
/// Returns the product of the left times the right.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - MutatingVariant: ×=
///
/// - RecommendedOver: *
infix operator ×: MultiplicationPrecedence

// [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×=_]
/// Modifies the left by multiplication with the right.
///
/// - Parameters:
///     - lhs: The value to modify.
///     - rhs: The coefficient by which to multiply.
///
/// - NonmutatingVariant: ×
///
/// - RecommendedOver: *=
infix operator ×=: AssignmentPrecedence

/// A precedence group for exponent operators. (e.g. ↑)
///
/// Precedence: before `MultiplicationPrecedence`
///
/// Associativity: right
precedencegroup ExponentPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

// [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑_]
/// Returns the result of the left to the power of the right.
///
/// - Precondition:
///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
///   - If `Self` conforms to `RealNumberType`, either
///     - `lhs` must be positive, or
///     - `rhs` must be an integer.
///
/// - Parameters:
///     - lhs: The base.
///     - rhs: The exponent.
///
/// - MutatingVariant: ↑=
///
/// - RecommendedOver: pow
infix operator ↑: ExponentPrecedence

// [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
/// Modifies the left by exponentiation with the right.
///
/// - Precondition:
///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
///   - If `Self` conforms to `RealNumberType`, either
///     - `lhs` must be positive, or
///     - `rhs` must be an integer.
///
/// - Parameters:
///     - lhs: The value to modify.
///     - rhs: The exponent.
///
/// - NonmutatingVariant: ↑
infix operator ↑=: AssignmentPrecedence

/// A type that can be used for whole‐number arithmetic.
///
/// Conformance Requirements:
///
/// - `NumericAdditiveArithmetic`
/// - `ExpressibleByIntegerLiteral`
/// - `OneDimensionalPoint`
/// - `init(_ uInt: UIntMax)`
/// - `static func ×= (lhs: inout Self, rhs: Self)`
/// - `mutating func divideAccordingToEuclid(by divisor: Self)`
/// - `WholeNumberType`, `IntegerType`, `RationalNumberType` or `static func ↑= (lhs: inout Self, rhs: Self)`
/// - `init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)`
public protocol WholeArithmetic : ExpressibleByIntegerLiteral, NumericAdditiveArithmetic, OneDimensionalPoint, Strideable {

    // MARK: - Initialization

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(uInt:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of `UIntMax`.
    init(_ uInt: UIntMax)

    // MARK: - Operations

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: ×=
    ///
    /// - RecommendedOver: *
    static func × (lhs: Self, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    ///
    /// - RecommendedOver: *=
    static func ×= (lhs: inout Self, rhs: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - NonmutatingVariant: dividedAccordingToEuclid
    mutating func divideAccordingToEuclid(by divisor: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - MutatingVariant: divideAccordingToEuclid
    func dividedAccordingToEuclid(by divisor: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - MutatingVariant: formRemainder
    func mod(_ divisor: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - NonmutatingVariant: mod
    mutating func formRemainder(mod divisor: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.isDivisible(by:)_]
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    func isDivisible(by divisor: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.gcd(_:_:)_]
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: formGreatestCommonDivisor
    static func gcd(_ a: Self, _ b: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.formGreatestCommonDivisor(with:)_]
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - NonmutatingVariant: gcd
    mutating func formGreatestCommonDivisor(with other: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.lcm(_:_:)_]
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: formGreatestCommonDivisor
    static func lcm(_ a: Self, _ b: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.formLeastCommonMultiple(with:)_]
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - NonmutatingVariant: lcm
    mutating func formLeastCommonMultiple(with other: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.↑_]
    /// Returns the result of the left to the power of the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberType`, either
    ///     - `lhs` must be positive, or
    ///     - `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The base.
    ///     - rhs: The exponent.
    ///
    /// - MutatingVariant: ↑=
    ///
    /// - RecommendedOver: pow
    static func ↑ (lhs: Self, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberType`, either
    ///     - `lhs` must be positive, or
    ///     - `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - NonmutatingVariant: ↑
    static func ↑= (lhs: inout Self, rhs: Self)

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
    ///
    /// - NonmutatingVariant: rounded
    mutating func round(_ rule: RoundingRule)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - MutatingVariant: round
    func rounded(_ rule: RoundingRule) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - NonmutatingVariant: rounded
    mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:)_]
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - MutatingVariant: round
    func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: ClosedRange<Self>)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)
}

extension WholeArithmetic {

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(uIntFamily:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of a type conforming to `UIntFamily`.
    public init<U : UIntFamily>(_ uInt: U) {
        self.init(uInt.toUIntMax())
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: ×=
    ///
    /// - RecommendedOver: *
    public static func × (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ×= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - MutatingVariant: divideAccordingToEuclid
    public func dividedAccordingToEuclid(by divisor: Self) -> Self {
        var result = self
        result.divideAccordingToEuclid(by: divisor)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.mod(_:)_]
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

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - NonmutatingVariant: mod
    public mutating func formRemainder(mod divisor: Self) {
        self −= dividedAccordingToEuclid(by: divisor) × divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isDivisible(by:)_]
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    public func isDivisible(by divisor: Self) -> Bool {
        return mod(divisor) == 0
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.gcd(_:_:)_]
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

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formGreatestCommonDivisor(with:)_]
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - NonmutatingVariant: gcd
    public mutating func formGreatestCommonDivisor(with other: Self) {
        if self.isNegative ∨ other.isNegative {
            self.formAbsoluteValue()
            formGreatestCommonDivisor(with: |other|)
        } else if other == 0 /* finished */ {
            // self = self
        } else {
            self = gcd(other, mod(other))
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.lcm(_:_:)_]
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

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formLeastCommonMultiple(with:)_]
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - NonmutatingVariant: lcm
    public mutating func formLeastCommonMultiple(with other: Self) {
        self ×= other.dividedAccordingToEuclid(by: gcd(self, other))
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑_]
    /// Returns the result of the left to the power of the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberType`, either
    ///     - `lhs` must be positive, or
    ///     - `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The base.
    ///     - rhs: The exponent.
    ///
    /// - MutatingVariant: ↑=
    ///
    /// - RecommendedOver: pow
    public static func ↑ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ↑= rhs
        return result
    }

    fileprivate mutating func raiseWholeNumberToThePowerOf(wholeNumber exponent: Self) {
        if exponent == 0 {
            self = 1
        } else if exponent == 1 {
            // self = self
        } else if exponent.isEven {
            // p = (b ↑ 2) ↑ (e ÷ 2)
            self ×= self
            self ↑= (exponent.dividedAccordingToEuclid(by: 2))
        } else /* rhs.isOdd */ {
            // p = b × b ↑ (e − 1)
            self ×= (self ↑ (exponent − 1))
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isNatural_]
    /// Returns `true` if `self` is a natural number.
    public var isNatural: Bool {
        return isWhole ∧ self ≠ 0
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isWhole_]
    /// Returns `true` if `self` is a whole number.
    public var isWhole: Bool {
        return isIntegral ∧ isNonNegative
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isIntegral_]
    /// Returns `true` if `self` is an integer.
    public var isIntegral: Bool {
        return isDivisible(by: 1)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isEven_]
    /// Returns true if `self` is an even integer.
    public var isEven: Bool {
        return isDivisible(by: 2)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isOdd_]
    /// Returns true if `self` is an odd integer.
    public var isOdd: Bool {
        return isIntegral ∧ ¬isEven
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - NonmutatingVariant: rounded
    public mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self) {
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
                    assertionFailure("This line of code should be unreachable. All RoundingRule cases should already accounted for.")
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
    ///
    /// - MutatingVariant: round
    public func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self {
        var result = self
        result.round(rule, toMultipleOf: factor)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - NonmutatingVariant: rounded
    public mutating func round(_ rule: RoundingRule) {
        round(rule, toMultipleOf: 1)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - MutatingVariant: round
    public func rounded(_ rule: RoundingRule) -> Self {
        var result = self
        result.round(rule)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: ClosedRange<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }
}

// MARK: - Whole Arithmetic

// [_Inherit Documentation: SDGCornerstone.WholeArithmetic.gcd(_:_:)_]
/// Returns the greatest common divisor of `a` and `b`.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - MutatingVariant: formGreatestCommonDivisor
public func gcd<N : WholeArithmetic>(_ a: N, _ b: N) -> N {
    return N.gcd(a, b)
}

// [_Inherit Documentation: SDGCornerstone.WholeArithmetic.lcm(_:_:)_]
/// Returns the least common multiple of `a` and `b`.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - MutatingVariant: formGreatestCommonDivisor
public func lcm<N : WholeArithmetic>(_ a: N, _ b: N) -> N {
    return N.lcm(a, b)
}

extension WholeArithmetic where Self : FloatFamily {
    // MARK: - where Self : FloatFamily

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: ×=
    ///
    /// - RecommendedOver: *
    public static func × (lhs: Self, rhs: Self) -> Self {
        return lhs * rhs
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    ///
    /// - RecommendedOver: *=
    public static func ×= (lhs: inout Self, rhs: Self) {
        lhs *= rhs
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - NonmutatingVariant: dividedAccordingToEuclid
    public mutating func divideAccordingToEuclid(by divisor: Self) {
        self ÷= divisor
        self.round(.down)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberType`, either
    ///     - `lhs` must be positive, or
    ///     - `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - NonmutatingVariant: ↑
    public static func ↑= (lhs: inout Self, rhs: Self) {

        assert(lhs.isNonNegative ∨ rhs.isIntegral, "The result of a negative number raised to a non‐integer exponent may be outside the set of real numbers. Use a type that can represent complex numbers instead.")

        if rhs.isIntegral {
            lhs.raiseRationalNumberToThePowerOf(rationalNumber: rhs)
        } else if rhs.isNegative /* but not an integer */ {
            lhs = 1 ÷ lhs ↑ −rhs
        } else if lhs == e /* (natural) exponential function */ {

            // if x = e ↑ (w + r)
            // then x = e ↑ w × e ↑ r
            let w: Self = rhs.rounded(.toNearestOrAwayFromZero)
            let r: Self = rhs − w

            lhs.raiseRationalNumberToThePowerOf(rationalNumber: w)

            // The Taylor series around 0 will converge for any real r:
            //
            //   ∞       n
            //   ∑   ( _x__ )
            // n = 0    n!

            var e_r: Self = 1
            var lastApproximate: Self = 0
            var n: Self = 1
            var numerator: Self = r
            var denominator: Self = n
            repeat {
                lastApproximate = e_r

                e_r += numerator ÷ denominator

                n += 1
                numerator ×= r
                denominator ×= n

            } while e_r ≠ lastApproximate

            lhs ×= e_r

        } else {
            lhs = e ↑ (rhs × ln(lhs))
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {

        // 0 ..< UInt64.max
        let random: UInt64 = randomizer.randomNumber()

        // 0 ..< 1
        let converted = Self(random) ÷ Self(UInt64.max)

        // lowerBound ..< upperBound
        self = range.lowerBound + ((range.upperBound − range.lowerBound) × converted)
    }
}

extension WholeArithmetic where Self : IntegerType {
    // MARK: - where Self : IntegerType

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberType`, either
    ///     - `lhs` must be positive, or
    ///     - `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - NonmutatingVariant: ↑
    public static func ↑= (lhs: inout Self, rhs: Self) {
        lhs.raiseIntegerToThePowerOf(integer: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isIntegral_]
    /// Returns `true` if `self` is an integer.
    public var isIntegral: Bool {
        return true
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - NonmutatingVariant: rounded
    public mutating func round(_ rule: RoundingRule) {
        // self = self
    }
}

extension WholeArithmetic where Self : IntegralArithmetic {
    // MARK: - where Self : IntegralArithmetic

    fileprivate mutating func raiseIntegerToThePowerOf(integer exponent: Self) {

        assert(exponent.isNonNegative, "The result of a negative exponent may be outside the set of integers. Use a type that conforms to RationalArithmeticType instead.")

        raiseWholeNumberToThePowerOf(wholeNumber: exponent)
    }
}

extension WholeArithmetic where Self : IntFamily {
    // MARK: - where Self : IntFamily

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: ×=
    ///
    /// - RecommendedOver: *
    public static func × (lhs: Self, rhs: Self) -> Self {
        return lhs * rhs
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    ///
    /// - RecommendedOver: *=
    public static func ×= (lhs: inout Self, rhs: Self) {
        lhs *= rhs
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - NonmutatingVariant: dividedAccordingToEuclid
    public mutating func divideAccordingToEuclid(by divisor: Self) {

        let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

        let needsToWrapToPrevious = negative ∧ self % divisor ≠ 0
        // Wrap to previous if negative (ignoring when exactly even)

        // func divideAccordingToEuclid
        self /= divisor

        if needsToWrapToPrevious {
            self −= 1
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isEven_]
    /// Returns true if `self` is an even integer.
    public var isEven: Bool {
        return ¬isOdd
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isOdd_]
    /// Returns true if `self` is an odd integer.
    public var isOdd: Bool {
        return self & 1 == 1
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let value = Int64(randomInRange: range.lowerBound.toIntMax() ... range.upperBound.toIntMax(), fromRandomizer: randomizer)
        self.init(value)
    }
}

extension WholeArithmetic where Self : RationalArithmetic {
    // MARK: - where Self : RationalArithmetic

    internal mutating func raiseRationalNumberToThePowerOf(rationalNumber exponent: Self) {

        assert(exponent.isIntegral, "The result of a non‐integer exponent may be outside the set of rational numbers. Use a type that conforms to RealArithmeticType instead.")

        if exponent.isNegative {
            self = 1 ÷ self ↑ −exponent
        } else /* exponent.isNonNegative */ {
            raiseIntegerToThePowerOf(integer: exponent)
        }
    }
}

extension WholeArithmetic where Self : RationalNumberType {
    // MARK: - where Self : RationalNumberType

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberType`, either
    ///     - `lhs` must be positive, or
    ///     - `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - NonmutatingVariant: ↑
    public static func ↑= (lhs: inout Self, rhs: Self) {
        lhs.raiseRationalNumberToThePowerOf(rationalNumber: rhs)
    }
}

extension WholeArithmetic where Self : UIntFamily {
    // MARK: - where Self : UIntFamily

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: ×=
    ///
    /// - RecommendedOver: *
    public static func × (lhs: Self, rhs: Self) -> Self {
        return lhs * rhs
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    ///
    /// - RecommendedOver: *=
    public static func ×= (lhs: inout Self, rhs: Self) {
        lhs *= rhs
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.dividedAccordingToEuclid(by:)_]
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - MutatingVariant: divideAccordingToEuclid
    public func dividedAccordingToEuclid(by divisor: Self) -> Self {
        return self / divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - NonmutatingVariant: dividedAccordingToEuclid
    public mutating func divideAccordingToEuclid(by divisor: Self) {
        self /= divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.mod(_:)_]
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - MutatingVariant: formRemainder
    public func mod(_ divisor: Self) -> Self {
        return self % divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - NonmutatingVariant: mod
    public mutating func formRemainder(mod divisor: Self) {
        self %= divisor
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isEven_]
    /// Returns true if `self` is an even integer.
    public var isEven: Bool {
        return ¬isOdd
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isOdd_]
    /// Returns true if `self` is an odd integer.
    public var isOdd: Bool {
        return self & 1 == 1
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let value = UIntMax(randomInRange: range.lowerBound.toUIntMax() ... range.upperBound.toUIntMax(), fromRandomizer: randomizer)
        self.init(value)
    }
}

extension WholeArithmetic where Self : WholeNumberType {
    // MARK: - where Self : WholeNumberType

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerType`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberType`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberType`, either
    ///     - `lhs` must be positive, or
    ///     - `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - NonmutatingVariant: ↑
    public static func ↑= (lhs: inout Self, rhs: Self) {
        lhs.raiseWholeNumberToThePowerOf(wholeNumber: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isWhole_]
    /// Returns `true` if `self` is a whole number.
    public var isWhole: Bool {
        return true
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.isIntegral_]
    /// Returns `true` if `self` is an integer.
    public var isIntegral: Bool {
        return true
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - NonmutatingVariant: rounded
    public mutating func round(_ rule: RoundingRule) {
        // self = self
    }
}
