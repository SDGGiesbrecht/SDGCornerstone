/*
 Integer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematicsCore

// [_Example 1: WholeNumber Literals_]
/// An arbitrary‐precision integer.
///
/// ```swift
/// let million: WholeNumber = 1_000_000
/// let decillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000"
/// let yobiMultiplier = WholeNumber(binary: "1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000")
/// ```
public struct Integer : Addable, CodableViaIntegerProtocol, Comparable, Equatable, Hashable, IntegerProtocol, IntegralArithmetic, Negatable, PointProtocol, Subtractable, WholeArithmetic {

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

    internal private(set) var wholeMagnitude: WholeNumber {
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
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    public static func += (precedingValue: inout Integer, followingValue: Integer) {

        if precedingValue.isNegative == followingValue.isNegative {
            // Moving away from zero.
            precedingValue.wholeMagnitude += followingValue.wholeMagnitude
        } else {
            // Approaching zero...
            if precedingValue.wholeMagnitude ≥ followingValue.wholeMagnitude {
                // ...but stopping short of crossing it.
                precedingValue.wholeMagnitude −= followingValue.wholeMagnitude
            } else {
                // ...and crossing it.
                precedingValue.wholeMagnitude = followingValue.wholeMagnitude − precedingValue.wholeMagnitude
                precedingValue.isNegative¬=
            }
        }
    }

    // MARK: - Comparable

    // [_Inherit Documentition: SDGCornerstone.Comparable.<_]
    public static func < (precedingValue: Integer, followingValue: Integer) -> Bool {
        if precedingValue.isNegative {
            if followingValue.isNegative {
                // − vs −
                return precedingValue.wholeMagnitude > followingValue.wholeMagnitude
            } else {
                // − vs +/0
                return true
            }
        } else {
            if followingValue.isNegative {
                // +/0 vs −
                return false
            } else {
                // +/0 vs +/0
                return precedingValue.wholeMagnitude < followingValue.wholeMagnitude
            }
        }
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (precedingValue: Integer, followingValue: Integer) -> Bool {
        return (precedingValue.isNegative, precedingValue.wholeMagnitude) == (followingValue.isNegative, followingValue.wholeMagnitude)
    }

    // MARK: - Hashable

    // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
    /// The hash value.
    public var hashValue: Int {
        return wholeMagnitude.hashValue
    }

    // MARK: - IntegralArithmetic

    // [_Inherit Documentation: SDGCornerstone.IntegralArithmetic.init(int:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of `IntMax`.
    public init(_ int: IntMax) {
        let magnitude: UIntMax
        if int == IntMax.min { // |int| would overflow.
            magnitude = UIntMax(|(int + 1)|) + 1
        } else {
            magnitude = UIntMax(|int|)
        }
        wholeMagnitude = WholeNumber(magnitude)
        isNegative = int.isNegative
    }

    // MARK: - Negatable

    // [_Inherit Documentation: SDGCornerstone.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    public static postfix func −= (operand: inout Integer) {
        operand.isNegative¬=
    }

    // MARK: - Numeric

    // [_Inherit Documentation: SDGCornerstone.Numeric.init(exactly:)_]
    /// Creates a new instance from the given integer, if it can be represented exactly.
    public init?<T>(exactly source: T) where T : BinaryInteger {
        if let whole = WholeNumber(exactly: source) {
            self.init(whole)
            return
        } else if let integer = IntMax(exactly: source) {
            self.init(integer)
            return
        } else {
            unreachable()
        }
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Integer

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout Integer, followingValue: Integer) {
        precedingValue += −followingValue
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
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    public static func ×= (precedingValue: inout Integer, followingValue: Integer) {
        precedingValue.wholeMagnitude ×= followingValue.wholeMagnitude
        if precedingValue.isNegative == followingValue.isNegative {
            precedingValue.isNegative = false
        } else {
            precedingValue.isNegative = true
        }
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    public mutating func divideAccordingToEuclid(by divisor: Integer) {

        let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

        let needsToWrapToPrevious = negative ∧ ¬wholeMagnitude.isDivisible(by: divisor.wholeMagnitude)
        // Wrap to previous if negative (ignoring when exactly even)

        wholeMagnitude.divideAccordingToEuclid(by: divisor.wholeMagnitude)
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
            let wholeRange: ClosedRange<WholeNumber> = range.lowerBound.wholeMagnitude ... range.upperBound.wholeMagnitude
            let whole = WholeNumber(randomInRange: wholeRange, fromRandomizer: randomizer)
            self = Integer(whole)
        } else {
            let span = range.upperBound − range.lowerBound
            let wholeRange: ClosedRange<WholeNumber> = 0 ... span.wholeMagnitude
            let whole = WholeNumber(randomInRange: wholeRange, fromRandomizer: randomizer)
            self = range.lowerBound + Integer(whole)
        }
    }
}
