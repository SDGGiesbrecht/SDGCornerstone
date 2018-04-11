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

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊆ (precedingValue: CharacterSet, followingValue: CharacterSet) -> Bool {
        return precedingValue.isSubset(of: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊇ (precedingValue: CharacterSet, followingValue: CharacterSet) -> Bool {
        return precedingValue.isSuperset(of: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊊ (precedingValue: CharacterSet, followingValue: CharacterSet) -> Bool {
        return precedingValue.isStrictSubset(of: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊋ (precedingValue: CharacterSet, followingValue: CharacterSet) -> Bool {
        return precedingValue.isStrictSuperset(of: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    @_inlineable public func overlaps(_ other: CharacterSet) -> Bool {
        return ¬isDisjointAsSetAlgebra(with: other)
    }

    // MARK: - MutableSet

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    /*@_inlineable [_Workaround: @_inlineable here triggers linker errors. (Swift 4.0.3)_] */ public static func ∩ (precedingValue: CharacterSet, followingValue: CharacterSet) -> CharacterSet {
        return precedingValue.intersection(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∩=_]
    /// Sets `precedingValue` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_inlineable public static func ∩= (precedingValue: inout CharacterSet, followingValue: CharacterSet) {
        precedingValue.formIntersection(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    /*@_inlineable [_Workaround: @_inlineable here triggers linker errors. (Swift 4.0.3)_] */ public static func ∪ (precedingValue: CharacterSet, followingValue: CharacterSet) -> CharacterSet {
        return precedingValue.union(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∪=_]
    /// Sets `precedingValue` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_inlineable public static func ∪= (precedingValue: inout CharacterSet, followingValue: CharacterSet) {
        return precedingValue.formUnion(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @_inlineable public static func ∖ (precedingValue: CharacterSet, followingValue: CharacterSet) -> CharacterSet {
        return precedingValue.subtracting(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∖=_]
    /// Subtracts `followingValue` from `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @_inlineable public static func ∖= (precedingValue: inout CharacterSet, followingValue: CharacterSet) {
        precedingValue.subtract(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the symmetric difference of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_inlineable public static func ∆ (precedingValue: CharacterSet, followingValue: CharacterSet) -> CharacterSet {
        return precedingValue.symmetricDifference(followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `precedingValue` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_inlineable public static func ∆= (precedingValue: inout CharacterSet, followingValue: CharacterSet) {
        return precedingValue.formSymmetricDifference(followingValue)
    }

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @_inlineable public static func ∋ (precedingValue: CharacterSet, followingValue: Element) -> Bool {
        return precedingValue.contains(followingValue)
    }

    // MARK: - SetInRepresentableUniverse

    public static let universe = CharacterSet().inverted

    // [_Inherit Documentation: SDGCornerstone.RepresentableUniverse.′_]
    /// Returns the absolute complement of the set.
    ///
    /// - Parameters:
    ///     - operand: The set.
    @_inlineable public static postfix func ′(operand: CharacterSet) -> CharacterSet {
        return operand.inverted
    }

    // [_Inherit Documentation: SDGCornerstone.RepresentableUniverse.′=_]
    /// Sets the operand to its absolute complement.
    ///
    /// - Parameters:
    ///     - operand: The set.
    @_inlineable public static postfix func ′=(operand: inout CharacterSet) {
        operand.invert()
    }
}

extension SetAlgebra {

    @_inlineable @_versioned internal func isDisjointAsSetAlgebra(with other: Self) -> Bool {
        return isDisjoint(with: other)
    }
}
