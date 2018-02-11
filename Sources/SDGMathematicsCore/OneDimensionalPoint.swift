/*
 OneDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A `Comparable` type that can be used with `+(_:_:)` and `−(_:_:)` in conjunction with an associated `Vector` type.
///
/// - Note: For multi‐dimensional points, see `PointProtocol`.
///
/// - Note: This is distinct from `FixedScaleOneDimensionalPoint` so that types can still conform to `OneDimensionalPoint` even if they have vectors that cannot conform to `Numeric`.
///
/// Conformance Requirements:
///
/// - `PointProtocol`
/// - `Comparable`
public protocol OneDimensionalPoint : Comparable, PointProtocol {

}

extension OneDimensionalPoint where Self : Strideable {

    /// Returns the value that follows `self` by a distance of `n`.
    ///
    /// - Parameters:
    ///     - n: The distance to advance.
    @_transparent public func advanced(by n: Vector) -> Self {
        return self + n
    }

    /// Returns the distance from `self` to `other`.
    ///
    /// - Parameters:
    ///     - other: The value to which the distance should be measured.
    @_transparent public func distance(to other: Self) -> Vector {
        return other − self
    }
}
