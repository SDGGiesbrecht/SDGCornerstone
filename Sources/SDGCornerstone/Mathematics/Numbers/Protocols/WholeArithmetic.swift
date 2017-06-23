/*
 WholeArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

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
///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
///   - If `Self` conforms to `RealNumberProtocol`, either
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
///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
///   - If `Self` conforms to `RealNumberProtocol`, either
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
/// - `OneDimensionalPoint`
/// - `init(_ uInt: UIntMax)`
/// - `static func ×= (lhs: inout Self, rhs: Self)`
/// - `mutating func divideAccordingToEuclid(by divisor: Self)`
/// - `WholeNumberProtocol`, `IntegerProtocol`, `RationalNumberProtocol` or `static func ↑= (lhs: inout Self, rhs: Self)`
/// - `init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)`
public protocol WholeArithmetic : ExpressibleByIntegerLiteral, ExpressibleByTextLiterals, NumericAdditiveArithmetic, OneDimensionalPoint, Strideable {

    // MARK: - Initialization

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(uInt:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of `UIntMax`.
    init(_ uInt: UIntMax)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:)_]
    /// Creates an instance by interpreting `representation` as a place value system using the provided digits and radix characters.
    ///
    /// - Precondition: `digits`, `radixCharacters` and `formattingSeparators` only contain scalars that are valid in NFKD (they should not be decomposable).
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - digits: The digits to use. Each entry in the array defines a set of digit characters that have the value corresponding to the array index. The length of the array determines the base.
    ///     - radixCharacters: The set of characters that can mark the radix position.
    ///     - formattingSeparators: A set of characters, such as thousands separators, that should be ignored.
    init(fromRepresentation representation: StrictString, usingDigits digits:  [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>)

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
    ///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
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
    ///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
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

    /// Creates an instance from a decimal representation.
    ///
    /// - Parameters:
    ///     - decimal: The decimal representation.
    public init(_ decimal: StrictString) {
        self.init(decimal, base: 10)
    }

    /// Creates an instance from a hexadecimal representation.
    ///
    /// - Parameters:
    ///     - hexadecimal: The hexadecimal representation.
    public init(hexadecimal: StrictString) {
        self.init(hexadecimal, base: 16)
    }

    /// Creates an instance from a octal representation.
    ///
    /// - Parameters:
    ///     - octal: The octal representation.
    public init(octal: StrictString) {
        self.init(octal, base: 8)
    }

    /// Creates an instance from a binary representation.
    ///
    /// - Parameters:
    ///     - binary: The binary representation.
    public init(binary: StrictString) {
        self.init(binary, base: 2)
    }

    /// Creates an instance by interpreting `representation` in a particular base.
    ///
    /// - Precondition: `2 ≤ base ≤ 16`, `base` ∈ Z
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - base: The base of the number system.
    public init(_ representation: StrictString, base: Int) {
        assert(base.isIntegral ∧ 2 ≤ base ∧ base ≤ 16, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada:
                return StrictString("Base \(base) is not supported. The base must be an integer between 2 and 16 inclusive.")
            }
        }))

        let digits: [[UnicodeScalar]] = [
            //    arb  pes  hi   bn   ta   my   km   th   lo
            ["0", "٠", "۰", "०", "০", "௦", "၀", "០", "๐", "໐"],
            ["1", "١", "۱", "१", "১", "௧", "၁", "១", "๑", "໑"],
            ["2", "٢", "۲", "२", "২", "௨", "၂", "២", "๒", "໒"],
            ["3", "٣", "۳", "३", "৩", "௩", "၃", "៣", "๓", "໓"],
            ["4", "٤", "۴", "४", "৪", "௪", "၄", "៤", "๔", "໔"],
            ["5", "٥", "۵", "५", "৫", "௫", "၅", "៥", "๕", "໕"],
            ["6", "٦", "۶", "६", "৬", "௬", "၆", "៦", "๖", "໖"],
            ["7", "٧", "۷", "७", "৭", "௭", "၇", "៧", "๗", "໗"],
            ["8", "٨", "۸", "८", "৮", "௮", "၈", "៨", "๘", "໘"],
            ["9", "٩", "۹", "९", "৯", "௯", "၉", "៩", "๙", "໙"],
            ["A", "a"],
            ["B", "b"],
            ["C", "c"],
            ["D", "d"],
            ["E", "e"],
            ["F", "f"]
        ]

        let selectedDigits = [[UnicodeScalar]](digits[0 ..< base])

        self.init(fromRepresentation: representation, usingDigits: selectedDigits, radixCharacters: [",", ".", "٫"], formattingSeparators: [" ", "٬"])
    }

    fileprivate static func assertNFKD(digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) {

        let assertNFKD = { () -> [UnicodeScalar] in
            var scalars = digits.reduce([]) { $0 + $1 }
            scalars += radixCharacters
            scalars += formattingSeparators

            var set: Set<UnicodeScalar> = []
            for scalar in scalars where scalar.isDecomposableInNFKD {
                set.insert(scalar)
            }

            return set.sorted()
        }
        assert(assertNFKD().isEmpty, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada:
                return StrictString("Some scalars are not in NFKD: \(assertNFKD().map({ $0.visibleRepresentation }))")
            }
        }))
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:)_]
    /// Creates an instance by interpreting `representation` as a place value system using the provided digits and radix characters.
    ///
    /// - Precondition: `digits`, `radixCharacters` and `formattingSeparators` only contain scalars that are valid in NFKD (they should not be decomposable).
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - digits: The digits to use. Each entry in the array defines a set of digit characters that have the value corresponding to the array index. The length of the array determines the base.
    ///     - radixCharacters: The set of characters that can mark the radix position.
    ///     - formattingSeparators: A set of characters, such as thousands separators, that should be ignored.
    public init(fromRepresentation representation: StrictString, usingDigits digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) {
        Self.assertNFKD(digits: digits, radixCharacters: radixCharacters, formattingSeparators: formattingSeparators)

        self.init(whole: representation, base: Self.getBase(digits), digits: Self.getMapping(digits), formattingSeparators: formattingSeparators)
    }

    fileprivate static func getBase(_ digits: [[UnicodeScalar]]) -> Self {
        return Self(UInt(digits.count))
    }

    fileprivate static func getMapping(_ digits: [[UnicodeScalar]]) -> [UnicodeScalar: Self] {
        var digitMapping: [UnicodeScalar: Self] = [:]
        for index in digits.indices {
            let characters = digits[index]

            let value = Self(UInt(index))
            for character in characters {
                digitMapping[character] = value
            }
        }
        return digitMapping
    }

    fileprivate init(whole representation: StrictString, base: Self, digits digitMapping: [UnicodeScalar: Self], formattingSeparators: Set<UnicodeScalar>) {

        self = 0
        var position: Self = 0
        for character in representation.reversed() {
            if let digit = digitMapping[character], digit < base {
                self += (base ↑ position) × digit
                position += 1
            } else {
                assert(character ∈ formattingSeparators, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                    switch localization {
                    case .englishCanada:
                        return StrictString("\(character) is not a valid digit.")
                    }
                }))
            }
        }
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
    ///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
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
                    unreachable()
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

    internal var egyptianDigits: [UnicodeScalar] {
        return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    }

    internal func radix(for digits: [UnicodeScalar]) -> Self {
        return Self(UInt(digits.count))
    }

    internal func mapping(for digits: [UnicodeScalar]) -> [Self: UnicodeScalar] {
        var result: [Self: UnicodeScalar] = [:]
        for value in digits.indices {
            result[Self(UInt(value))] = digits[value]
        }
        return result
    }

    internal func wholeDigits(thousandsSeparator: UnicodeScalar) -> StrictString {
        let digitSet = egyptianDigits

        let radix = self.radix(for: digitSet)
        let digitMapping = mapping(for: digitSet)

        var whole = (|self|).rounded(.towardZero)
        var digits: [UnicodeScalar] = []
        var position: Self = 0
        while whole ≠ 0 {
            if position.mod(3) == 0 ∧ position ≠ 0 {
                digits.append(thousandsSeparator)
            }

            let positionValue = whole.mod(radix)
            whole.divideAccordingToEuclid(by: radix)

            guard let character = digitMapping[positionValue] else {
                unreachable()
            }
            digits.append(character)

            position += 1
        }

        if digits.isEmpty {
            digits.append(digitSet[0])
        } else if digits.count == 5 {
            digits.remove(at: 3)
        }

        return StrictString(digits.reversed())
    }

    internal func romanNumerals(lowercase: Bool) -> StrictString {
        let warning = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Code Coverage_]
            switch localization {
            case .englishCanada:
                return "Roman numerals are only supported in the range I–MMMCMXCIX."
            }
        })
        assert(0 < self ∧ (self is Int8 ∨ self is UInt8 ∨ self < 4000), warning)

        func format(_ string: StrictString) -> StrictString {
            if lowercase {
                return StrictString(String(string).lowercased())
            } else {
                return string
            }
        }

        var number = self
        var result: StrictString = ""

        switch number.mod(10) {
        case 0:
            break
        case 1:
            result.prepend(contentsOf: format("I"))
        case 2:
            result.prepend(contentsOf: format("II"))
        case 3:
            result.prepend(contentsOf: format("III"))
        case 4:
            result.prepend(contentsOf: format("IV"))
        case 5:
            result.prepend(contentsOf: format("V"))
        case 6:
            result.prepend(contentsOf: format("VI"))
        case 7:
            result.prepend(contentsOf: format("VII"))
        case 8:
            result.prepend(contentsOf: format("VIII"))
        case 9:
            result.prepend(contentsOf: format("IX"))
        default:
            preconditionFailure(warning)
        }
        number.divideAccordingToEuclid(by: 10)

        switch number.mod(10) {
        case 0:
            break
        case 1:
            result.prepend(contentsOf: format("X"))
        case 2:
            result.prepend(contentsOf: format("XX"))
        case 3:
            result.prepend(contentsOf: format("XXX"))
        case 4:
            result.prepend(contentsOf: format("XL"))
        case 5:
            result.prepend(contentsOf: format("L"))
        case 6:
            result.prepend(contentsOf: format("LX"))
        case 7:
            result.prepend(contentsOf: format("LXX"))
        case 8:
            result.prepend(contentsOf: format("LXXX"))
        case 9:
            result.prepend(contentsOf: format("XC"))
        default:
            preconditionFailure(warning)
        }
        number.divideAccordingToEuclid(by: 10)

        switch number.mod(10) {
        case 0:
            break
        case 1:
            result.prepend(contentsOf: format("C"))
        case 2:
            result.prepend(contentsOf: format("CC"))
        case 3:
            result.prepend(contentsOf: format("CCC"))
        case 4:
            result.prepend(contentsOf: format("CD"))
        case 5:
            result.prepend(contentsOf: format("D"))
        case 6:
            result.prepend(contentsOf: format("DC"))
        case 7:
            result.prepend(contentsOf: format("DCC"))
        case 8:
            result.prepend(contentsOf: format("DCCC"))
        case 9:
            result.prepend(contentsOf: format("CM"))
        default:
            preconditionFailure(warning)
        }
        number.divideAccordingToEuclid(by: 10)

        switch number.mod(10) {
        case 0:
            break
        case 1:
            result.prepend(contentsOf: format("M"))
        case 2:
            result.prepend(contentsOf: format("MM"))
        case 3:
            result.prepend(contentsOf: format("MMM"))
        default:
            preconditionFailure(warning)
        }

        return result
    }

    internal func ελληνικοίΑριθμοί(μικράΓράμματα: Bool, κεραία: Bool) -> StrictString {
        let προειδοποίηση = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Code Coverage_]
            switch localization {
            case .englishCanada:
                return "Greek numerals are only supported in the range Αʹ–͵ΘϠϞΘʹ."
            }
        })
        assert(0 < self ∧ (self is Int8 ∨ self is UInt8 ∨ self < 10_000), προειδοποίηση)

        func μορφοποίηση(_ κείμενο: StrictString) -> StrictString {
            if μικράΓράμματα {
                return StrictString(String(κείμενο).lowercased())
            } else {
                return κείμενο
            }
        }

        var αριθμός = self
        var αποτέλεσμα: StrictString = ""

        switch αριθμός.mod(10) {
        case 0:
            break
        case 1:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Α"))
        case 2:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Β"))
        case 3:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Γ"))
        case 4:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Δ"))
        case 5:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ε"))
        case 6:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ϛ"))
        case 7:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ζ"))
        case 8:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Η"))
        case 9:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Θ"))
        default:
            preconditionFailure(προειδοποίηση)
        }
        αριθμός.divideAccordingToEuclid(by: 10)

        switch αριθμός.mod(10) {
        case 0:
            break
        case 1:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ι"))
        case 2:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Κ"))
        case 3:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Λ"))
        case 4:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Μ"))
        case 5:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ν"))
        case 6:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ξ"))
        case 7:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ο"))
        case 8:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Π"))
        case 9:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ϟ"))
        default:
            preconditionFailure(προειδοποίηση)
        }
        αριθμός.divideAccordingToEuclid(by: 10)

        switch αριθμός.mod(10) {
        case 0:
            break
        case 1:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ρ"))
        case 2:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Σ"))
        case 3:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Τ"))
        case 4:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Υ"))
        case 5:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Φ"))
        case 6:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Χ"))
        case 7:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ψ"))
        case 8:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ω"))
        case 9:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ϡ"))
        default:
            preconditionFailure(προειδοποίηση)
        }
        αριθμός.divideAccordingToEuclid(by: 10)

        if κεραία ∧ ¬αποτέλεσμα.isEmpty {
            αποτέλεσμα.append("ʹ")
        }

        var χιλιάδες: StrictString = ""

        switch αριθμός.mod(10) {
        case 0:
            break
        case 1:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Α"))
        case 2:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Β"))
        case 3:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Γ"))
        case 4:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Δ"))
        case 5:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Ε"))
        case 6:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Ϛ"))
        case 7:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Ζ"))
        case 8:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Η"))
        case 9:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Θ"))
        default:
            preconditionFailure(προειδοποίηση)
        }

        if κεραία ∧ ¬χιλιάδες.isEmpty {
            χιλιάδες.prepend("͵")
        }

        αποτέλεσμα.prepend(contentsOf: χιλιάδες)

        return αποτέλεσμα
    }

    internal func ספרות־עבריות(גרשיים: Bool) -> StrictString {
        let אזהרה = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Code Coverage_]
            switch localization {
            case .englishCanada:
                return "Hebrew numerals are only supported in the range א׳–ט׳תתקצ״ט."
            }
        })
        assert(0 < self ∧ (self is Int8 ∨ self is UInt8 ∨ self < 10_000), אזהרה)

        var מספר = self
        var תוצאה: StrictString = ""

        switch מספר.mod(10) {
        case 0:
            break
        case 1:
            תוצאה.prepend("א")
        case 2:
            תוצאה.prepend("ב")
        case 3:
            תוצאה.prepend("ג")
        case 4:
            תוצאה.prepend("ד")
        case 5:
            תוצאה.prepend("ה")
        case 6:
            תוצאה.prepend("ו")
        case 7:
            תוצאה.prepend("ז")
        case 8:
            תוצאה.prepend("ח")
        case 9:
            תוצאה.prepend("ט")
        default:
            preconditionFailure(אזהרה)
        }
        מספר.divideAccordingToEuclid(by: 10)

        switch מספר.mod(10) {
        case 0:
            break
        case 1:
            תוצאה.prepend("י")
        case 2:
            תוצאה.prepend("כ")
        case 3:
            תוצאה.prepend("ל")
        case 4:
            תוצאה.prepend("מ")
        case 5:
            תוצאה.prepend("נ")
        case 6:
            תוצאה.prepend("ס")
        case 7:
            תוצאה.prepend("ע")
        case 8:
            תוצאה.prepend("פ")
        case 9:
            תוצאה.prepend("צ")
        default:
            preconditionFailure(אזהרה)
        }
        מספר.divideAccordingToEuclid(by: 10)

        switch מספר.mod(10) {
        case 0:
            break
        case 1:
            תוצאה.prepend("ק")
        case 2:
            תוצאה.prepend("ר")
        case 3:
            תוצאה.prepend("ש")
        case 4:
            תוצאה.prepend("ת")
        case 5:
            תוצאה.prepend(contentsOf: "תק" as StrictString)
        case 6:
            תוצאה.prepend(contentsOf: "תר" as StrictString)
        case 7:
            תוצאה.prepend(contentsOf: "תש" as StrictString)
        case 8:
            תוצאה.prepend(contentsOf: "תת" as StrictString)
        case 9:
            תוצאה.prepend(contentsOf: "תתק" as StrictString)
        default:
            preconditionFailure(אזהרה)
        }
        מספר.divideAccordingToEuclid(by: 10)

        תוצאה.replaceMatches(for: "יה" as StrictString, with: "טו" as StrictString)
            תוצאה.replaceMatches(for: "יו" as StrictString, with: "טז" as StrictString)

        if גרשיים ∧ ¬תוצאה.isEmpty {
            if תוצאה.count == 1 {
                 תוצאה.append("׳")
            } else {
                תוצאה.insert("״", at: תוצאה.index(before: תוצאה.endIndex))
            }
        }

        var אלפים: StrictString = ""

        switch מספר.mod(10) {
        case 0:
            break
        case 1:
            אלפים.prepend("א")
        case 2:
            אלפים.prepend("ב")
        case 3:
            אלפים.prepend("ג")
        case 4:
            אלפים.prepend("ד")
        case 5:
            אלפים.prepend("ה")
        case 6:
            אלפים.prepend("ו")
        case 7:
            אלפים.prepend("ז")
        case 8:
            אלפים.prepend("ח")
        case 9:
            אלפים.prepend("ט")
        default:
            preconditionFailure(אזהרה)
        }

        if גרשיים ∧ ¬אלפים.isEmpty {
            אלפים.append("׳")
        }

        תוצאה.prepend(contentsOf: אלפים)

        return תוצאה
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
    ///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
    ///     - `lhs` must be positive, or
    ///     - `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - NonmutatingVariant: ↑
    public static func ↑= (lhs: inout Self, rhs: Self) {

        assert(lhs.isNonNegative ∨ rhs.isIntegral, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada:
                return "The result of a negative number raised to a non‐integer exponent may be outside the set of real numbers. Use a type that can represent complex numbers instead."
            }
        }))

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

extension WholeArithmetic where Self : IntegerProtocol {
    // MARK: - where Self : IntegerProtocol

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
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

        assert(exponent.isNonNegative, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada:
                return "The result of a negative exponent may be outside the set of integers. Use a type that conforms to RationalArithmetic instead."
            }
        }))

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

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:)_]
    /// Creates an instance by interpreting `representation` as a place value system using the provided digits and radix characters.
    ///
    /// - Precondition: `digits`, `radixCharacters` and `formattingSeparators` only contain scalars that are valid in NFKD (they should not be decomposable).
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - digits: The digits to use. Each entry in the array defines a set of digit characters that have the value corresponding to the array index. The length of the array determines the base.
    ///     - radixCharacters: The set of characters that can mark the radix position.
    ///     - formattingSeparators: A set of characters, such as thousands separators, that should be ignored.
    public init(fromRepresentation representation: StrictString, usingDigits digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) {
        Self.assertNFKD(digits: digits, radixCharacters: radixCharacters, formattingSeparators: formattingSeparators)

        let base = Self.getBase(digits)
        let digitMapping = Self.getMapping(digits)

        var radixLocation: StrictString.Index?
        for index in representation.indices where representation[index] ∈ radixCharacters {
            radixLocation = index
            break
        }

        let wholeString: StrictString
        let numeratorString: StrictString
        if let radix = radixLocation {
            wholeString = StrictString(representation[representation.startIndex ..< radix])
            numeratorString = StrictString(representation[representation.index(after: radix) ..< representation.endIndex])
        } else {
            wholeString = representation
            numeratorString = ""
        }

        func flattenToZeroes(_ value: StrictString) -> StrictString {
            return StrictString(value.map({ digitMapping[$0] ≠ nil ? "0" : $0 }))
        }

        func component(_ value: StrictString) -> Self {
            return Self(whole: value, base: base, digits: digitMapping, formattingSeparators: formattingSeparators)
        }

        let whole = component(wholeString)
        let numerator = component(numeratorString)
        let denominator = component("1" + flattenToZeroes(numeratorString))

        self = whole + numerator ÷ denominator
    }

    internal mutating func raiseRationalNumberToThePowerOf(rationalNumber exponent: Self) {

        assert(exponent.isIntegral, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada:
                return "The result of a non‐integer exponent may be outside the set of rational numbers. Use a type that conforms to RealArithmetic instead."
            }
        }))

        if exponent.isNegative {
            self = 1 ÷ self ↑ −exponent
        } else /* exponent.isNonNegative */ {
            raiseIntegerToThePowerOf(integer: exponent)
        }
    }
}

extension WholeArithmetic where Self : RationalNumberProtocol {
    // MARK: - where Self : RationalNumberProtocol

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
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
        return self.bitwiseAnd(with: 1) == 1
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

extension WholeArithmetic where Self : WholeNumberProtocol {
    // MARK: - where Self : WholeNumberProtocol

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.↑=_]
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `rhs` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `rhs` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
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
