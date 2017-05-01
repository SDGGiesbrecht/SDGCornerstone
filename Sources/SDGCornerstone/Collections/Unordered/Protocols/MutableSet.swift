/*
 MutableSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A mutable set.
///
/// Conformance Requirements:
///   - `SetDefinition`
///   - `init()`
///   - `@discardableResult mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element)`
///   - `@discardableResult mutating func remove(_ member: Element) -> Element?`
///   - Either `FiniteSet` or all of the following:
///     - `static func ∩= (lhs: inout Self, rhs: Self)`
///     - `static func ∪= (lhs: inout Self, rhs: Self)`
///     - `static func ∖= (lhs: inout Self, rhs: Self)`
public protocol MutableSet : SetDefinition {

    // [_Define SDGCornerstone.MutableSet.init()_]
    /// Creates an empty set.
    init()

    // [_Define SDGCornerstone.MutableSet.insert(_:)_]
    /// Inserts `member` into `self`.
    ///
    /// - Parameters:
    ///     - newMember: The element to insert.
    @discardableResult mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element)

    // [_Define SDGCornerstone.MutableSet.remove(_:)_]
    /// Removes `member` from `self`.
    ///
    /// - Parameters:
    ///     - member: The element to remove.
    @discardableResult mutating func remove(_ member: Element) -> Element?

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ∩ (lhs: Self, rhs: Self) -> Self

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
    static func ∪ (lhs: Self, rhs: Self) -> Self

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
    static func ∖ (lhs: Self, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.MutableSet.∖=_]
    /// Subtracts `rhs` from `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    static func ∖= (lhs: inout Self, rhs: Self)

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    static func ∆ (lhs: Self, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
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
        for element in rhs.map({ return S.toElement($0) }) where element ∈ lhs {
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
        for element in rhs.map({ S.toElement($0) }) {
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
        for element in rhs.map({ S.toElement($0) }) {
            lhs.remove(element)
        }
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∆ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ∆= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
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
    /// Returns the relative complement of `rhs` in `lhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∆ <S : FiniteSet>(lhs: Self, rhs: S) -> Self where S.Element == Self.Element {
        var result = lhs
        result ∆= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.MutableSet.∆=_]
    /// Sets `lhs` to the symmetric difference of the two sets.
    ///
    /// - Parameters:
    ///     - lhs: The set to subtract from.
    ///     - rhs: The set to subtract.
    public static func ∆= <S : FiniteSet>(lhs: inout Self, rhs: S) where S.Element == Self.Element {
        var result = lhs
        result ∪= rhs
        result ∖= lhs ∩ rhs
        lhs = result
    }
}
