/*
 RationalNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLocalization
import SDGCornerstoneLocalizations

// #example(1, rationalNumberLiterals)
/// An arbitrary‐precision rational number.
///
/// ```swift
/// let third: RationalNumber = 1 ÷ 3
/// let decillionth: RationalNumber = "0.000 000 000 000 000 000 000 000 000 000 001"
/// let half = RationalNumber(binary: "0.1")
/// ```
public struct RationalNumber : Addable, Comparable, Decodable, Encodable, Equatable, ExpressibleByFloatLiteral, Hashable, IntegralArithmetic, Negatable, PointProtocol, RationalArithmetic, RationalNumberProtocol, Subtractable, TextConvertibleNumber, WholeArithmetic, TextualPlaygroundDisplay {

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

    /// Creates an instance from a floating point number.
    public init(_ floatingPoint: FloatMax) {
        var numerator = floatingPoint
        var denominator: FloatMax = 1
        while ¬numerator.isIntegral {
            numerator ×= 2
            denominator ×= 2
        }
        self.init(numerator: Integer(IntMax(numerator)), denominator: Integer(IntMax(denominator)))
    }

    // MARK: - Properties

    private struct Definition : Equatable, Hashable {
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
                unsafeDefinition.numerator.negate()
                unsafeDefinition.denominator.negate()
            }

            let divisor = SDGPrecisionMathematics.gcd(unsafeDefinition.numerator, unsafeDefinition.denominator)

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

    // #documentation(SDGCornerstone.Addable.+=)
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    public static func += (precedingValue: inout RationalNumber, followingValue: RationalNumber) {

        // _a_  +  _c_, b ≠ 0, d ≠ 0
        //  b       d
        //
        // _ad_ + _bc_, b ≠ 0, d ≠ 0
        //  bd     bd
        //
        // _ad__+__bc_, b ≠ 0, d ≠ 0
        //      bd

        var irregular = precedingValue.definition

        irregular.numerator ×= followingValue.denominator
        irregular.numerator += followingValue.numerator × precedingValue.denominator

        irregular.denominator ×= followingValue.denominator

        precedingValue.definition = irregular
    }

    // MARK: - Comparable

    public static func < (precedingValue: RationalNumber, followingValue: RationalNumber) -> Bool {
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
        return precedingValue.numerator × followingValue.denominator < followingValue.numerator × precedingValue.denominator
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return String(UserFacing<StrictString, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada, .deutschDeutschland, .françaisFrance, .ελληνικάΕλλάδα, .עברית־ישראל:
                return self.asSimpleFraction()
            }
        }).resolved())
    }

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let numerator = try container.decode(Integer.self)
        let denominator = try container.decode(Integer.self)
        self.init(numerator: numerator, denominator: denominator)
    }

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(numerator)
        try container.encode(denominator)
    }

    // MARK: - Equatable

    public static func == (precedingValue: RationalNumber, followingValue: RationalNumber) -> Bool {
        return precedingValue.definition == followingValue.definition
    }

    // MARK: - IntegralArithmetic

    // #documentation(SDGCornerstone.IntegralArithmetic.init(int:))
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of `IntMax`.
    public init(_ int: IntMax) {
        self.init(Integer(int))
    }

    // MARK: - Negatable

    public mutating func negate() {
        definition.numerator.negate()
    }

    // MARK: - Numeric

    // #documentation(SDGCornerstone.Numeric.init(exactly:))
    /// Creates a new instance from the given integer, if it can be represented exactly.
    @inlinable public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let integer = Integer(exactly: source) else {
            unreachable()
        }
        self.init(integer)
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = RationalNumber

    // MARK: - RationalArithmetic

    // #documentation(SDGCornerstone.RationalArithmetic.÷=)
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The divisor.
    public static func ÷= (precedingValue: inout RationalNumber, followingValue: RationalNumber) {
        var irregular = precedingValue.definition
        irregular.numerator ×= followingValue.denominator
        irregular.denominator ×= followingValue.numerator
        precedingValue.definition = irregular
    }

    // MARK: - RationalNumberProtocol

    // @documentation(SDGCornerstone.RationalNumberProtocol.reducedSimpleFraction())
    /// Returns the numerator and denominator of the number as a reduced simple fraction.
    public func reducedSimpleFraction() -> (numerator: Integer, denominator: Integer) {
        return (numerator, denominator)
    }

    // MARK: - Subtractable

    // #documentation(SDGCornerstone.Subtractable.−=)
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout RationalNumber, followingValue: RationalNumber) {
        precedingValue += −followingValue
    }

    // MARK: - WholeArithmetic

    // #documentation(SDGCornerstone.WholeArithmetic.init(uInt:))
    /// Creates an instance equal to `uInt`.
    ///
    /// - Parameters:
    ///     - uInt: An instance of `UIntMax`.
    public init(_ uInt: UIntMax) {
        self.init(Integer(uInt))
    }

    // #documentation(SDGCornerstone.WholeArithmetic.×=)
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    public static func ×= (precedingValue: inout RationalNumber, followingValue: RationalNumber) {
        var irregular = precedingValue.definition
        irregular.numerator ×= followingValue.numerator
        irregular.denominator ×= followingValue.denominator
        precedingValue.definition = irregular
    }

    // #documentation(SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:))
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    public mutating func divideAccordingToEuclid(by divisor: RationalNumber) {
        let rational = self ÷ divisor
        let euclidean = rational.numerator.dividedAccordingToEuclid(by: rational.denominator)
        self = RationalNumber(euclidean)
    }

    private static let randomPrecision: Integer = Integer(UIntMax.max) + 1

    // #documentation(SDGCornerstone.WholeArithmetic.random(in:using:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - generator: The randomizer to use to generate the random value.
    public static func random<R>(in range: ClosedRange<RationalNumber>, using generator: inout R) -> RationalNumber where R : RandomNumberGenerator {
        let difference = range.upperBound − range.lowerBound
        let denominator = difference.denominator

        let numeratorRange = difference.numerator × denominator

        let scaled = numeratorRange × RationalNumber.randomPrecision

        let scaledNumerator = Integer.random(in: 0 ... scaled, using: &generator)

        var result = RationalNumber(numerator: scaledNumerator, denominator: RationalNumber.randomPrecision × denominator)

        result += range.lowerBound
        return result
    }
}
