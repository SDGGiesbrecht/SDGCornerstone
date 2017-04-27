/*
 Integer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Example 1: WholeNumber Literals_]
/// An arbitrary‐precision integer.
///
/// ```swift
/// let million: WholeNumber = 1_000_000
/// let decillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000"
/// let yobiMultiplier: WholeNumber = "0b 1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000"
/// ```
public struct Integer : Addable, Comparable, Equatable, IntegerType, IntegralArithmetic, Negatable, PointType, Subtractable, WholeArithmetic {

    // MARK: - Initialization

    private init(magnitude: WholeNumber, isNegative: Bool) {
        self.definition = Definition(magnitude: magnitude, isNegative: isNegative)
    }

    /// Creates an instance from a whole number.
    public init(_ wholeNumber: WholeNumber) {
        self.init(magnitude: wholeNumber, isNegative: false)
    }

    // MARK: - Properties

    private struct Definition {
        fileprivate var magnitude: WholeNumber
        fileprivate var isNegative: Bool
    }
    private var unsafeDefinition = Definition(magnitude: 0, isNegative: false)
    private var definition: Definition {
        get {
            return unsafeDefinition
        }
        set {
            unsafeDefinition = newValue

            // Normalize

            if unsafeDefinition.isNegative ∧ unsafeDefinition.magnitude == 0 {
                unsafeDefinition.isNegative = false
            }
        }
    }

    /// The magnitude.
    public private(set) var magnitude: WholeNumber {
        get {
            return definition.magnitude
        }
        set {
            definition.magnitude = newValue
        }
    }
    // [_Inherit Documentation: SDGCornerstone.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    public private(set) var isNegative: Bool {
        get {
            return definition.isNegative
        }
        set {
            definition.isNegative = newValue
        }
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
    public static func += (lhs: inout Integer, rhs: Integer) {

        if lhs.isNegative == rhs.isNegative {
            // Moving away from zero.
            lhs.magnitude += rhs.magnitude
        } else {
            // Approaching zero...
            if lhs.magnitude ≥ rhs.magnitude {
                // ...but stopping short of crossing it.
                lhs.magnitude −= rhs.magnitude
            } else {
                // ...and crossing it.
                lhs.magnitude = rhs.magnitude − lhs.magnitude
                lhs.isNegative¬=
            }
        }
    }

    // MARK: - Comparable

    // [_Inherit Documentition: SDGCornerstone.Comparable.<_]
    public static func < (lhs: Integer, rhs: Integer) -> Bool {
        if lhs.isNegative {
            if rhs.isNegative {
                // − vs −
                return lhs.magnitude > rhs.magnitude
            } else {
                // − vs +/0
                return true
            }
        } else {
            if rhs.isNegative {
                // +/0 vs −
                return false
            } else {
                // +/0 vs +/0
                return lhs.magnitude < rhs.magnitude
            }
        }
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: Integer, rhs: Integer) -> Bool {
        return (lhs.isNegative, lhs.magnitude) == (rhs.isNegative, rhs.magnitude)
    }

    // MARK: - IntegralArithmetic

    // [_Inherit Documentation: SDGCornerstone.IntegralArithmetic.init(int:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of `IntMax`.
    public init(_ int: IntMax) {
        magnitude = WholeNumber(UIntMax(|int|))
        isNegative = int.isNegative
    }

    // MARK: - Negatable

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Integer) {
        operand.isNegative¬=
    }

    // MARK: - PointType

    // [_Inherit Documentation: SDGCornerstone.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Integer

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
    public static func −= (lhs: inout Integer, rhs: Integer) {
        lhs += −rhs
    }

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(uInt:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of `UIntMax`.
    public init(_ uInt: UIntMax) {
        self.init(WholeNumber(uInt))
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
    public static func ×= (lhs: inout Integer, rhs: Integer) {
        lhs.magnitude ×= rhs.magnitude
        if lhs.isNegative == rhs.isNegative {
            lhs.isNegative = false
        } else {
            lhs.isNegative = true
        }
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
    public mutating func divideAccordingToEuclid(by divisor: Integer) {

        let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

        let needsToWrapToPrevious = negative ∧ ¬magnitude.isDivisible(by: divisor.magnitude)
        // Wrap to previous if negative (ignoring when exactly even)

        magnitude.divideAccordingToEuclid(by: divisor.magnitude)
        isNegative = negative

        if needsToWrapToPrevious {
            self −= 1
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Integer>, fromRandomizer randomizer: Randomizer) {

        if range.lowerBound.isWhole {
            let wholeRange: ClosedRange<WholeNumber> = range.lowerBound.magnitude ... range.upperBound.magnitude
            let whole = WholeNumber(randomInRange: wholeRange, fromRandomizer: randomizer)
            self = Integer(whole)
        } else {
            let span = range.upperBound − range.lowerBound
            let wholeRange: ClosedRange<WholeNumber> = 0 ... span.magnitude
            let whole = WholeNumber(randomInRange: wholeRange, fromRandomizer: randomizer)
            self = range.lowerBound + Integer(whole)
        }
    }
}
