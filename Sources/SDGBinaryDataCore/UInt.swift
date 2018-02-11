/*
 UInt.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that represents a fixed‐length unsigned integer.
///
/// This protocol exists so that extensions to it can provide shared functionality for `UInt`, `UInt64`, `UInt32`, `UInt16` and `UInt8`.
public protocol UIntBitField : BitField, CustomPlaygroundQuickLookable, CustomReflectable, CVarArg, FixedWidthInteger, UnsignedInteger {}


extension UIntBitField {

    // MARK: - BitField

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseNot()_]
    /// Returns the bits not present in `self`.
    @_transparent public func bitwiseNot() -> Self {
        return ~self
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.formBitwiseNot()_]
    /// Inverts the bits.
    @_inlineable public mutating func formBitwiseNot() {
        self = bitwiseNot()
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseAnd(with:)_]
    /// Returns the bits present in both `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_transparent public func bitwiseAnd(with other: Self) -> Self {
        return self & other
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.formBitwiseAnd(with:)_]
    /// Removes the bits not also present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseAnd(with other: Self) {
        self = bitwiseAnd(with: other)
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseOr(with:)_]
    /// Returns the bits present in either `self` or `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_transparent public func bitwiseOr(with other: Self) -> Self {
        return self | other
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.formBitwiseOr(with:)_]
    /// Inserts the bits present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseOr(with other: Self) {
        self = bitwiseOr(with: other)
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.bitwiseExclusiveOr(with:)_]
    /// Returns the bits present only in `self` or only in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_transparent public func bitwiseExclusiveOr(with other: Self) -> Self {
        return self ^ other
    }

    // [_Inherit Documentation: SDGCornerstone.BitField.formBitwiseExclusiveOr(with:)_]
    /// Inserts the bits present in `other` and removes the bits present in both.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseExclusiveOr(with other: Self) {
        self = bitwiseExclusiveOr(with: other)
    }
}

extension UInt : UIntBitField {}
extension UInt64 : UIntBitField {}
extension UInt32 : UIntBitField {}
extension UInt16 : UIntBitField {}
extension UInt8 : UIntBitField {}
