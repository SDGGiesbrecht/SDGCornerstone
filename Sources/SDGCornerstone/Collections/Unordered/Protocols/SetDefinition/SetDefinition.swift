/*
 SetDefinition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∈_]
/// Returns `true` if `lhs` is an element of `rhs`.
///
/// - Parameters:
///     - lhs: The element to test.
///     - rhs: The set.
infix operator ∈: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∉_]
/// Returns `true` if `lhs` is not an element of `rhs`.
///
/// - Parameters:
///     - lhs: The element to test.
///     - rhs: The set.
infix operator ∉: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
/// Returns `true` if `lhs` contains `rhs`.
///
/// - Parameters:
///     - lhs: The set.
///     - rhs: The element to test.
infix operator ∋: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∌_]
/// Returns `true` if `lhs` does not contain `rhs`.
///
/// - Parameters:
///     - lhs: The set.
///     - rhs: The element to test.
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
///     - lhs: A set.
///     - rhs: Another set.
infix operator ∩: BinarySetOperationPrecedence

// [_Inherit Documentation: SDGCornerstone.MutableSet.∩=_]
/// Sets `lhs` to the intersection of the two sets.
///
/// - Parameters:
///     - lhs: A set.
///     - rhs: Another set.
infix operator ∩=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
/// Returns the union of the two sets.
///
/// - Parameters:
///     - lhs: A set.
///     - rhs: Another set.
infix operator ∪: BinarySetOperationPrecedence

// [_Inherit Documentation: SDGCornerstone.MutableSet.∪=_]
/// Sets `lhs` to the union of the two sets.
///
/// - Parameters:
///     - lhs: A set.
///     - rhs: Another set.
infix operator ∪=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.RepresentableUniverse.′=_]
/// Sets the operand to its absolute complement.
///
/// - Parameters:
///     - operand: The set.
postfix operator ′=

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
/// Returns the relative complement of `rhs` in `lhs`.
///
/// - Parameters:
///     - lhs: The set to subtract from.
///     - rhs: The set to subtract.
infix operator ∖: BinarySetOperationPrecedence

// [_Inherit Documentation: SDGCornerstone.MutableSet.∖=_]
/// Subtracts `rhs` from `lhs`.
///
/// - Parameters:
///     - lhs: The set to subtract from.
///     - rhs: The set to subtract.
infix operator ∖=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
/// Returns the symmetric difference of `rhs` in `lhs`.
///
/// - Parameters:
///     - lhs: A set.
///     - rhs: Another set.
infix operator ∆: BinarySetOperationPrecedence

// [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
/// Sets `lhs` to the symmetric difference of the two sets.
///
/// - Parameters:
///     - lhs: A set.
///     - rhs: Another set.
infix operator ∆=: AssignmentPrecedence

/// A type that defines a set.
///
/// Conformance Requirements:
///
/// - `static func ∋ (lhs: Element, rhs: Self) -> Bool`
public protocol SetDefinition {

    // [_Define Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    associatedtype Element

    // MARK: - Membership

    // [_Define Documentation: SDGCornerstone.SetDefinition.∈_]
    /// Returns `true` if `lhs` is an element of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The element to test.
    ///     - rhs: The set.
    static func ∈ (lhs: Element, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∉_]
    /// Returns `true` if `lhs` is not an element of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The element to test.
    ///     - rhs: The set.
    static func ∉ (lhs: Element, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `lhs` contains `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    static func ∋ (lhs: Self, rhs: Element) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∌_]
    /// Returns `true` if `lhs` does not contain `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    static func ∌ (lhs: Self, rhs: Element) -> Bool
}

extension SetDefinition {

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∈_]
    /// Returns `true` if `lhs` is an element of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The element to test.
    ///     - rhs: The set.
    public static func ∈ (lhs: Element, rhs: Self) -> Bool {
        return rhs ∋ lhs
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∉_]
    /// Returns `true` if `lhs` is not an element of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The element to test.
    ///     - rhs: The set.
    public static func ∉ (lhs: Element, rhs: Self) -> Bool {
        return ¬(lhs ∈ rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∌_]
    /// Returns `true` if `lhs` does not contain `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    public static func ∌ (lhs: Self, rhs: Element) -> Bool {
        return ¬(lhs ∋ rhs)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∩ <S : SetDefinition>(lhs: Self, rhs: S) -> Intersection<Self, S> {
        return Intersection(lhs, rhs)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∪ <S : SetDefinition>(lhs: Self, rhs: S) -> Union<Self, S> {
        return Union(lhs, rhs)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∖ <S : SetDefinition>(lhs: Self, rhs: S) -> RelativeComplement<Self, S> {
        return RelativeComplement(of: rhs, in: lhs)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.′_]
    /// Returns the absolute complement of the set.
    ///
    /// - Parameters:
    ///     - operand: The set.
    public static postfix func ′(operand: Self) -> AbsoluteComplement<Self> {
        return AbsoluteComplement(operand)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the symmetric difference of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∆ <S : SetDefinition>(lhs: Self, rhs: S) -> SymmetricDifference<Self, S> {
        return SymmetricDifference(lhs, rhs)
    }
}

extension SetDefinition where Self : RangeFamily {
    // MARK: - where Self : RangeFamily

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `lhs` contains `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    public static func ∋ (lhs: Self, rhs: Bound) -> Bool {
        return lhs.contains(rhs)
    }
}
