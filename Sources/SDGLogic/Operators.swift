/*
 Operators.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #documentation(SDGCornerstone.Equatable.≠)
/// Returns `true` if the two values are inequal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
infix operator ≠: ComparisonPrecedence

// #documentation(SDGCornerstone.Bool.¬)
/// Returns the logical inverse of the operand.
///
/// - Parameters:
///     - proposition: The proposition to invert.
prefix operator ¬

// #documentation(SDGCornerstone.Bool.∧)
/// Returns the logical conjunction of the two Boolean values.
///
/// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` evaluates to `true`.
///
/// - Parameters:
///     - precedingValue: A Boolean value.
///     - followingValue: A closure that results in another Boolean value.
infix operator ∧: LogicalConjunctionPrecedence

// #documentation(SDGCornerstone.Bool.∧=)
/// Modifies the preceding operand by logical conjunction with the following operand.
///
/// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` is `true`.
///
/// - Parameters:
///     - precedingValue: The Boolean value to modify.
///     - followingValue: A closure that results in another Boolean value.
infix operator ∧=: AssignmentPrecedence

// #documentation(SDGCornerstone.Bool.∨)
/// Returns the logical disjunction of the two Boolean values.
///
/// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` evaluates to `false`.
///
/// - Parameters:
///     - precedingValue: A Boolean value.
///     - followingValue: A closure that results in another Boolean value.
infix operator ∨: LogicalDisjunctionPrecedence

// #documentation(SDGCornerstone.Bool.∨=)
/// Modifies the preceding operand by logical disjunction with the following operand.
///
/// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` is `false`.
///
/// - Parameters:
///     - precedingValue: The Boolean value to modify.
///     - followingValue: A closure that results in another Boolean value.
infix operator ∨=: AssignmentPrecedence
