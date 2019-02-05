/*
 ComparableSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A set that can be compared against other sets of the same type.
///
/// Conformance Requirements:
///
/// - `SetDefinition`
/// - `static func ⊆ (precedingValue: Self, followingValue: Self) -> Bool`
/// - `func overlaps(_ other: Self) -> Bool`
public protocol ComparableSet : Equatable, SetDefinition {

    // @documentation(SDGCornerstone.ComparableSet.⊆)
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊆ (precedingValue: Self, followingValue: Self) -> Bool

    // @documentation(SDGCornerstone.ComparableSet.⊈)
    /// Returns `true` if `precedingValue` is not a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊈ (precedingValue: Self, followingValue: Self) -> Bool

    // @documentation(SDGCornerstone.ComparableSet.⊇)
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊇ (precedingValue: Self, followingValue: Self) -> Bool

    // @documentation(SDGCornerstone.ComparableSet.⊉)
    /// Returns `true` if `precedingValue` is not a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊉ (precedingValue: Self, followingValue: Self) -> Bool

    // @documentation(SDGCornerstone.ComparableSet.⊊)
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊊ (precedingValue: Self, followingValue: Self) -> Bool

    // @documentation(SDGCornerstone.ComparableSet.⊋)
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊋ (precedingValue: Self, followingValue: Self) -> Bool

    // @documentation(SDGCornerstone.ComparableSet.overlaps(_:))
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    func overlaps(_ other: Self) -> Bool

    // @documentation(SDGCornerstone.ComparableSet.isDisjoint(with:))
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    func isDisjoint(with other: Self) -> Bool
}

extension ComparableSet {

    @inlinable public static func ⊈ (precedingValue: Self, followingValue: Self) -> Bool {
        return ¬(precedingValue ⊆ followingValue)
    }

    @inlinable public static func ⊇ (precedingValue: Self, followingValue: Self) -> Bool {
        return followingValue ⊆ precedingValue
    }

    @inlinable public static func ⊉ (precedingValue: Self, followingValue: Self) -> Bool {
        return ¬(precedingValue ⊇ followingValue)
    }

    @inlinable public static func ⊊ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue ⊆ followingValue ∧ precedingValue ⊉ followingValue
    }

    @inlinable public static func ⊋ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue ⊇ followingValue ∧ precedingValue ⊈ followingValue
    }

    @inlinable internal func isDisjointAsComparableSet(with other: Self) -> Bool {
        return ¬overlaps(other)
    }
    @inlinable public func isDisjoint(with other: Self) -> Bool {
        return isDisjointAsComparableSet(with: other)
    }

    // MARK: - Equatable

    @inlinable public static func == (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue ⊇ followingValue ∧ precedingValue ⊆ followingValue
    }
}

extension ComparableSet where Self : SetAlgebra {

    @inlinable public func isDisjoint(with other: Self) -> Bool {
        return isDisjointAsComparableSet(with: other)
        // Disambiguate ComparableSet.isDisjoint(with:) vs SetAlgebra.isDisjoint(with:)
    }
}
