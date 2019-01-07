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

// #workaround(Swift 4.2.1, Compensate because @_export drops operator definitions.)

// SDGLogic
// #documentation(SDGCornerstone.≠)
infix operator ≠: ComparisonPrecedence
// #documentation(SDGCornerstone.¬)
prefix operator ¬
// #documentation(SDGCornerstone.∧)
infix operator ∧: LogicalConjunctionPrecedence
// #documentation(SDGCornerstone.∧=)
infix operator ∧=: AssignmentPrecedence
// #documentation(SDGCornerstone.∨)
infix operator ∨: LogicalDisjunctionPrecedence
// #documentation(SDGCornerstone.∨=)
infix operator ∨=: AssignmentPrecedence

// SDGMathematics
// #documentation(SDGCornerstone.≤)
infix operator ≤: ComparisonPrecedence
// #documentation(SDGCornerstone.≥)
infix operator ≥: ComparisonPrecedence
// #documentation(SDGCornerstone.≈)
infix operator ≈: ComparisonPrecedence
// #documentation(SDGCornerstone.−)
infix operator −: AdditionPrecedence
// #documentation(SDGCornerstone.−.prefix)
prefix operator −
// #documentation(SDGCornerstone.−=)
infix operator −=: AssignmentPrecedence
// #documentation(SDGCornerstone.±)
infix operator ±: AdditionPrecedence
// #documentation(SDGCornerstone.|.prefix)
prefix operator |
// #documentation(SDGCornerstone.|.suffix)
postfix operator |
// #documentation(SDGCornerstone.∑)
prefix operator ∑
// #documentation(SDGCornerstone.×)
infix operator ×: MultiplicationPrecedence
// #documentation(SDGCornerstone.×=)
infix operator ×=: AssignmentPrecedence
// #documentation(SDGCornerstone.÷)
infix operator ÷: MultiplicationPrecedence
// #documentation(SDGCornerstone.÷=)
infix operator ÷=: AssignmentPrecedence
// #documentation(SDGCornerstone.∏)
prefix operator ∏
// #documentation(SDGCornerstone.ExponentPrecedence)
precedencegroup ExponentPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}
// #documentation(SDGCornerstone.↑)
infix operator ↑: ExponentPrecedence
// #documentation(SDGCornerstone.↑=)
infix operator ↑=: AssignmentPrecedence
// #documentation(SDGCornerstone.√)
prefix operator √
// #documentation(SDGCornerstone.√=)
postfix operator √=
// #documentation(SDGCornerstone.°)
postfix operator °
// #documentation(SDGCornerstone.′)
postfix operator ′
// #documentation(SDGCornerstone.′′)
postfix operator ′′

// SDGCollections
// #documentation(SDGCornerstone.∈)
infix operator ∈: ComparisonPrecedence
// #documentation(SDGCornerstone.∉)
infix operator ∉: ComparisonPrecedence
// #documentation(SDGCornerstone.∋)
infix operator ∋: ComparisonPrecedence
// #documentation(SDGCornerstone.∌)
infix operator ∌: ComparisonPrecedence
// #documentation(SDGCornerstone.BinarySetOperationPrecedence)
precedencegroup BinarySetOperationPrecedence {
    lowerThan: RangeFormationPrecedence
    higherThan: ComparisonPrecedence
}
// #documentation(SDGCornerstone.∩)
infix operator ∩: BinarySetOperationPrecedence
// #documentation(SDGCornerstone.∩=)
infix operator ∩=: AssignmentPrecedence
// #documentation(SDGCornerstone.∪)
infix operator ∪: BinarySetOperationPrecedence
// #documentation(SDGCornerstone.∪=)
infix operator ∪=: AssignmentPrecedence
// #documentation(SDGCornerstone.′=)
postfix operator ′=
// #documentation(SDGCornerstone.∖)
infix operator ∖: BinarySetOperationPrecedence
// #documentation(SDGCornerstone.∖=)
infix operator ∖=: AssignmentPrecedence
// #documentation(SDGCornerstone.∆)
infix operator ∆: BinarySetOperationPrecedence
// #documentation(SDGCornerstone.∆=)
infix operator ∆=: AssignmentPrecedence
// #documentation(SDGCornerstone.⊆)
infix operator ⊆: ComparisonPrecedence
// #documentation(SDGCornerstone.⊈)
infix operator ⊈: ComparisonPrecedence
// #documentation(SDGCornerstone.⊇)
infix operator ⊇: ComparisonPrecedence
// #documentation(SDGCornerstone.⊉)
infix operator ⊉: ComparisonPrecedence
// #documentation(SDGCornerstone.⊊)
infix operator ⊊: ComparisonPrecedence
// #documentation(SDGCornerstone.⊋)
infix operator ⊋: ComparisonPrecedence

func aFunctionToTriggerTestCoverage() {} // @exempt(from: tests)
