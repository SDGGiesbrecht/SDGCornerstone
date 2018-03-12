/*
 Operators.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∈_]
/// Returns `true` if `precedingValue` is an element of `followingValue`.
///
/// - Parameters:
///     - precedingValue: The element to test.
///     - followingValue: The set.
infix operator ∈: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∉_]
/// Returns `true` if `precedingValue` is not an element of `followingValue`.
///
/// - Parameters:
///     - precedingValue: The element to test.
///     - followingValue: The set.
infix operator ∉: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
/// Returns `true` if `precedingValue` contains `followingValue`.
///
/// - Parameters:
///     - precedingValue: The set.
///     - followingValue: The element to test.
infix operator ∋: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∌_]
/// Returns `true` if `precedingValue` does not contain `followingValue`.
///
/// - Parameters:
///     - precedingValue: The set.
///     - followingValue: The element to test.
infix operator ∌: ComparisonPrecedence

/// The precedence group for `∩`, `∪` and `∖`.
precedencegroup BinarySetOperationPrecedence {
    lowerThan: RangeFormationPrecedence
    higherThan: ComparisonPrecedence
}

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
/// Returns the intersection of the two sets.
///
/// - Parameters:
///     - precedingValue: A set.
///     - followingValue: Another set.
infix operator ∩: BinarySetOperationPrecedence

// [_Inherit Documentation: SDGCornerstone.MutableSet.∩=_]
/// Sets `precedingValue` to the intersection of the two sets.
///
/// - Parameters:
///     - precedingValue: A set.
///     - followingValue: Another set.
infix operator ∩=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
/// Returns the union of the two sets.
///
/// - Parameters:
///     - precedingValue: A set.
///     - followingValue: Another set.
infix operator ∪: BinarySetOperationPrecedence

// [_Inherit Documentation: SDGCornerstone.MutableSet.∪=_]
/// Sets `precedingValue` to the union of the two sets.
///
/// - Parameters:
///     - precedingValue: A set.
///     - followingValue: Another set.
infix operator ∪=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.RepresentableUniverse.′=_]
/// Sets the operand to its absolute complement.
///
/// - Parameters:
///     - operand: The set.
postfix operator ′=

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
/// Returns the relative complement of `followingValue` in `precedingValue`.
///
/// - Parameters:
///     - precedingValue: The set to subtract from.
///     - followingValue: The set to subtract.
infix operator ∖: BinarySetOperationPrecedence

// [_Inherit Documentation: SDGCornerstone.MutableSet.∖=_]
/// Subtracts `followingValue` from `precedingValue`.
///
/// - Parameters:
///     - precedingValue: The set to subtract from.
///     - followingValue: The set to subtract.
infix operator ∖=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
/// Returns the symmetric difference of `followingValue` in `precedingValue`.
///
/// - Parameters:
///     - precedingValue: A set.
///     - followingValue: Another set.
infix operator ∆: BinarySetOperationPrecedence

// [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
/// Sets `precedingValue` to the symmetric difference of the two sets.
///
/// - Parameters:
///     - precedingValue: A set.
///     - followingValue: Another set.
infix operator ∆=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
/// Returns `true` if `precedingValue` is a subset of `followingValue`.
///
/// - Parameters:
///     - precedingValue: The possible subset to test.
///     - followingValue: The other set.
infix operator ⊆: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
/// Returns `true` if `precedingValue` is a subset of `followingValue`.
///
/// - Parameters:
///     - precedingValue: The possible subset to test.
///     - followingValue: The other set.
infix operator ⊈: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
/// Returns `true` if `precedingValue` is a superset of `followingValue`.
///
/// - Parameters:
///     - precedingValue: The possible superset to test.
///     - followingValue: The other set.
infix operator ⊇: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
/// Returns `true` if `precedingValue` is a superset of `followingValue`.
///
/// - Parameters:
///     - precedingValue: The possible superset to test.
///     - followingValue: The other set.
infix operator ⊉: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
/// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
///
/// - Parameters:
///     - precedingValue: The possible subset to test.
///     - followingValue: The other set.
infix operator ⊊: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
/// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
///
/// - Parameters:
///     - precedingValue: The possible superset to test.
///     - followingValue: The other set.
infix operator ⊋: ComparisonPrecedence
