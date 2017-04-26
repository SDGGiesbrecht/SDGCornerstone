/*
 SignedNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SignedNumber where Self : Negatable {
    // MARK: - where Self : Negatable

    /// Returns the result of negating `x`.
    ///
    /// - Parameters:
    ///     - x: The value to negate.
    ///
    /// - Recommended: −
    public static prefix func - (x: Self) -> Self {
        return −x
    }
}

extension SignedNumber where Self : Subtractable {
    // MARK: - where Self : Subtractable

    /// Returns the difference between `lhs` and `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - Recommended: −
    public static func - (lhs: Self, rhs: Self) -> Self {
        return lhs − rhs
    }
}
