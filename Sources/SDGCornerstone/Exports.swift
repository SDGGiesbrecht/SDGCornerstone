/*
 Exports.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

// #workaround(Swift 4.2, Compensate because @_export drops operator definitions.)

// SDGLogic
infix operator ≠: ComparisonPrecedence
prefix operator ¬
infix operator ∧: LogicalConjunctionPrecedence
infix operator ∧=: AssignmentPrecedence
infix operator ∨: LogicalDisjunctionPrecedence
infix operator ∨=: AssignmentPrecedence

// SDGMathematics
infix operator ≤: ComparisonPrecedence
infix operator ≥: ComparisonPrecedence
infix operator ≈: ComparisonPrecedence
infix operator −: AdditionPrecedence
prefix operator −
infix operator −=: AssignmentPrecedence
postfix operator −=
infix operator ±: AdditionPrecedence
prefix operator |
postfix operator |
prefix operator ∑
infix operator ×: MultiplicationPrecedence
infix operator ×=: AssignmentPrecedence
infix operator ÷: MultiplicationPrecedence
infix operator ÷=: AssignmentPrecedence
prefix operator ∏
precedencegroup ExponentPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}
infix operator ↑: ExponentPrecedence
infix operator ↑=: AssignmentPrecedence
prefix operator √
postfix operator √=
postfix operator °
postfix operator ′
postfix operator ′′

// SDGCollections
infix operator ∈: ComparisonPrecedence
infix operator ∉: ComparisonPrecedence
infix operator ∋: ComparisonPrecedence
infix operator ∌: ComparisonPrecedence
precedencegroup BinarySetOperationPrecedence {
    lowerThan: RangeFormationPrecedence
    higherThan: ComparisonPrecedence
}
infix operator ∩: BinarySetOperationPrecedence
infix operator ∩=: AssignmentPrecedence
infix operator ∪: BinarySetOperationPrecedence
infix operator ∪=: AssignmentPrecedence
postfix operator ′=
infix operator ∖: BinarySetOperationPrecedence
infix operator ∖=: AssignmentPrecedence
infix operator ∆: BinarySetOperationPrecedence
infix operator ∆=: AssignmentPrecedence
infix operator ⊆: ComparisonPrecedence
infix operator ⊈: ComparisonPrecedence
infix operator ⊇: ComparisonPrecedence
infix operator ⊉: ComparisonPrecedence
infix operator ⊊: ComparisonPrecedence
infix operator ⊋: ComparisonPrecedence

func aFunctionToTriggerTestCoverage() {} // @exempt(from: tests)
