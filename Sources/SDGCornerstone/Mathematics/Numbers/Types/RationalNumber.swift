/*
 RationalNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Example 1: RationalNumber Literals_]
/// An arbitrary‐precision rational number.
///
/// ```swift
/// let third: RationalNumber = 1 ÷ 3
/// let decillionth: RationalNumber = "0.000 000 000 000 000 000 000 000 000 000 001"
/// let half = RationalNumber(binary: "0.1")
/// ```
public struct RationalNumber : Addable, Codable, Comparable, Equatable, ExpressibleByFloatLiteral, Hashable, IntegralArithmetic, Negatable, PointProtocol, RationalArithmetic, RationalNumberProtocol, Subtractable, WholeArithmetic {

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

            let divisor = SDGCornerstone.gcd(unsafeDefinition.numerator, unsafeDefinition.denominator)

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

    // MARK: - Decodable

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let numerator = try container.decode(Integer.self)
        let denominator = try container.decode(Integer.self)
        self.init(numerator: numerator, denominator: denominator)
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(numerator)
        try container.encode(denominator)
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

    // MARK: - Hashable

    // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
    /// The hash value.
    public var hashValue: Int {
        return numerator.hashValue
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
    public static postfix func −= (operand: inout RationalNumber) {
        operand.definition.numerator−=
    }

    // MARK: - Numeric

    // [_Inherit Documentation: SDGCornerstone.Numeric.init(exactly:)_]
    /// Creates a new instance from the given integer, if it can be represented exactly.
    public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let integer = Integer(exactly: source) else {
            unreachable()
        }
        self.init(integer)
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = RationalNumber

    // MARK: - RationalArithmetic

    // [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷=_]
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    public static func ÷= (lhs: inout RationalNumber, rhs: RationalNumber) {
        var irregular = lhs.definition
        irregular.numerator ×= rhs.denominator
        irregular.denominator ×= rhs.numerator
        lhs.definition = irregular
    }

    // MARK: - RationalNumberProtocol

    // [_Define Documentation: SDGCornerstone.RationalNumberProtocol.reducedSimpleFraction()_]
    /// Returns the numerator and denominator of the number as a reduced simple fraction.
    public func reducedSimpleFraction() -> (numerator: Integer, denominator: Integer) {
        return (numerator, denominator)
    }

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
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
