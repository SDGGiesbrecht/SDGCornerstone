/*
 Exports.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@_exported import SDGLogicCore // Equatable (≠)

// [_Workaround: Compensate because @_export drops operator definitions. (Swift 4.0.3)_]

// SDGLogicCore
infix operator ≠: ComparisonPrecedence
prefix operator ¬
postfix operator ¬=
infix operator ∧: LogicalConjunctionPrecedence
infix operator ∧=: AssignmentPrecedence
infix operator ∨: LogicalDisjunctionPrecedence
infix operator ∨=: AssignmentPrecedence
