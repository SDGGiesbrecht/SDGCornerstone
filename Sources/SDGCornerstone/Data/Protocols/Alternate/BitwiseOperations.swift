/*
 BitwiseOperations.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension BitwiseOperations where Self : BitwiseLogic {
    // MARK: - where Self : BitwiseLogic

    // [_Define Documentation: SDGCornerstone.BitwiseOperations.allZeros_]
    /// An instance with all its bits set to zero.

    /// Returns the bits not present in `x`.
    public static prefix func ~ (x: Self) -> Self {
        return x.bitwiseNot()
    }

    /// Returns the bits present in both `lhs` and `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: Some bits.
    ///     - rhs: Some other bits.
    public static func & (lhs: Self, rhs: Self) -> Self {
        return lhs.bitwiseAnd(with: rhs)
    }

    /// Returns the bits present in either `lhs` or `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: Some bits.
    ///     - rhs: Some other bits.
    public static func | (lhs: Self, rhs: Self) -> Self {
        return lhs.bitwiseOr(with: rhs)
    }

    /// Returns the bits present only in `lhs` or only in `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: Some bits.
    ///     - rhs: Some other bits.
    public static func ^ (lhs: Self, rhs: Self) -> Self {
        return lhs.bitwiseExclusiveOr(with: rhs)
    }
}
