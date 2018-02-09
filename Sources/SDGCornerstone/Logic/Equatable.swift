/*
 Equatable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogicCore

extension Equatable where Self : ComparableSet {
    // MARK: - where Self : ComparableSet

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue ⊇ followingValue ∧ precedingValue ⊆ followingValue
    }
}

extension Equatable where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue == followingValue.rawValue
    }
}
