/*
 Operators.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// @documentation(SDGCornerstone.≠)
/// Checks for inequality.
infix operator ≠: ComparisonPrecedence

// @documentation(SDGCornerstone.¬)
/// Performs logical inversion.
prefix operator ¬

// @documentation(SDGCornerstone.∧)
/// Performs logical conjunction.
infix operator ∧: LogicalConjunctionPrecedence

// @documentation(SDGCornerstone.∧=)
/// Assigns to the logical conjunction.
infix operator ∧=: AssignmentPrecedence

// @documentation(SDGCornerstone.∨)
/// Performs logical disjunction.
infix operator ∨: LogicalDisjunctionPrecedence

// @documentation(SDGCornerstone.∨=)
/// Assigns to the logical disjunction.
infix operator ∨=: AssignmentPrecedence
