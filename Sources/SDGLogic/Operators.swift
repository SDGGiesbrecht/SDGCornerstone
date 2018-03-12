/*
 Operators.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
infix operator ≠: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.¬_]
/// Returns the logical inverse of the operand.
///
/// - Parameters:
///     - proposition: The proposition to invert.
prefix operator ¬

// [_Inherit Documentation: SDGCornerstone.Bool.¬=_]
/// Modifies the operand by logical inversion.
///
/// - Parameters:
///     - proposition: The proposition to modify by inversion.
postfix operator ¬=

// [_Inherit Documentation: SDGCornerstone.Bool.∧_]
/// Returns the logical conjunction of the two Boolean values.
///
/// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` evaluates to `true`.
///
/// - Parameters:
///     - precedingValue: A Boolean value.
///     - followingValue: A closure that results in another Boolean value.
infix operator ∧: LogicalConjunctionPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∧=_]
/// Modifies the preceding operand by logical conjunction with the following operand.
///
/// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` is `true`.
///
/// - Parameters:
///     - precedingValue: The Boolean value to modify.
///     - followingValue: A closure that results in another Boolean value.
infix operator ∧=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∨_]
/// Returns the logical disjunction of the two Boolean values.
///
/// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` evaluates to `false`.
///
/// - Parameters:
///     - precedingValue: A Boolean value.
///     - followingValue: A closure that results in another Boolean value.
infix operator ∨: LogicalDisjunctionPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∨=_]
/// Modifies the preceding operand by logical disjunction with the following operand.
///
/// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` is `false`.
///
/// - Parameters:
///     - precedingValue: The Boolean value to modify.
///     - followingValue: A closure that results in another Boolean value.
infix operator ∨=: AssignmentPrecedence
