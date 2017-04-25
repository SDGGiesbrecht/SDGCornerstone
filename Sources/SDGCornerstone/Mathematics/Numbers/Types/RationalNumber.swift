/*
 RationalNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Example 1: RationalNumber Literals_]
/// An arbitrary‐precision rational number.
///
/// ```swift
/// let third: RationalNumber = 1 ÷ 3
/// let decillionth: RationalNumber = "0.000 000 000 000 000 000 000 000 000 000 000 1"
/// let half: RationalNumber = "0b 0.1"
/// ```
public struct RationalNumber : Addable, Comparable, Equatable, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, ExpressibleByStringLiteral, ExpressibleByUnicodeScalarLiteral, IntegralArithmetic, Negatable, PointType, RationalArithmetic, RationalNumberType, Subtractable, WholeArithmetic {

    // MARK: - Initialization

    private init(numerator: Integer, denominator: Integer) {
        definition = Definition(numerator: numerator, denominator: denominator)
    }

    /// Creates an instance from an integer.
    public init(_ integer: Integer) {
        self.init(numerator: integer, denominator: 1)
    }

    /// Creates an instance from a whole number.
    public init(_ wholeNumber: WholeNumber) {
        self.init(Integer(wholeNumber))
    }

    // MARK: - Properties

    private struct Definition {
        fileprivate var numerator: Integer
        fileprivate var denominator: Integer
    }
    private var unsafeDefinition = Definition(numerator: 0, denominator: 1)
    private var definition: Definition {
        get {
            return unsafeDefinition
        }
        set {
            unsafeDefinition = newValue

            // Normalize

            if unsafeDefinition.denominator.isNegative {
                unsafeDefinition.numerator−=
                unsafeDefinition.denominator−=
            }

            let divisor = gcd(unsafeDefinition.numerator, unsafeDefinition.denominator)

            unsafeDefinition.numerator = unsafeDefinition.numerator.dividedAccordingToEuclid(by: divisor)
            unsafeDefinition.denominator = unsafeDefinition.denominator.dividedAccordingToEuclid(by: divisor)
        }
    }

    /// The numerator.
    public var numerator: Integer {
        return definition.numerator
    }

    /// The denominator.
    public var denominator: Integer {
        return definition.denominator
    }

    // MARK: - Addable

    // [_Inherit Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the right value to the left, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout RationalNumber, rhs: RationalNumber) {

        // _a_  +  _c_, b ≠ 0, d ≠ 0
        //  b       d
        //
        // _ad_ + _bc_, b ≠ 0, d ≠ 0
        //  bd     bd
        //
        // _ad__+__bc_, b ≠ 0, d ≠ 0
        //      bd

        var irregular = lhs.definition

        irregular.numerator ×= rhs.denominator
        irregular.numerator += rhs.numerator × lhs.denominator

        irregular.denominator ×= rhs.denominator

        lhs.definition = irregular
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: RationalNumber, rhs: RationalNumber) -> Bool {
        //    _a_   <?     _c_ , b ≠ 0, d ≠ 0
        //     b            d
        //
        //    _ad_  <?    _bc_ , b ≠ 0, d ≠ 0
        //     bd          bd
        //
        // bd(_ad_) <? bd(_bc_), b ≠ 0, d ≠ 0
        //     bd          bd
        //
        //     ad   <?     bc  , b ≠ 0, d ≠ 0
        return lhs.numerator × rhs.denominator < rhs.numerator × lhs.denominator
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: RationalNumber, rhs: RationalNumber) -> Bool {
        return (lhs.numerator, lhs.denominator) == (rhs.numerator, rhs.denominator)
    }

    // MARK: - ExpressibleByExtendedGraphemeClusterLiteral

    // [_Inherit Documentation: SDGCornerstone.WholeNumber.init(extendedGraphemeClusterLiteral:)_]
    /// Creates an instance from an extended grapheme cluster literal.
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {  // [_Exempt from Code Coverage_] Apparently unreachable.
        self.init(textLiteral: value)
    }

    // MARK: - ExpressibleByFloatLiteral

    /// The float literal type.
    public typealias FloatLiteralType = FloatMax

    internal init(floatingPointLiteral value: FloatMax) {
        var numerator = value
        var denominator: FloatMax = 1
        while ¬numerator.isIntegral {
            numerator ×= 2
            denominator ×= 2
        }
        self.init(numerator: Integer(IntMax(numerator)), denominator: Integer(IntMax(denominator)))
    }

    /// Creates an instance from a float literal.
    public init(floatLiteral value: FloatLiteralType) {
        self.init(floatingPointLiteral: value)
    }

    // MARK: - ExpressibleByIntegerLiteral

    // [_Inherit Documentation: SDGCornerstone.WholeNumber.IntegerLiteralType_]
    /// The integer literal type.
    public typealias IntegerLiteralType = IntMax

    // [_Inherit Documentation: SDGCornerstone.WholeNumber.init(integerLiteral:)_]
    /// Creates an instance from an integer literal.
    public init(integerLiteral: IntegerLiteralType) {
        self.init(integerLiteral)
    }

    // MARK: - ExpressibleByStringLiteral

    private static let radixCharacters: Set<UnicodeScalar> = [",", ".", "٫"]

    internal init(textLiteral value: String) {
        let scalars = value.unicodeScalars

        var radixLocation: String.UnicodeScalarView.Index?
        for index in scalars.indices {
            if RationalNumber.radixCharacters.contains(scalars[index]) {
                radixLocation = index
                break
            }
        }

        var wholeString: String
        var numeratorString: String
        if let radix = radixLocation {
            wholeString = String(scalars[scalars.startIndex ..< radix])
            numeratorString = String(scalars[scalars.index(after: radix) ..< scalars.endIndex])
        } else {
            wholeString = value
            numeratorString = ""
        }

        func flattenToZeroes(_ value: String) -> String {
            return String(String.UnicodeScalarView(value.unicodeScalars.map({ WholeNumber.digitMapping[$0] ≠ nil ? "0" : $0 })))
        }

        let whole = Integer(textLiteral: wholeString)

        var specialBaseNumerator: Integer?
        var specialBaseDenominator: Integer?
        for (prefix, _) in WholeNumber.prefixToBaseMapping {
            if value.hasPrefix(prefix) {
                specialBaseNumerator = Integer(textLiteral: prefix + numeratorString)
                specialBaseDenominator = Integer(textLiteral: prefix + "1" + flattenToZeroes(numeratorString))
                break
            }
        }

        let numerator: Integer
        let denominator: Integer
        if let theNumerator = specialBaseNumerator,
            let theDenominator = specialBaseDenominator {

            numerator = theNumerator
            denominator = theDenominator
        } else {
            numerator = Integer(textLiteral: numeratorString)
            denominator = Integer(textLiteral: "1" + flattenToZeroes(numeratorString))
        }

        self = RationalNumber(whole) + RationalNumber(numerator: numerator, denominator: denominator)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeNumber.init(stringLiteral:)_]
    /// Creates an instance from a string literal.
    public init(stringLiteral value: StringLiteralType) {
        self.init(textLiteral: value)
    }

    // MARK: - ExpressibleByUnicodeScalarLiteral

    // [_Inherit Documentation: SDGCornerstone.WholeNumber.init(unicodeScalarLiteral:)_]
    /// Creates an instance from a unicode scalar literal.
    public init(unicodeScalarLiteral value: StringLiteralType) { // [_Exempt from Code Coverage_] Apparently unreachable.
        self.init(textLiteral: value)
    }

    // MARK: - IntegralArithmetic

    // [_Inherit Documentation: SDGCornerstone.IntegralArithmetic.init(int:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of `IntMax`.
    public init(_ int: IntMax) {
        self.init(Integer(int))
    }

    // MARK: - Negatable

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout RationalNumber) {
        operand.definition.numerator−=
    }

    // MARK: - PointType

    // [_Inherit Documentation: SDGCornerstone.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = RationalNumber

    // MARK: - RationalArithmetic

    // [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷=_]
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    ///
    /// - RecommendedOver: /=
    public static func ÷= (lhs: inout RationalNumber, rhs: RationalNumber) {
        var irregular = lhs.definition
        irregular.numerator ×= rhs.denominator
        irregular.denominator ×= rhs.numerator
        lhs.definition = irregular
    }

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout RationalNumber, rhs: RationalNumber) {
        lhs += −rhs
    }

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(uInt:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of `UIntMax`.
    public init(_ uInt: UIntMax) {
        self.init(Integer(uInt))
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
    public static func ×= (lhs: inout RationalNumber, rhs: RationalNumber) {
        var irregular = lhs.definition
        irregular.numerator ×= rhs.numerator
        irregular.denominator ×= rhs.denominator
        lhs.definition = irregular
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
    public mutating func divideAccordingToEuclid(by divisor: RationalNumber) {
        let rational = self ÷ divisor
        let euclidean = rational.numerator.dividedAccordingToEuclid(by: rational.denominator)
        self = RationalNumber(euclidean)
    }

    private static let randomPrecision: Integer = Integer(UIntMax.max) + 1

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<RationalNumber>, fromRandomizer randomizer: Randomizer) {
        let difference = range.upperBound − range.lowerBound
        let denominator = difference.denominator

        let numeratorRange = difference.numerator × denominator

        let scaled = numeratorRange × RationalNumber.randomPrecision

        let scaledNumerator = Integer(randomInRange: 0 ... scaled, fromRandomizer: randomizer)

        self = RationalNumber(numerator: scaledNumerator, denominator: RationalNumber.randomPrecision × denominator)

        self += range.lowerBound
    }
}
