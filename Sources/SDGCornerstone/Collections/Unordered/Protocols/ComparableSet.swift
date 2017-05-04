/*
 ComparableSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
/// Returns `true` if `lhs` is a subset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible subset to test.
///     - rhs: The other set.
infix operator ⊆: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
/// Returns `true` if `lhs` is a subset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible subset to test.
///     - rhs: The other set.
infix operator ⊈: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
/// Returns `true` if `lhs` is a superset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible superset to test.
///     - rhs: The other set.
infix operator ⊇: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
/// Returns `true` if `lhs` is a superset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible superset to test.
///     - rhs: The other set.
infix operator ⊉: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
/// Returns `true` if `lhs` is a strict subset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible subset to test.
///     - rhs: The other set.
infix operator ⊊: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
/// Returns `true` if `lhs` is a strict superset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible superset to test.
///     - rhs: The other set.
infix operator ⊋: ComparisonPrecedence

/// A set that can be compared against other sets of the same type.
///
/// Conformance Requirements:
///     - `SetDefinition`
///     - `static func ⊆ (lhs: Self, rhs: Self) -> Bool`
///     - `func overlaps(_ other: Self) -> Bool`
public protocol ComparableSet : Equatable, SetDefinition {

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `lhs` is a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊆ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊈_]
    /// Returns `true` if `lhs` is not a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊈ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `lhs` is a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊇ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊉_]
    /// Returns `true` if `lhs` is not a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊉ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `lhs` is a strict subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊊ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `lhs` is a strict superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊋ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    func overlaps(_ other: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    func isDisjoint(with other: Self) -> Bool
}

extension ComparableSet {

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊈_]
    /// Returns `true` if `lhs` is not a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    public static func ⊈ (lhs: Self, rhs: Self) -> Bool {
        return ¬(lhs ⊆ rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `lhs` is a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    public static func ⊇ (lhs: Self, rhs: Self) -> Bool {
        return rhs ⊆ lhs
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊉_]
    /// Returns `true` if `lhs` is not a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    public static func ⊉ (lhs: Self, rhs: Self) -> Bool {
        return ¬(lhs ⊇ rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `lhs` is a strict subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    public static func ⊊ (lhs: Self, rhs: Self) -> Bool {
        return lhs ⊆ rhs ∧ lhs ⊉ rhs
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `lhs` is a strict superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    public static func ⊋ (lhs: Self, rhs: Self) -> Bool {
        return lhs ⊇ rhs ∧ lhs ⊈ rhs
    }

    internal func isDisjointAsComparableSet(with other: Self) -> Bool {
        return ¬overlaps(other)
    }
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    public func isDisjoint(with other: Self) -> Bool {
        return isDisjointAsComparableSet(with: other)
    }
}

extension ComparableSet where Self : RangeFamily {
    // MARK: - where Self : RangeFamily

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `lhs` is a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    public static func ⊆ (lhs: Self, rhs: Self) -> Bool {
        return lhs.lowerBound ≥ rhs.lowerBound ∧ lhs.upperBound ≤ rhs.upperBound
    }
}

extension ComparableSet where Self : SetAlgebra {
    // MARK: - where Self : SetAlgebra

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    public func isDisjoint(with other: Self) -> Bool {
        return isDisjointAsComparableSet(with: other)
        // Disambiguate ComparableSet.isDisjoint(with:) vs SetAlgebra.isDisjoint(with:)
    }
}
