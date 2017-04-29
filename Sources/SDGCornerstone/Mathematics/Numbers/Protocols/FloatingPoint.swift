/*
 FloatingPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension FloatingPoint {
    fileprivate func roundedAsFloatingPoint(_ rule: FloatingPointRoundingRule) -> Self {
        return rounded(rule)
    }
}
extension FloatingPoint where Self : WholeArithmetic {
    // MARK: - where Self : WholeArithmetic
    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - MutatingVariant: round
    public func rounded(_ rule: FloatingPointRoundingRule) -> Self {
        // Disambiguate FloatingPoint.rounded(_:) vs WholeArithmetic.rounded(_:)
        return roundedAsFloatingPoint(rule)
    }
}
