/*
 AbsoluteValuable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension AbsoluteValuable where Self : NumericAdditiveArithmetic {
    // MARK: - where Self : NumericAdditiveArithmetic

    /// Returns the absolute value of `x`.
    ///
    /// - Parameters:
    ///     - x: The starting value.
    ///
    /// - Recommended: |
    public static func abs(_ x: Self) -> Self {
        return |x|
    }
}
