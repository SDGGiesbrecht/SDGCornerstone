/*
 Set.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Set : ComparableSet, FiniteSet, MutableSet, SetDefinition {

    // MARK: - ComparableSet

    @inlinable public static func ⊆ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isSubset(of: followingValue)
    }

    @inlinable public static func ⊇ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isSuperset(of: followingValue)
    }

    @inlinable public static func ⊊ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isStrictSubset(of: followingValue)
    }

    @inlinable public static func ⊋ (precedingValue: Set, followingValue: Set) -> Bool {
        return precedingValue.isStrictSuperset(of: followingValue)
    }

    @inlinable public func overlaps(_ other: Set) -> Bool {
        return ¬isDisjoint(with: other)
    }

    // MARK: - MutableSet

    @inlinable public static func ∩ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.intersection(followingValue)
    }

    @inlinable public static func ∩= (precedingValue: inout Set, followingValue: Set) {
        precedingValue.formIntersectionAsSetAlgebra(followingValue)
    }

    @inlinable public static func ∪ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.unionAsSetAlgebra(followingValue)
    }

    @inlinable public static func ∪= (precedingValue: inout Set, followingValue: Set) {
        return precedingValue.formUnionAsSetAlgebra(followingValue)
    }

    @inlinable public static func ∖ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.subtracting(followingValue)
    }

    @inlinable public static func ∖= (precedingValue: inout Set, followingValue: Set) {
        precedingValue.subtract(followingValue)
    }

    @inlinable public static func ∆ (precedingValue: Set, followingValue: Set) -> Set {
        return precedingValue.symmetricDifferenceAsSetAlgebra(followingValue)
    }

    @inlinable public static func ∆= (precedingValue: inout Set, followingValue: Set) {
        return precedingValue.formSymmetricDifference(followingValue)
    }

    // MARK: - SetDefinition

    @inlinable public static func ∋ (precedingValue: Set, followingValue: Element) -> Bool {
        return precedingValue.contains(followingValue)
    }
}

extension SetAlgebra {

    @inlinable internal func unionAsSetAlgebra(_ other: Self) -> Self {
        return union(other)
    }

    @inlinable internal mutating func formUnionAsSetAlgebra(_ other: Self) {
        formUnion(other)
    }

    @inlinable internal mutating func formIntersectionAsSetAlgebra(_ other: Self) {
        formIntersection(other)
    }

    @inlinable internal func symmetricDifferenceAsSetAlgebra(_ other: Self) -> Self {
        return symmetricDifference(other)
    }
}
