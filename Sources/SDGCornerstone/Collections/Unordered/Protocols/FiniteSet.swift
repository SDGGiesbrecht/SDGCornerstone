/*
 FiniteSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.FiniteSet.⊆_]
/// Returns `true` if `lhs` is a subset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible subset to test.
///     - rhs: The other set.
infix operator ⊆: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.FiniteSet.⊆_]
/// Returns `true` if `lhs` is a subset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible subset to test.
///     - rhs: The other set.
infix operator ⊈: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.FiniteSet.⊇_]
/// Returns `true` if `lhs` is a superset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible superset to test.
///     - rhs: The other set.
infix operator ⊇: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.FiniteSet.⊇_]
/// Returns `true` if `lhs` is a superset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible superset to test.
///     - rhs: The other set.
infix operator ⊉: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.FiniteSet.⊊_]
/// Returns `true` if `lhs` is a strict subset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible subset to test.
///     - rhs: The other set.
infix operator ⊊: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.FiniteSet.⊋_]
/// Returns `true` if `lhs` is a strict superset of `rhs`.
///
/// - Parameters:
///     - lhs: The possible superset to test.
///     - rhs: The other set.
infix operator ⊋: ComparisonPrecedence

/// A set small enough to reasonably iterate over.
///
/// Conformance Requirements:
///     - `SetDefinition`
///     - `Collection`
///     - `Iterator.Element == Element`
public protocol FiniteSet : Collection, Equatable, SetDefinition {

    /// :nodoc:
    static func toElement(_ iteratorElement: Self.Iterator.Element) -> Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊆_]
    /// Returns `true` if `lhs` is a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊆ <S : SetDefinition>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊆_]
    /// Returns `true` if `lhs` is a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊆ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊈_]
    /// Returns `true` if `lhs` is not a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊈ <S : SetDefinition>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊈_]
    /// Returns `true` if `lhs` is not a subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊈ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊇_]
    /// Returns `true` if `lhs` is a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊇ <S : SetDefinition>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊇_]
    /// Returns `true` if `lhs` is a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊇ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊉_]
    /// Returns `true` if `lhs` is not a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊉ <S : SetDefinition>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊉_]
    /// Returns `true` if `lhs` is not a superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊉ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊊_]
    /// Returns `true` if `lhs` is a strict subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊊ <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊊_]
    /// Returns `true` if `lhs` is a strict subset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible subset to test.
    ///     - rhs: The other set.
    static func ⊊ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊋_]
    /// Returns `true` if `lhs` is a strict superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊋ <S : FiniteSet>(lhs: S, rhs: Self) -> Bool where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊋_]
    /// Returns `true` if `lhs` is a strict superset of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The possible superset to test.
    ///     - rhs: The other set.
    static func ⊋ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.FiniteSet.==_]
    /// Returns `true` if `lhs` is equal to `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func == <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.≠_]
    /// Returns `true` if `lhs` is not equal to `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ≠ <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.≠_]
    /// Returns `true` if `lhs` is not equal to `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    static func ≠ (lhs: Self, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.FiniteSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    func isDisjoint<S : FiniteSet>(with other: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    func isDisjoint(with other: Self) -> Bool
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
    /// Returns `true` if `lhs` is equal to `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func == <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element {
        return lhs ⊇ rhs ∧ lhs ⊆ rhs
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.≠_]
    /// Returns `true` if `lhs` is not equal to `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: A set.
    ///     - rhs: Another set.
    public static func ≠ <S : FiniteSet>(lhs: Self, rhs: S) -> Bool where S.Element == Self.Element {
        return ¬(lhs == rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    public func isDisjoint<S : FiniteSet>(with other: S) -> Bool where S.Element == Self.Element {
        for element in self.elements where element ∈ other {
            return false
        }
        for element in other.elements where element ∈ self {
            return false
        }
        return true
    }
}
