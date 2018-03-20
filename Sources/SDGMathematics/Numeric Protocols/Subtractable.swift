/*
 Subtractable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type that can do scalar subtraction.
///
/// - Note: `Subtractable` is distinct from `Negatable` to allow whole number types to perform subtraction.
///
/// - Note: Unlike `Numeric`, `Subtractable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `Addable`
/// - `static func −= (precedingValue: inout Self, followingValue: Self)`
public protocol Subtractable : Addable {

    // [_Define Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    static func − (precedingValue: Self, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    static func −= (precedingValue: inout Self, followingValue: Self)

    // [_Define Documentation: SDGCornerstone.Subtractable.±_]
    /// Returns a tuple containing the sum and difference of `precedingValue` and `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The augend/minuend.
    ///     - followingValue: The addend/subtrahend.
    static func ± (precedingValue: Self, followingValue: Self) -> (sum: Self, difference: Self)
}

extension Subtractable {

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @_inlineable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return nonmutatingVariant(of: −=, on: precedingValue, with: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.±_]
    /// Returns a tuple containing the sum and difference of `precedingValue` and `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The augend/minuend.
    ///     - followingValue: The addend/subtrahend.
    @_inlineable public static func ± (precedingValue: Self, followingValue: Self) -> (sum: Self, difference: Self) {
        return (precedingValue + followingValue, precedingValue − followingValue)
    }
}

extension Subtractable where Self : Numeric {
    // MARK: - where Self : Numeric

    /// Subtracts one value from another and produces their difference.
    @_inlineable public static func - (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue − followingValue
    }

    /// Subtracts the second value from the first and stores the difference in the left‐hand‐side variable.
    @_inlineable public static func -= (precedingValue: inout Self, followingValue: Self) {
        precedingValue −= followingValue
    }
}

extension Subtractable where Self : Strideable, Self.Stride == Self {
    // MARK: - where Self : Strideable, Self.Stride == Self

    /// Subtracts one value from another and produces their difference.
    @_inlineable public static func - (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue − followingValue
    }

    /// Subtracts the second value from the first and stores the difference in the left‐hand‐side variable.
    @_inlineable public static func -= (precedingValue: inout Self, followingValue: Self) {
        precedingValue −= followingValue
    }
}
