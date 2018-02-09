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
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
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
/// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` evaluates to `true`.
///
/// - Parameters:
///     - lhs: A Boolean value.
///     - rhs: A closure that results in another Boolean value.
infix operator ∧: LogicalConjunctionPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∧=_]
/// Modifies the left value by logical conjunction with the right.
///
/// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` is `true`.
///
/// - Parameters:
///     - lhs: The Boolean value to modify.
///     - rhs: A closure that results in another Boolean value.
infix operator ∧=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∨_]
/// Returns the logical disjunction of the two Boolean values.
///
/// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` evaluates to `false`.
///
/// - Parameters:
///     - lhs: A Boolean value.
///     - rhs: A closure that results in another Boolean value.
infix operator ∨: LogicalDisjunctionPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∨=_]
/// Modifies the left value by logical disjunction with the right.
///
/// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` is `false`.
///
/// - Parameters:
///     - lhs: The Boolean value to modify.
///     - rhs: A closure that results in another Boolean value.
infix operator ∨=: AssignmentPrecedence
