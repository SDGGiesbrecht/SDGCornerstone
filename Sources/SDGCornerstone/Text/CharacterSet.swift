/*
 CharacterSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension CharacterSet : ComparableSet, MutableSet, SetInRepresentableUniverse, SetDefinition {

    // MARK: - ComparableSet

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `lhs` is a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    public static func ⊆ (lhs: CharacterSet, rhs: CharacterSet) -> Bool {
        return lhs.isSubset(of: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `lhs` is a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    public static func ⊇ (lhs: CharacterSet, rhs: CharacterSet) -> Bool {
        return lhs.isSuperset(of: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `lhs` is a strict subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    public static func ⊊ (lhs: CharacterSet, rhs: CharacterSet) -> Bool {
        return lhs.isStrictSubset(of: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `lhs` is a strict superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    public static func ⊋ (lhs: CharacterSet, rhs: CharacterSet) -> Bool {
        return lhs.isStrictSuperset(of: rhs)
    }

    // MARK: - MutableSet

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∩ (lhs: CharacterSet, rhs: CharacterSet) -> CharacterSet {
        return lhs.union(rhs)
    }

    // [_Define Documentation: SDGCornerstone.MutableSet.∩=_]
    /// Sets `lhs` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∩= (lhs: inout CharacterSet, rhs: CharacterSet) {
        lhs.formUnion(rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∪ (lhs: CharacterSet, rhs: CharacterSet) -> CharacterSet {
        return lhs.intersection(rhs)
    }

    // [_Define Documentation: SDGCornerstone.MutableSet.∪=_]
    /// Sets `lhs` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∪= (lhs: inout CharacterSet, rhs: CharacterSet) {
        return lhs.formIntersection(rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∖ (lhs: CharacterSet, rhs: CharacterSet) -> CharacterSet {
        return lhs.subtracting(rhs)
    }

    // [_Define Documentation: SDGCornerstone.MutableSet.∖=_]
    /// Subtracts `rhs` from `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∖= (lhs: inout CharacterSet, rhs: CharacterSet) {
        lhs.subtract(rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∆ (lhs: CharacterSet, rhs: CharacterSet) -> CharacterSet {
        return lhs.symmetricDifference(rhs)
    }

    // [_Define Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∆= (lhs: inout CharacterSet, rhs: CharacterSet) {
        return lhs.formSymmetricDifference(rhs)
    }

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `lhs` contains `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    public static func ∋ (lhs: CharacterSet, rhs: Element) -> Bool {
        return lhs.contains(rhs)
    }

    // MARK: - SetInRepresentableUniverse

    public static let universe = CharacterSet().inverted

    // [_Inherit Documentation: SDGCornerstone.RepresentableUniverse.′_]
    /// Returns the absolute complement of the set.
    ///
    /// - Parameters:
    ///     - operand: The set.
    public static postfix func ′(operand: CharacterSet) -> CharacterSet {
        return operand.inverted
    }

    // [_Inherit Documentation: SDGCornerstone.RepresentableUniverse.′=_]
    /// Sets the operand to its absolute complement.
    ///
    /// - Parameters:
    ///     - operand: The set.
    public static postfix func ′=(operand: inout CharacterSet) {
        operand.invert()
    }
}
