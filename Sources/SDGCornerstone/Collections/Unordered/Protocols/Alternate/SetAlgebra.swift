/*
 SetAlgebra.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SetAlgebra {

    internal func unionAsSetAlgebra(_ other: Self) -> Self {
        return union(other)
    }

    internal mutating func formUnionAsSetAlgebra(_ other: Self) {
        formUnion(other)
    }

    internal mutating func formIntersectionAsSetAlgebra(_ other: Self) {
        formIntersection(other)
    }

    internal func symmetricDifferenceAsSetAlgebra(_ other: Self) -> Self {
        return symmetricDifference(other)
    }

    internal func isDisjointAsSetAlgebra(with other: Self) -> Bool {
        return isDisjoint(with: other)
    }
}

extension SetAlgebra where Self : MutableSet {
    // MARK: - where Self : MutableSet

    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - other: Another set.
    public func intersection(_ other: Self) -> Self {
        return self ∩ other
    }

    /// Sets `lhs` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - other: Another set.
    public mutating func formIntersection(_ other: Self) {
        self ∩= other
    }

    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - other: Another set.
    public func union(_ other: Self) -> Self {
        return self ∪ other
    }

    /// Sets `lhs` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - other: Another set.
    public mutating func formUnion(_ other: Self) {
        self ∪= other
    }

    /// Returns the symmetric difference of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - other: Another set.
    public func symmetricDifference(_ other: Self) -> Self {
        return self ∆ other
    }

    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - other: The set to subtract.
    public mutating func formSymmetricDifference(_ other: Self) {
        self ∆= other
    }
}

extension SetAlgebra where Self : SetDefinition {
    // MARK: - where Self : SetDefinition

    fileprivate func containsAsSetAlgebra(_ member: Self.Element) -> Bool { // [_Exempt from Test Coverage_] Apparently unreachable.
        return self ∋ member
    }
    // [_Define Documentation: SDGCornerstone.SetAlgebra.contains(_:)_]
    /// Returns `true` if `self` contains `member`.
    ///
    /// - Parameters:
    ///     - member: The element to test.
    public func contains(_ member: Self.Element) -> Bool { // [_Exempt from Test Coverage_] Apparently unreachable.
        return containsAsSetAlgebra(member)
    }
}
