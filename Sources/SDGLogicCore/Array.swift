/*
 Array.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Workaround: Automatically handled by Equatable in Swift 4.1 (Swift 4.0.3)_]

extension Array where Element : Equatable {
    // MARK: - where Element : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_transparent public static func ≠ (precedingValue: Array, followingValue: Array) -> Bool {
        return precedingValue != followingValue
    }
}

extension ArraySlice where Element : Equatable {
    // MARK: - where Element : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_transparent public static func ≠ (precedingValue: ArraySlice, followingValue: ArraySlice) -> Bool {
        return precedingValue != followingValue
    }
}

extension ContiguousArray where Element : Equatable {
    // MARK: - where Element : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_transparent public static func ≠ (precedingValue: ContiguousArray, followingValue: ContiguousArray) -> Bool {
        return precedingValue != followingValue
    }
}
