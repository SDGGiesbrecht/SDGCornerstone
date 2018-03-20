/*
 Exports.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@_exported import SDGCollections
@_exported import SDGTesting

// [_Workaround: Compensate because @_export drops operator definitions. (Swift 4.0.3)_]

// SDGLogic
infix operator ≠: ComparisonPrecedence

// SDGMathematics
postfix operator ′

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
