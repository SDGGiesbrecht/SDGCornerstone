/*
 Exports.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@_exported import SDGControlFlow
@_exported import SDGLogic
@_exported import SDGMathematics
@_exported import SDGCollections
@_exported import SDGBinaryData
@_exported import SDGText
@_exported import SDGPersistence
@_exported import SDGRandomization
@_exported import SDGLocalization
@_exported import SDGGeometry
@_exported import SDGCalendar
@_exported import SDGPrecisionMathematics
@_exported import SDGConcurrency
@_exported import SDGExternalProcess

// #workaround(Swift 5.0, Compensate because @_export drops operator definitions.)

// SDGLogic
// #documentation(SDGCornerstone.≠)
/// Checks for inequality.
infix operator ≠: ComparisonPrecedence
// #documentation(SDGCornerstone.¬)
/// Performs logical inversion.
prefix operator ¬
// #documentation(SDGCornerstone.∧)
/// Performs logical conjunction.
infix operator ∧: LogicalConjunctionPrecedence
// #documentation(SDGCornerstone.∧=)
/// Assigns to the logical conjunction.
infix operator ∧=: AssignmentPrecedence
// #documentation(SDGCornerstone.∨)
/// Performs logical disjunction.
infix operator ∨: LogicalDisjunctionPrecedence
// #documentation(SDGCornerstone.∨=)
/// Assigns to the logical disjunction.
infix operator ∨=: AssignmentPrecedence

// SDGMathematics
// #documentation(SDGCornerstone.≤)
/// Checks for either inferiority or equality.
infix operator ≤: ComparisonPrecedence
// #documentation(SDGCornerstone.≥)
/// Checks for either superiority or equality.
infix operator ≥: ComparisonPrecedence
// #documentation(SDGCornerstone.≈)
/// Checks for approximate equality.
infix operator ≈: ComparisonPrecedence
// #documentation(SDGCornerstone.−)
/// Performs subtraction.
infix operator −: AdditionPrecedence
// #documentation(SDGCornerstone.−.prefix)
/// Performs additive inversion.
prefix operator −
// #documentation(SDGCornerstone.−=)
/// Assigns to the difference.
infix operator −=: AssignmentPrecedence
// #documentation(SDGCornerstone.±)
/// Performs both addition and subtraction.
infix operator ±: AdditionPrecedence
// #documentation(SDGCornerstone.|.prefix)
/// Returns the absolute value (in conjuction with postfix `|`).
prefix operator |
// #documentation(SDGCornerstone.|.suffix)
/// Returns the absolute value (in conjuction with prefix `|`).
postfix operator |
// #documentation(SDGCornerstone.∑)
/// Performs summation.
prefix operator ∑
// #documentation(SDGCornerstone.×)
/// Performs multiplication.
infix operator ×: MultiplicationPrecedence
// #documentation(SDGCornerstone.×=)
/// Assigns to the product.
infix operator ×=: AssignmentPrecedence
// #documentation(SDGCornerstone.÷)
/// Performs division.
infix operator ÷: MultiplicationPrecedence
// #documentation(SDGCornerstone.÷=)
/// Assigns to the dividend.
infix operator ÷=: AssignmentPrecedence
// #documentation(SDGCornerstone.∏)
/// Returns the product.
prefix operator ∏
// #documentation(SDGCornerstone.ExponentPrecedence)
/// The precedence of exponentiation.
precedencegroup ExponentPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}
// #documentation(SDGCornerstone.↑)
/// Performs exponentiation.
infix operator ↑: ExponentPrecedence
// #documentation(SDGCornerstone.↑=)
/// Assigns to the power.
infix operator ↑=: AssignmentPrecedence
// #documentation(SDGCornerstone.√)
/// Returns the square root.
prefix operator √
// #documentation(SDGCornerstone.√=)
/// Assigns to the square root.
postfix operator √=
// #documentation(SDGCornerstone.°)
/// Creates a measurement in degrees.
postfix operator °
// #documentation(SDGCornerstone.′)
/// Creates a measurement in minutes.
postfix operator ′
// #documentation(SDGCornerstone.′′)
/// Creates a measurement in seconds.
postfix operator ′′

// SDGCollections
// #documentation(SDGCornerstone.∈)
/// Checks for set membership.
infix operator ∈: ComparisonPrecedence
// #documentation(SDGCornerstone.∉)
/// Checks for non‐membership.
infix operator ∉: ComparisonPrecedence
// #documentation(SDGCornerstone.∋)
/// Checks for containment.
infix operator ∋: ComparisonPrecedence
// #documentation(SDGCornerstone.∌)
/// Checks for non‐containment.
infix operator ∌: ComparisonPrecedence
// #documentation(SDGCornerstone.BinarySetOperationPrecedence)
/// The precedence of binary set operations.
precedencegroup BinarySetOperationPrecedence {
    lowerThan: RangeFormationPrecedence
    higherThan: ComparisonPrecedence
}
// #documentation(SDGCornerstone.∩)
/// Performs intersection.
infix operator ∩: BinarySetOperationPrecedence
// #documentation(SDGCornerstone.∩=)
/// Assigns to the intersection.
infix operator ∩=: AssignmentPrecedence
// #documentation(SDGCornerstone.∪)
/// Performs union.
infix operator ∪: BinarySetOperationPrecedence
// #documentation(SDGCornerstone.∪=)
/// Assigns to the union.
infix operator ∪=: AssignmentPrecedence
// #documentation(SDGCornerstone.′=)
/// Assigns to the absolute complement.
postfix operator ′=
// #documentation(SDGCornerstone.∖)
/// Returns the relative complement.
infix operator ∖: BinarySetOperationPrecedence
// #documentation(SDGCornerstone.∖=)
/// Assings to the relative complement.
infix operator ∖=: AssignmentPrecedence
// #documentation(SDGCornerstone.∆)
/// Returns the symmetric difference.
infix operator ∆: BinarySetOperationPrecedence
// #documentation(SDGCornerstone.∆=)
/// Assigns to the symmetric difference.
infix operator ∆=: AssignmentPrecedence
// #documentation(SDGCornerstone.⊆)
/// Checks for a subset relationship.
infix operator ⊆: ComparisonPrecedence
// #documentation(SDGCornerstone.⊈)
/// Checks for a non‐subset relationship.
infix operator ⊈: ComparisonPrecedence
// #documentation(SDGCornerstone.⊇)
/// Checks for a superset relationship.
infix operator ⊇: ComparisonPrecedence
// #documentation(SDGCornerstone.⊉)
/// Checks for a non‐superset relationship.
infix operator ⊉: ComparisonPrecedence
// #documentation(SDGCornerstone.⊊)
/// Checks for a strict subset relationship.
infix operator ⊊: ComparisonPrecedence
// #documentation(SDGCornerstone.⊋)
/// Checks for a strict superset relationship.
infix operator ⊋: ComparisonPrecedence

func aFunctionToTriggerTestCoverage() {} // @exempt(from: tests)
