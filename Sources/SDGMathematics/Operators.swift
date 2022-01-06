/*
 Operators.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// @documentation(SDGCornerstone.≤)
/// Checks for either inferiority or equality.
infix operator ≤: ComparisonPrecedence

// @documentation(SDGCornerstone.≥)
/// Checks for either superiority or equality.
infix operator ≥: ComparisonPrecedence

// @documentation(SDGCornerstone.≈)
/// Checks for approximate equality.
infix operator ≈: ComparisonPrecedence

// @documentation(SDGCornerstone.−)
/// Performs subtraction.
infix operator −: AdditionPrecedence

// @documentation(SDGCornerstone.−.prefix)
/// Performs additive inversion.
prefix operator −

// @documentation(SDGCornerstone.−=)
/// Assigns to the difference.
infix operator −=: AssignmentPrecedence

// @documentation(SDGCornerstone.±)
/// Performs both addition and subtraction.
infix operator ±: AdditionPrecedence

// @documentation(SDGCornerstone.|.prefix)
/// Returns the absolute value (in conjuction with postfix `|`).
prefix operator |

// @documentation(SDGCornerstone.|.suffix)
/// Returns the absolute value (in conjuction with prefix `|`).
postfix operator |

// @documentation(SDGCornerstone.∑)
/// Performs summation.
prefix operator ∑

// @documentation(SDGCornerstone.×)
/// Performs multiplication.
infix operator ×: MultiplicationPrecedence

// @documentation(SDGCornerstone.×=)
/// Assigns to the product.
infix operator ×=: AssignmentPrecedence

// @documentation(SDGCornerstone.÷)
/// Performs division.
infix operator ÷: MultiplicationPrecedence

// @documentation(SDGCornerstone.÷=)
/// Assigns to the dividend.
infix operator ÷=: AssignmentPrecedence

// @documentation(SDGCornerstone.∏)
/// Returns the product.
prefix operator ∏

// @documentation(SDGCornerstone.ExponentPrecedence)
/// The precedence of exponentiation.
precedencegroup ExponentPrecedence {
  associativity: right
  higherThan: MultiplicationPrecedence
}

// @documentation(SDGCornerstone.↑)
/// Performs exponentiation.
infix operator ↑: ExponentPrecedence

// @documentation(SDGCornerstone.↑=)
/// Assigns to the power.
infix operator ↑=: AssignmentPrecedence

// @documentation(SDGCornerstone.√)
/// Returns the square root.
prefix operator √

// @documentation(SDGCornerstone.√=)
/// Assigns to the square root.
postfix operator √=

// @documentation(SDGCornerstone.°)
/// Creates a measurement in degrees.
postfix operator °

// @documentation(SDGCornerstone.′)
/// Creates a measurement in minutes.
postfix operator ′

// @documentation(SDGCornerstone.′′)
/// Creates a measurement in seconds.
postfix operator ′′
