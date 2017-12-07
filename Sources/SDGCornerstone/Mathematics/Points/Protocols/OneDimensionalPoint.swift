/*
 OneDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

extension OneDimensionalPoint where Vector : IntegerProtocol {
    // MARK: - where Vector : IntegerProtocol

    // [_Define Documentation: SDGCornerstone.OneDimensionalPoint.increment()_]
    /// Advances to the next value.
    public mutating func increment() {
        self += 1
    }

    // [_Define Documentation: SDGCornerstone.OneDimensionalPoint.decrement()_]
    /// Retreats to the previous value.
    public mutating func decrement() {
        self −= 1
    }

    // [_Define Documentation: SDGCornerstone.OneDimensionalPoint.successor()_]
    /// Returns the value which comes immediately after.
    public func successor() -> Self {
        return self + 1
    }

    // [_Define Documentation: SDGCornerstone.OneDimensionalPoint.predecessor()_]
    /// Returns the value which comes immediately before.
    public func predecessor() -> Self {
        return self − 1
    }
}
