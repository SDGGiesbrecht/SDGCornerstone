/*
 Addable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used with `+(_:_:)`.
///
/// The precise behaviour of `+` depends on the conforming type. It may be arithmetic addition, string concatenation, etc.
///
/// Conformance Requirements:
///
/// - `static func += (precedingValue: inout Self, followingValue: Self)`
public protocol Addable {

    // [_Define Documentation: SDGCornerstone.Addable.+_]
    /// Returns the sum, concatenation, or the result of a similar operation on two values implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to add.
    static func + (precedingValue: Self, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    static func += (precedingValue: inout Self, followingValue: Self)
}

extension Addable {

    // [_Inherit Documentation: SDGCornerstone.Addable.+_]
    /// Returns the sum, concatenation, or the result of a similar operation on two values implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to add.
    @_inlineable public static func + (precedingValue: Self, followingValue: Self) -> Self {
        return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
    }

    // [_Define Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.

    // [_Define Documentation: SDGCornerstone.Addable(Summation).+=_]
    /// Adds the following value to the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
}

extension Addable where Self : Strideable, Self.Stride == Self {
    // MARK: - where Self : Strideable, Stride == Self

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func + (precedingValue: Self, followingValue: Self) -> Self {
        // Disambiguate Addable vs Strideable
        return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
    }
}
