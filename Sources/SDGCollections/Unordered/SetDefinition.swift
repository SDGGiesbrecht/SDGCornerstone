/*
 SetDefinition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that defines a set.
///
/// Conformance Requirements:
///
/// - `static func ∋ (precedingValue: Element, followingValue: Self) -> Bool`
public protocol SetDefinition {

    // [_Define Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    associatedtype Element

    // MARK: - Membership

    // [_Define Documentation: SDGCornerstone.SetDefinition.∈_]
    /// Returns `true` if `precedingValue` is an element of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The element to test.
    ///     - followingValue: The set.
    static func ∈ (precedingValue: Element, followingValue: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∉_]
    /// Returns `true` if `precedingValue` is not an element of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The element to test.
    ///     - followingValue: The set.
    static func ∉ (precedingValue: Element, followingValue: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    static func ∋ (precedingValue: Self, followingValue: Element) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∌_]
    /// Returns `true` if `precedingValue` does not contain `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    static func ∌ (precedingValue: Self, followingValue: Element) -> Bool
}

extension SetDefinition {

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∈_]
    /// Returns `true` if `precedingValue` is an element of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The element to test.
    ///     - followingValue: The set.
    @_inlineable public static func ∈ (precedingValue: Element, followingValue: Self) -> Bool {
        return followingValue ∋ precedingValue
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∉_]
    /// Returns `true` if `precedingValue` is not an element of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The element to test.
    ///     - followingValue: The set.
    @_inlineable public static func ∉ (precedingValue: Element, followingValue: Self) -> Bool {
        return ¬(precedingValue ∈ followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∌_]
    /// Returns `true` if `precedingValue` does not contain `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @_inlineable public static func ∌ (precedingValue: Self, followingValue: Element) -> Bool {
        return ¬(precedingValue ∋ followingValue)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.∩_]
    /// Returns the intersection of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_inlineable public static func ∩ <S : SetDefinition>(precedingValue: Self, followingValue: S) -> Intersection<Self, S> {
        return Intersection(precedingValue, followingValue)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.∪_]
    /// Returns the union of the two sets.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_inlineable public static func ∪ <S : SetDefinition>(precedingValue: Self, followingValue: S) -> Union<Self, S> {
        return Union(precedingValue, followingValue)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.∖_]
    /// Returns the relative complement of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set to subtract from.
    ///     - followingValue: The set to subtract.
    @_inlineable public static func ∖ <S : SetDefinition>(precedingValue: Self, followingValue: S) -> RelativeComplement<Self, S> {
        return RelativeComplement(of: followingValue, in: precedingValue)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.′_]
    /// Returns the absolute complement of the set.
    ///
    /// - Parameters:
    ///     - operand: The set.
    @_inlineable public static postfix func ′(operand: Self) -> AbsoluteComplement<Self> {
        return AbsoluteComplement(operand)
    }

    // [_Define Documentation: SDGCornerstone.SetDefinition.∆_]
    /// Returns the symmetric difference of `followingValue` in `precedingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: A set.
    ///     - followingValue: Another set.
    @_inlineable public static func ∆ <S : SetDefinition>(precedingValue: Self, followingValue: S) -> SymmetricDifference<Self, S> {
        return SymmetricDifference(precedingValue, followingValue)
    }
}

extension SetDefinition where Self : SetAlgebra {
    // MARK: - where Self : SetAlgebra

    // [_Define Documentation: SDGCornerstone.SetAlgebra.contains(_:)_]
    /// Returns `true` if `self` contains `member`.
    ///
    /// - Parameters:
    ///     - member: The element to test.
    @_inlineable public func contains(_ member: Self.Element) -> Bool {
        return self ∋ member
    }
}
