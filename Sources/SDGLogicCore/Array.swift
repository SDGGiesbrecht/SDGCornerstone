/*
 Array.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    @_inlineable public static func ≠ (lhs: Array, rhs: Array) -> Bool {
        return lhs != rhs
    }
}

extension ArraySlice where Element : Equatable {
    // MARK: - where Element : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    @_inlineable public static func ≠ (lhs: ArraySlice, rhs: ArraySlice) -> Bool {
        return lhs != rhs
    }
}

extension ContiguousArray where Element : Equatable {
    // MARK: - where Element : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    @_inlineable public static func ≠ (lhs: ContiguousArray, rhs: ContiguousArray) -> Bool {
        return lhs != rhs
    }
}
