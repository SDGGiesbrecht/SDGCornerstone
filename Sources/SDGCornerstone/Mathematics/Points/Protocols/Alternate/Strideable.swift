/*
 Strideable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Strideable where Self : OneDimensionalPoint {
    // MARK: - where Self : OneDimensionalPoint

    /// Returns the value that follows `self` by a distance of `n`.
    ///
    /// - Parameters:
    ///     - n: The distance to advance.
    ///
    /// - Recommended: +
    public func advanced(by n: Vector) -> Self {
        return self + n
    }

    /// Returns the distance from `self` to `other`.
    ///
    /// - Parameters:
    ///     - other: The value to which the distance should be measured.
    ///
    /// - Recommended: −
    public func distance(to other: Self) -> Vector {
        return other − self
    }
}
