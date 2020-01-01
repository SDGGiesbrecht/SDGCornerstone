/*
 Operators.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Context

internal var inTheProcessOfTailoring: Bool = false
internal var tailoringRoot: CollationOrder?

// MARK: - Operators

/// The precedence of tailoring rules which anchor to the preceding operand.
precedencegroup TailoringRuleAnchoredToPreceding {
  associativity: left
}

/// The precedence of tailoring rules which anchor to the following operand.
precedencegroup TailoringRuleAnchoredToFollowing {
  associativity: right
}

/// Moves the following operand to be the same as the preceding operand up until the scalar level.
infix operator ←=: TailoringRuleAnchoredToPreceding

/// Moves the preceding operand to be the same as the following up until the scalar level.
infix operator =→: TailoringRuleAnchoredToFollowing

/// Moves the following operand so that it comes after the preceding operand at the primary level.
infix operator ←<: TailoringRuleAnchoredToPreceding

/// Moves the preceding operand so that it comes before the following operand at the primary level.
infix operator <→: TailoringRuleAnchoredToFollowing

/// Moves the following operand so that it comes after the preceding operand at the reverse accent level.
infix operator ←<<: TailoringRuleAnchoredToPreceding

/// Moves the preceding operand so that it comes before the following operand at the reverse accent level.
infix operator <<→: TailoringRuleAnchoredToFollowing

/// Moves the following operand so that it comes after the preceding operand at the forward accent level.
infix operator ←<<<: TailoringRuleAnchoredToPreceding

/// Moves the preceding operand so that it comes before the following operand at the forward accent level.
infix operator <<<→: TailoringRuleAnchoredToFollowing

/// Moves the following operand so that it comes after the preceding operand at the case level.
infix operator ←<<<<: TailoringRuleAnchoredToPreceding

/// Moves the preceding operand so that it comes before the following operand at the case level.
infix operator <<<<→: TailoringRuleAnchoredToFollowing

/// Moves the following operand so that it comes after the preceding operand at the punctuation level.
infix operator ←<<<<<: TailoringRuleAnchoredToPreceding

/// Moves the preceding operand so that it comes before the following operand at the punctuation level.
infix operator <<<<<→: TailoringRuleAnchoredToFollowing

/// Moves the following operand so that it comes after the preceding operand at the script level.
infix operator ←<<<<<<: TailoringRuleAnchoredToPreceding

/// Moves the preceding operand so that it comes before the following operand at the script level.
infix operator <<<<<<→: TailoringRuleAnchoredToFollowing
