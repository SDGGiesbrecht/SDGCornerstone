/*
 RawRepresentable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Workaround: Automatically handled by Equatable in Swift 4.1 (Swift 4.0.3)_]

extension RawRepresentable {

    // [_Define Documentation: SDGCornerstone.RawRepresentable.RawValue_]
    /// The raw value type.
}

extension RawRepresentable where RawValue : Equatable {
    // MARK: - where RawValue : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func ≠ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue != followingValue
    }
}

extension RawRepresentable where Self : Equatable, RawValue : Equatable {
    // MARK: - where Self : Equatable, RawValue : Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func ≠ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue != followingValue
    }
}
