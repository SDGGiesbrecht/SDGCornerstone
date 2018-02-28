/*
 Set.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Set : ComparableSet, FiniteSet, MutableSet, SetDefinition {

    // MARK: - ComparableSet

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_transparent public static func ⊆ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isSubset(of: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_transparent public static func ⊇ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isSuperset(of: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_transparent public static func ⊊ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isStrictSubset(of: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_transparent public static func ⊋ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isStrictSuperset(of: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    @_inlineable public func overlaps(_ other: Set) -> Bool {
        return ¬isDisjoint(with: other)
    }

    // MARK: - MutableSet

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_transparent public static func ∩ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.intersection(followingValue)
    }

    // [_Define Documentation: SDGCornerstone.MutableSet.∩=_]
    /// Sets `precedingValue` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_transparent public static func ∩= (precedingValue: inout Set, followingValue: Set) {
        precedingValue.formIntersectionAsSetAlgebra(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_transparent public static func ∪ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.unionAsSetAlgebra(followingValue)
    }

    // [_Define Documentation: SDGCornerstone.MutableSet.∪=_]
    /// Sets `precedingValue` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_transparent public static func ∪= (precedingValue: inout Set, followingValue: Set) {
        return precedingValue.formUnionAsSetAlgebra(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @_transparent public static func ∖ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.subtracting(followingValue)
    }

    // [_Define Documentation: SDGCornerstone.MutableSet.∖=_]
    /// Subtracts `followingValue` from `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @_transparent public static func ∖= (precedingValue: inout Set, followingValue: Set) {
        precedingValue.subtract(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the symmetric difference of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_transparent public static func ∆ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.symmetricDifferenceAsSetAlgebra(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `precedingValue` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_transparent public static func ∆= (precedingValue: inout Set, followingValue: Set) {
        return precedingValue.formSymmetricDifference(followingValue)
    }

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @_transparent public static func ∋ (precedingValue: Set, followingValue: Element) -> Bool {
        return precedingValue.contains(followingValue)
    }
}

extension SetAlgebra {

    @_transparent @_versioned internal func unionAsSetAlgebra(_ other: Self) -> Self {
        return union(other)
    }

    @_transparent @_versioned internal mutating func formUnionAsSetAlgebra(_ other: Self) {
        formUnion(other)
    }

    @_transparent @_versioned internal mutating func formIntersectionAsSetAlgebra(_ other: Self) {
        formIntersection(other)
    }

    @_transparent @_versioned internal func symmetricDifferenceAsSetAlgebra(_ other: Self) -> Self {
        return symmetricDifference(other)
    }
}
