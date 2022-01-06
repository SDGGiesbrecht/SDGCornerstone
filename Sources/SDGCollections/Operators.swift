/*
 Operators.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// @documentation(SDGCornerstone.∈)
/// Checks for set membership.
infix operator ∈: ComparisonPrecedence

// @documentation(SDGCornerstone.∉)
/// Checks for non‐membership.
infix operator ∉: ComparisonPrecedence

// @documentation(SDGCornerstone.∋)
/// Checks for containment.
infix operator ∋: ComparisonPrecedence

// @documentation(SDGCornerstone.∌)
/// Checks for non‐containment.
infix operator ∌: ComparisonPrecedence

// @documentation(SDGCornerstone.BinarySetOperationPrecedence)
/// The precedence of binary set operations.
precedencegroup BinarySetOperationPrecedence {
  lowerThan: RangeFormationPrecedence
  higherThan: ComparisonPrecedence
}

// @documentation(SDGCornerstone.∩)
/// Performs intersection.
infix operator ∩: BinarySetOperationPrecedence

// @documentation(SDGCornerstone.∩=)
/// Assigns to the intersection.
infix operator ∩=: AssignmentPrecedence

// @documentation(SDGCornerstone.∪)
/// Performs union.
infix operator ∪: BinarySetOperationPrecedence

// @documentation(SDGCornerstone.∪=)
/// Assigns to the union.
infix operator ∪=: AssignmentPrecedence

// @documentation(SDGCornerstone.′=)
/// Assigns to the absolute complement.
postfix operator ′=

// @documentation(SDGCornerstone.∖)
/// Returns the relative complement.
infix operator ∖: BinarySetOperationPrecedence

// @documentation(SDGCornerstone.∖=)
/// Assings to the relative complement.
infix operator ∖=: AssignmentPrecedence

// @documentation(SDGCornerstone.∆)
/// Returns the symmetric difference.
infix operator ∆: BinarySetOperationPrecedence

// @documentation(SDGCornerstone.∆=)
/// Assigns to the symmetric difference.
infix operator ∆=: AssignmentPrecedence

// @documentation(SDGCornerstone.⊆)
/// Checks for a subset relationship.
infix operator ⊆: ComparisonPrecedence

// @documentation(SDGCornerstone.⊈)
/// Checks for a non‐subset relationship.
infix operator ⊈: ComparisonPrecedence

// @documentation(SDGCornerstone.⊇)
/// Checks for a superset relationship.
infix operator ⊇: ComparisonPrecedence

// @documentation(SDGCornerstone.⊉)
/// Checks for a non‐superset relationship.
infix operator ⊉: ComparisonPrecedence

// @documentation(SDGCornerstone.⊊)
/// Checks for a strict subset relationship.
infix operator ⊊: ComparisonPrecedence

// @documentation(SDGCornerstone.⊋)
/// Checks for a strict superset relationship.
infix operator ⊋: ComparisonPrecedence
