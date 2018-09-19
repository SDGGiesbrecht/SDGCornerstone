/*
 CharacterSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension CharacterSet : ComparableSet, MutableSet, SetInRepresentableUniverse, SetDefinition {

    // MARK: - ComparableSet

    // #documentation(SDGCornerstone.ComparableSet.⊆)
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊆ (precedingValue: CharacterSet, followingValue: CharacterSet) -> Bool {
        return precedingValue.isSubset(of: followingValue)
    }

    // #documentation(SDGCornerstone.ComparableSet.⊇)
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊇ (precedingValue: CharacterSet, followingValue: CharacterSet) -> Bool {
        return precedingValue.isSuperset(of: followingValue)
    }

    // #documentation(SDGCornerstone.ComparableSet.⊊)
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊊ (precedingValue: CharacterSet, followingValue: CharacterSet) -> Bool {
        return precedingValue.isStrictSubset(of: followingValue)
    }

    // #documentation(SDGCornerstone.ComparableSet.⊋)
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @inlinable public static func ⊋ (precedingValue: CharacterSet, followingValue: CharacterSet) -> Bool {
        return precedingValue.isStrictSuperset(of: followingValue)
    }

    // #documentation(SDGCornerstone.ComparableSet.overlaps(_:))
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    @inlinable public func overlaps(_ other: CharacterSet) -> Bool {
        return ¬isDisjointAsSetAlgebra(with: other)
    }

    // MARK: - MutableSet

    // #documentation(SDGCornerstone.SetDefinition.∩)
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∩ (precedingValue: CharacterSet, followingValue: CharacterSet) -> CharacterSet {
        return precedingValue.intersection(followingValue)
    }

    // #documentation(SDGCornerstone.MutableSet.∩=)
    /// Sets `precedingValue` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∩= (precedingValue: inout CharacterSet, followingValue: CharacterSet) {
        precedingValue.formIntersection(followingValue)
    }

    // #documentation(SDGCornerstone.SetDefinition.∪)
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∪ (precedingValue: CharacterSet, followingValue: CharacterSet) -> CharacterSet {
        return precedingValue.union(followingValue)
    }

    // #documentation(SDGCornerstone.MutableSet.∪=)
    /// Sets `precedingValue` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∪= (precedingValue: inout CharacterSet, followingValue: CharacterSet) {
        return precedingValue.formUnion(followingValue)
    }

    // #documentation(SDGCornerstone.SetDefinition.∖)
    /// Returns the relative complement of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @inlinable public static func ∖ (precedingValue: CharacterSet, followingValue: CharacterSet) -> CharacterSet {
        return precedingValue.subtracting(followingValue)
    }

    // #documentation(SDGCornerstone.MutableSet.∖=)
    /// Subtracts `followingValue` from `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @inlinable public static func ∖= (precedingValue: inout CharacterSet, followingValue: CharacterSet) {
        precedingValue.subtract(followingValue)
    }

    // #documentation(SDGCornerstone.SetDefinition.∆)
    /// Returns the symmetric difference of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∆ (precedingValue: CharacterSet, followingValue: CharacterSet) -> CharacterSet {
        return precedingValue.symmetricDifference(followingValue)
    }

    // #documentation(SDGCornerstone.MutableSet.∆=)
    /// Sets `precedingValue` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @inlinable public static func ∆= (precedingValue: inout CharacterSet, followingValue: CharacterSet) {
        return precedingValue.formSymmetricDifference(followingValue)
    }

    // MARK: - SetDefinition

    // #documentation(SDGCornerstone.SetDefinition.∋)
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @inlinable public static func ∋ (precedingValue: CharacterSet, followingValue: Element) -> Bool {
        return precedingValue.contains(followingValue)
    }

    // MARK: - SetInRepresentableUniverse

    // #documentation(SDGCornerstone.RepresentableUniverse.universe)
    /// An instance containing all possible elements.
    public static let universe: CharacterSet = CharacterSet().inverted

    // #documentation(SDGCornerstone.RepresentableUniverse.′)
    /// Returns the absolute complement of the set.
    ///
    /// - Parameters:
    ///     - operand: The set.
    @inlinable public static postfix func ′(operand: CharacterSet) -> CharacterSet {
        return operand.inverted
    }

    // #documentation(SDGCornerstone.RepresentableUniverse.′=)
    /// Sets the operand to its absolute complement.
    ///
    /// - Parameters:
    ///     - operand: The set.
    @inlinable public static postfix func ′=(operand: inout CharacterSet) {
        operand.invert()
    }
}

extension SetAlgebra {

    @inlinable @_versioned internal func isDisjointAsSetAlgebra(with other: Self) -> Bool {
        return isDisjoint(with: other)
    }
}
