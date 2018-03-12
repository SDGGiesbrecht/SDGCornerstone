/*
 Exports.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@_exported import SDGMathematics
@_exported import SDGTesting

// [_Workaround: Compensate because @_export drops operator definitions. (Swift 4.0.3)_]

// SDGLogic
infix operator ≠: ComparisonPrecedence
prefix operator ¬
postfix operator ¬=
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
infix operator ×: MultiplicationPrecedence
infix operator ×=: AssignmentPrecedence
infix operator ÷: MultiplicationPrecedence
infix operator ÷=: AssignmentPrecedence
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
