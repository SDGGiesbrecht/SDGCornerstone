/*
 FiniteSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A set small enough to reasonably iterate over.
///
/// Conformance Requirements:
///     - `SetDefinition`
///     - `Collection`
///     - `Iterator.Element == Element`
public protocol FiniteSet : Collection, ComparableSet, SetDefinition {

    /// :nodoc:
    static func toElement(_ iteratorElement: Self.Iterator.Element) -> Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊆_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `lhs` is a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊆ <S : SetDefinition>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊈_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊈_]
    /// Returns `true` if `lhs` is not a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊈ <S : SetDefinition>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊇_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `lhs` is a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊇ <S : SetDefinition>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊉_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊉_]
    /// Returns `true` if `lhs` is not a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊉ <S : SetDefinition>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊊_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `lhs` is a strict subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊊ <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊋_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `lhs` is a strict superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊋ <S : FiniteSet>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.==_]
    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    static func == <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.≠_]
    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: !=
    static func ≠ <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.overlaps(_:)_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    func overlaps<S : SetDefinition>(_ other: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.isDisjoint(with:)_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    func isDisjoint<S : FiniteSet>(with other: S) -> Bool where S.Element == Self.Element
}

extension FiniteSet where Iterator.Element == Element {
    // MARK: - where Iterator.Element == Element

    /// :nodoc:
    public static func toElement(_ element: Self.Iterator.Element) -> Self.Element {
        return element
    }
}

extension FiniteSet {

    /// The elements as a collection of instances of `Element` instead of `Iterator.Element`.
    public var elements: LazyMapCollection<Self, Self.Element> {
        return self.lazy.map({ Self.toElement($0) })
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊆_]
    /// Returns `true` if `lhs` is a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    public static func ⊆ <S : SetDefinition>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element {
        for element in lhs.elements where element ∉ rhs {
            return false
        }
        return true
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊈_]
    /// Returns `true` if `lhs` is not a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    public static func ⊈ <S : SetDefinition>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element {
        return ¬(lhs ⊆ rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊇_]
    /// Returns `true` if `lhs` is a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    public static func ⊇ <S : SetDefinition>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element {
        return rhs ⊆ lhs
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊉_]
    /// Returns `true` if `lhs` is not a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    public static func ⊉ <S : SetDefinition>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element {
        return ¬(lhs ⊇ rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊊_]
    /// Returns `true` if `lhs` is a strict subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    public static func ⊊ <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element {
        return lhs ⊆ rhs ∧ lhs ⊉ rhs
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊋_]
    /// Returns `true` if `lhs` is a strict superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    public static func ⊋ <S : FiniteSet>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element {
        return lhs ⊇ rhs ∧ lhs ⊈ rhs
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element {
        return lhs ⊇ rhs ∧ lhs ⊆ rhs
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: !=
    public static func ≠ <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element {
        return ¬(lhs == rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    public func overlaps<S : SetDefinition>(_ other: S) -> Bool where S.Element == Self.Element {
        for element in self.elements where element ∈ other {
            return true
        }
        return false
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    public func isDisjoint<S : SetDefinition>(with other: S) -> Bool where S.Element == Self.Element {
        return ¬overlaps(other)
    }
}
