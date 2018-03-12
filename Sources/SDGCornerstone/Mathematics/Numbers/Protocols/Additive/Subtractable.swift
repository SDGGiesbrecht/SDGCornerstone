/*
 Subtractable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension Subtractable where Self : TwoDimensionalVector {
    // MARK: - where Self : TwoDimensionalVector

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.Δx −= followingValue.Δx
        precedingValue.Δy −= followingValue.Δy
    }
}
