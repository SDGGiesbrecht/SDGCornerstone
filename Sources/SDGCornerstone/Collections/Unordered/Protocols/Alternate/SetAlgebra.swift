/*
 SetAlgebra.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SetAlgebra where Self : MutableSet {
    // MARK: - where Self : MutableSet

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public func intersection(_ other: Self) -> Self {
        return self ∩ other
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∩=_]
    /// Sets `lhs` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public mutating func formIntersection(_ other: Self) {
        self ∩= other
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public func union(_ other: Self) -> Self {
        return self ∪ other
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∪=_]
    /// Sets `lhs` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public mutating func formUnion(_ other: Self) {
        self ∪= other
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the symmetric difference of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public func symmetricDifference(_ other: Self) -> Self {
        return self ∆ other
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public mutating func formSymmetricDifference(_ other: Self) {
        self ∆= other
    }
}
