/*
 SignedNumeric.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SignedNumeric where Self : Negatable {
    // MARK: - where Self : Negatable

    /// Returns the additive inverse of the specified value.
    public static prefix func - (operand: Self) -> Self {
        return −operand
    }

    /// Replaces this value with its additive inverse.
    public mutating func negate() {
        self−=
    }
}
