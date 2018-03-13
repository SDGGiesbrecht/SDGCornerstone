/*
 ComparableSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊆ (precedingValue: Self, followingValue: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊈_]
    /// Returns `true` if `precedingValue` is not a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊈ (precedingValue: Self, followingValue: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊇ (precedingValue: Self, followingValue: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊉_]
    /// Returns `true` if `precedingValue` is not a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊉ (precedingValue: Self, followingValue: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊊ (precedingValue: Self, followingValue: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊋ (precedingValue: Self, followingValue: Self) -> Bool

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
    /// Returns `true` if `precedingValue` is not a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊈ (precedingValue: Self, followingValue: Self) -> Bool {
        return ¬(precedingValue ⊆ followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊇ (precedingValue: Self, followingValue: Self) -> Bool {
        return followingValue ⊆ precedingValue
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊉_]
    /// Returns `true` if `precedingValue` is not a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊉ (precedingValue: Self, followingValue: Self) -> Bool {
        return ¬(precedingValue ⊇ followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊊ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue ⊆ followingValue ∧ precedingValue ⊉ followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊋ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue ⊇ followingValue ∧ precedingValue ⊈ followingValue
    }

    @_inlineable @_versioned internal func isDisjointAsComparableSet(with other: Self) -> Bool {
        return ¬overlaps(other)
    }
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    @_transparent public func isDisjoint(with other: Self) -> Bool {
        return isDisjointAsComparableSet(with: other)
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func == (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue ⊇ followingValue ∧ precedingValue ⊆ followingValue
    }
}

extension ComparableSet where Self : SetAlgebra {
    // MARK: - where Self : SetAlgebra

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    @_transparent public func isDisjoint(with other: Self) -> Bool {
        return isDisjointAsComparableSet(with: other)
        // Disambiguate ComparableSet.isDisjoint(with:) vs SetAlgebra.isDisjoint(with:)
    }
}
