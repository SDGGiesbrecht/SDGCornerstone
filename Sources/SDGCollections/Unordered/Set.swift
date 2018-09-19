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

    // #documentation(SDGCornerstone.ComparableSet.⊆)
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊆ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isSubset(of: followingValue)
    }

    // #documentation(SDGCornerstone.ComparableSet.⊇)
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊇ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isSuperset(of: followingValue)
    }

    // #documentation(SDGCornerstone.ComparableSet.⊊)
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊊ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isStrictSubset(of: followingValue)
    }

    // #documentation(SDGCornerstone.ComparableSet.⊋)
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊋ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isStrictSuperset(of: followingValue)
    }

    // #documentation(SDGCornerstone.ComparableSet.overlaps(_:))
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    @inlinable public func overlaps(_ other: Set) -> Bool {
        return ¬isDisjoint(with: other)
    }

    // MARK: - MutableSet

    // #documentation(SDGCornerstone.SetDefinition.∩)
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∩ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.intersection(followingValue)
    }

    // @documentation(SDGCornerstone.MutableSet.∩=)
    /// Sets `precedingValue` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∩= (precedingValue: inout Set, followingValue: Set) {
        precedingValue.formIntersectionAsSetAlgebra(followingValue)
    }

    // #documentation(SDGCornerstone.SetDefinition.∪)
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∪ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.unionAsSetAlgebra(followingValue)
    }

    // @documentation(SDGCornerstone.MutableSet.∪=)
    /// Sets `precedingValue` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∪= (precedingValue: inout Set, followingValue: Set) {
        return precedingValue.formUnionAsSetAlgebra(followingValue)
    }

    // #documentation(SDGCornerstone.SetDefinition.∖)
    /// Returns the relative complement of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @inlinable public static func ∖ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.subtracting(followingValue)
    }

    // @documentation(SDGCornerstone.MutableSet.∖=)
    /// Subtracts `followingValue` from `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @inlinable public static func ∖= (precedingValue: inout Set, followingValue: Set) {
        precedingValue.subtract(followingValue)
    }

    // #documentation(SDGCornerstone.SetDefinition.∆)
    /// Returns the symmetric difference of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∆ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.symmetricDifferenceAsSetAlgebra(followingValue)
    }

    // #documentation(SDGCornerstone.MutableSet.∆=)
    /// Sets `precedingValue` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∆= (precedingValue: inout Set, followingValue: Set) {
        return precedingValue.formSymmetricDifference(followingValue)
    }

    // MARK: - SetDefinition

    // #documentation(SDGCornerstone.SetDefinition.∋)
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @inlinable public static func ∋ (precedingValue: Set, followingValue: Element) -> Bool {
        return precedingValue.contains(followingValue)
    }
}

extension SetAlgebra {

    @inlinable @usableFromInline internal func unionAsSetAlgebra(_ other: Self) -> Self {
        return union(other)
    }

    @inlinable @usableFromInline internal mutating func formUnionAsSetAlgebra(_ other: Self) {
        formUnion(other)
    }

    @inlinable @usableFromInline internal mutating func formIntersectionAsSetAlgebra(_ other: Self) {
        formIntersection(other)
    }

    @inlinable @usableFromInline internal func symmetricDifferenceAsSetAlgebra(_ other: Self) -> Self {
        return symmetricDifference(other)
    }
}
