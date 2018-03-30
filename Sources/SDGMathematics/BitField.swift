/*
 BitField.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can be used with bitwise operations.
///
/// Conformance Requirements:
///
/// - `mutating func formBitwiseNot()`
/// - `mutating func formBitwiseAnd(with other: Self)`
/// - `mutating func formBitwiseOr(with other: Self)`
/// - `mutating func formBitwiseExclusiveOr(with other: Self)`
public protocol BitField : Equatable {

    // [_Define Documentation: SDGCornerstone.BitField.bitwiseNot()_]
    /// Returns the bits not present in `self`.
    func bitwiseNot() -> Self

    // [_Define Documentation: SDGCornerstone.BitField.formBitwiseNot()_]
    /// Inverts the bits.
    mutating func formBitwiseNot()

    // [_Define Documentation: SDGCornerstone.BitField.bitwiseAnd(with:)_]
    /// Returns the bits present in both `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    func bitwiseAnd(with other: Self) -> Self

    // [_Define Documentation: SDGCornerstone.BitField.formBitwiseAnd(with:)_]
    /// Removes the bits not also present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    mutating func formBitwiseAnd(with other: Self)

    // [_Define Documentation: SDGCornerstone.BitField.bitwiseOr(with:)_]
    /// Returns the bits present in either `self` or `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    func bitwiseOr(with other: Self) -> Self

    // [_Define Documentation: SDGCornerstone.BitField.formBitwiseOr(with:)_]
    /// Inserts the bits present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    mutating func formBitwiseOr(with other: Self)

    // [_Define Documentation: SDGCornerstone.BitField.bitwiseExclusiveOr(with:)_]
    /// Returns the bits present only in `self` or only in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    func bitwiseExclusiveOr(with other: Self) -> Self

    // [_Define Documentation: SDGCornerstone.BitField.formBitwiseExclusiveOr(with:)_]
    /// Inserts the bits present in `other` and removes the bits present in both.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    mutating func formBitwiseExclusiveOr(with other: Self)
}

extension BitField {

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseNot()_]
    /// Returns the bits not present in `self`.
    @_inlineable public func bitwiseNot() -> Self {
        return nonmutatingVariant(of: Self.formBitwiseNot, on: self)
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseAnd(with:)_]
    /// Returns the bits present in both `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public func bitwiseAnd(with other: Self) -> Self {
        return nonmutatingVariant(of: Self.formBitwiseAnd, on: self, with: other)
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseOr(with:)_]
    /// Returns the bits present in either `self` or `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public func bitwiseOr(with other: Self) -> Self {
        return nonmutatingVariant(of: Self.formBitwiseOr, on: self, with: other)
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseExclusiveOr(with:)_]
    /// Returns the bits present only in `self` or only in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public func bitwiseExclusiveOr(with other: Self) -> Self {
        return nonmutatingVariant(of: Self.formBitwiseExclusiveOr, on: self, with: other)
    }
}
