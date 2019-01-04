/*
 Operators.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #documentation(SDGCornerstone.Comparable.≤)
/// Returns `true` if the preceding operand is ordered before or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
infix operator ≤: ComparisonPrecedence

// #documentation(SDGCornerstone.Comparable.≥)
/// Returns `true` if the preceding operand is ordered after or the same as the following operand.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
infix operator ≥: ComparisonPrecedence

// #documentation(SDGCornerstone.Comparable.≈)
/// Returns `true` if `precedingValue` is within the range described by `followingValue`.
///
/// ```swift
/// XCTAssert(1 ÷ 3 ≈ 0.33333 ± 0.00001)
/// ```
///
/// - Parameters:
///     - precedingValue: The value to test.
///     - followingValue: The bounds of the range.
infix operator ≈: ComparisonPrecedence

// #documentation(SDGCornerstone.Subtractable.−)
/// Returns the difference of the preceding value minus the following value.
///
/// - Parameters:
///     - precedingValue: The starting value.
///     - followingValue: The value to subtract.
infix operator −: AdditionPrecedence

/// Performs additive inversion.
prefix operator −

// #documentation(SDGCornerstone.Subtractable.−=)
/// Subtracts the following value from the preceding value.
///
/// - Parameters:
///     - precedingValue: The value to modify.
///     - followingValue: The value to subtract.
infix operator −=: AssignmentPrecedence

// #documentation(SDGCornerstone.Subtractable.±)
/// Returns a tuple containing the sum and difference of `precedingValue` and `followingValue`.
///
/// - Parameters:
///     - precedingValue: The augend/minuend.
///     - followingValue: The addend/subtrahend.
infix operator ±: AdditionPrecedence

// #documentation(SDGCornerstone.NumericAdditiveArithmetic.|x)
/// Returns the absolute value (in conjuction with postfix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// XCTAssertEqual(y, 1)
/// ```
prefix operator |

// #documentation(SDGCornerstone.NumericAdditiveArithmetic.x|)
/// Returns the absolute value (in conjuction with prefix `|(_:)`).
///
/// ```swift
/// let x = −1
/// let y = |x|
/// XCTAssertEqual(y, 1)
/// ```
postfix operator |

// #documentation(SDGCornerstone.Sequence.∑)
/// Returns the sum of all values in the sequence.
prefix operator ∑

// #documentation(SDGCornerstone.WholeArithmetic.×)
/// Returns the product of the preceding value times the following value.
///
/// - Parameters:
///     - precedingValue: A value.
///     - followingValue: Another value.
infix operator ×: MultiplicationPrecedence

// #documentation(SDGCornerstone.WholeArithmetic.×=)
/// Modifies the preceding value by multiplication with the following value.
///
/// - Parameters:
///     - precedingValue: The value to modify.
///     - followingValue: The coefficient by which to multiply.
infix operator ×=: AssignmentPrecedence

// #documentation(SDGCornerstone.RationalArithmetic.÷)
/// Returns the (rational) quotient of the preceding value divided by the following value.
///
/// - Parameters:
///     - precedingValue: The dividend.
///     - followingValue: The divisor.
infix operator ÷: MultiplicationPrecedence

// #documentation(SDGCornerstone.RationalArithmetic.÷=)
/// Modifies the preceding value by dividing it by the following value.
///
/// - Parameters:
///     - precedingValue: The value to modify.
///     - followingValue: The divisor.
infix operator ÷=: AssignmentPrecedence

// #documentation(SDGCornerstone.Sequence.∏)
/// Returns the product of all values in the sequence.
prefix operator ∏

/// A precedence group for exponent operators. (e.g. ↑)
///
/// Precedence: before `MultiplicationPrecedence`
///
/// Associativity: The last to appear is executed first.
precedencegroup ExponentPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

// #documentation(SDGCornerstone.WholeArithmetic.↑)
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
infix operator ↑: ExponentPrecedence

// #documentation(SDGCornerstone.WholeArithmetic.↑=)
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
infix operator ↑=: AssignmentPrecedence

// #documentation(SDGCornerstone.RealArithmetic.√)
/// Returns the square root of `operand`.
///
/// - Parameters:
///     - operand: The radicand.
prefix operator √

// #documentation(SDGCornerstone.RealArithmetic.√=)
/// Sets `operand` to its square root.
///
/// - Parameters:
///     - operand: The value to modify.
postfix operator √=

// #documentation(SDGCornerstone.RealArithmetic.°)
/// Returns an angle in degrees.
///
/// - Parameters:
///     - value: The value in degrees.
postfix operator °

/// Returns a measurement in minutes, the absolute complement of a set, etc. Behaviour depends on the type.
///
/// - Parameters:
///     - operand: The operand.
postfix operator ′

// #documentation(SDGCornerstone.RealArithmetic.′′)
/// Returns an angle in seconds.
///
/// - Parameters:
///     - value: The value in seconds.
postfix operator ′′
