/*
 MutableSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A mutable set.
///
/// Conformance Requirements:
///   - `ComparableSet`
///   - `init()`
///   - `@discardableResult mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element)`
///   - `@discardableResult mutating func remove(_ member: Element) -> Element?`
///   - Either `FiniteSet` or all of the following:
///     - `static func ∩= (lhs: inout Self, rhs: Self)`
///     - `static func ∪= (lhs: inout Self, rhs: Self)`
///     - `static func ∖= (lhs: inout Self, rhs: Self)`
public protocol MutableSet : ComparableSet, SetAlgebra {

    // [_Define SDGCornerstone.MutableSet.init()_]
    /// Creates an empty set.
    init()

    // [_Define SDGCornerstone.MutableSet.insert(_:)_]
    /// Inserts `member` into `self` if it is not already present.
    ///
    /// - Parameters:
    ///     - newMember: The element to insert.
    ///
    /// - Returns: A tuple with two elements:
    ///     - `inserted`: Whether or not the element was inserted.
    ///     - `newMember`: The element in the set after the insertion attempt.
    @discardableResult mutating func insert(_ newMember: Self.Element) -> (inserted: Bool, memberAfterInsert: Self.Element)

    // [_Define SDGCornerstone.MutableSet.remove(_:)_]
    /// Removes `member` from `self` if it is present.
    ///
    /// - Parameters:
    ///     - member: The element to remove.
    ///
    /// - Returns: The element removed, or `nil` if there was nothing to remove.
    @discardableResult mutating func remove(_ member: Self.Element) -> Self.Element?

    /// Inserts the value into the set uncoditionally.
    ///
    /// - Parameters:
    ///     - newMember: The value to insert.
    ///
    /// - Returns: The equal element previously in the set, if there was one.
    @discardableResult mutating func update(with newMember: Element) -> Element?

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∩ <S : FiniteSet>(lhs: Self, rhs: S) -> Self where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∩ (lhs: Self, rhs: Self) -> Self

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∩=_]
    /// Sets `lhs` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∩= <S : FiniteSet>(lhs: inout Self, rhs: S) where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.MutableSet.∩=_]
    /// Sets `lhs` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∩= (lhs: inout Self, rhs: Self)

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∪ <S : FiniteSet>(lhs: Self, rhs: S) -> Self where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∪ (lhs: Self, rhs: Self) -> Self

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∪=_]
    /// Sets `lhs` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∪= <S : FiniteSet>(lhs: inout Self, rhs: S) where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.MutableSet.∪=_]
    /// Sets `lhs` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∪= (lhs: inout Self, rhs: Self)

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    static func ∖ <S : FiniteSet>(lhs: Self, rhs: S) -> Self where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    static func ∖ (lhs: Self, rhs: Self) -> Self

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∖=_]
    /// Subtracts `rhs` from `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    static func ∖= <S : FiniteSet>(lhs: inout Self, rhs: S) where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.MutableSet.∖=_]
    /// Subtracts `rhs` from `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    static func ∖= (lhs: inout Self, rhs: Self)

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the symmetric difference of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∆ (lhs: Self, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∆= (lhs: inout Self, rhs: Self)
}

extension MutableSet {

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∩ <S : FiniteSet>(lhs: Self, rhs: S) -> Self where S.Element == Self.Element {
        var result = lhs
        result ∩= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∩ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ∩= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∩=_]
    /// Sets `lhs` to the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∩= <S : FiniteSet>(lhs: inout Self, rhs: S) where S.Element == Self.Element {
        var result = Self()
        for element in rhs where element ∈ lhs {
            result.insert(element)
        }
        lhs = result
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∪ <S : FiniteSet>(lhs: Self, rhs: S) -> Self where S.Element == Self.Element {
        var result = lhs
        result ∪= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∪ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ∪= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∪=_]
    /// Sets `lhs` to the union of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∪= <S : FiniteSet>(lhs: inout Self, rhs: S) where S.Element == Self.Element {
        for element in rhs {
            lhs.insert(element)
        }
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∖ <S : FiniteSet>(lhs: Self, rhs: S) -> Self where S.Element == Self.Element {
        var result = lhs
        result ∖= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∖ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ∖= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∖=_]
    /// Subtracts `rhs` from `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∖= <S : FiniteSet>(lhs: inout Self, rhs: S) where S.Element == Self.Element {
        for element in rhs {
            lhs.remove(element)
        }
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the symmetric difference of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∆ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ∆= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∆= (lhs: inout Self, rhs: Self) {
        var result = lhs
        result ∪= rhs
        result ∖= lhs ∩ rhs
        lhs = result
    }
}

extension MutableSet where Self : FiniteSet {
    // MARK: - where Self : FiniteSet

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the symmetric difference of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∆ <S : FiniteSet>(lhs: Self, rhs: S) -> Self where S.Element == Self.Element {
        var result = lhs
        result ∆= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ∆= <S : FiniteSet>(lhs: inout Self, rhs: S) where S.Element == Self.Element {
        var result = lhs
        result ∪= rhs
        result ∖= lhs ∩ rhs
        lhs = result
    }
}
