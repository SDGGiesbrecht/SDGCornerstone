/*
 SetDefinition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∈_]
/// Returns `true` if `lhs` is an element of `rhs`.
///
/// - Parameters:
///     - lhs: The element to test.
///     - rhs: The set.
infix operator ∈: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∉_]
/// Returns `true` if `lhs` is not an element of `rhs`.
///
/// - Parameters:
///     - lhs: The element to test.
///     - rhs: The set.
infix operator ∉: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
/// Returns `true` if `lhs` contains `rhs`.
///
/// - Parameters:
///     - lhs: The set.
///     - rhs: The element to test.
infix operator ∋: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.SetDefinition.∌_]
/// Returns `true` if `lhs` does not contain `rhs`.
///
/// - Parameters:
///     - lhs: The set.
///     - rhs: The element to test.
infix operator ∌: ComparisonPrecedence

/// A type that defines a set.
///
/// Conformance Requirements:
///     - `static func ∋ (lhs: Element, rhs: Self) -> Bool`
public protocol SetDefinition {

    /// The element type.
    associatedtype Element

    // [_Define Documentation: SDGCornerstone.SetDefinition.∈_]
    /// Returns `true` if `lhs` is an element of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The element to test.
    ///     - rhs: The set.
    static func ∈ (lhs: Element, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∉_]
    /// Returns `true` if `lhs` is not an element of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The element to test.
    ///     - rhs: The set.
    static func ∉ (lhs: Element, rhs: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `lhs` contains `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    static func ∋ (lhs: Self, rhs: Element) -> Bool

    // [_Define Documentation: SDGCornerstone.SetDefinition.∌_]
    /// Returns `true` if `lhs` does not contain `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    static func ∌ (lhs: Self, rhs: Element) -> Bool
}

extension SetDefinition {

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∈_]
    /// Returns `true` if `lhs` is an element of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The element to test.
    ///     - rhs: The set.
    public static func ∈ (lhs: Element, rhs: Self) -> Bool {
        return rhs ∋ lhs
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∉_]
    /// Returns `true` if `lhs` is not an element of `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The element to test.
    ///     - rhs: The set.
    public static func ∉ (lhs: Element, rhs: Self) -> Bool {
        return ¬(lhs ∈ rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∌_]
    /// Returns `true` if `lhs` does not contain `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The set.
    ///     - rhs: The element to test.
    public static func ∌ (lhs: Self, rhs: Element) -> Bool {
        return ¬(lhs ∋ rhs)
    }
}
