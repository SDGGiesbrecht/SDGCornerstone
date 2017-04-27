/*
 PointType.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that can be used with `+(_:_:)` and `−(_:_:)` in conjunction with an associated `Vector` type.
///
/// - Note: Unlike `Strideable`, `PointType`s do not need to conform to `Comparable`, allowing conformance by two‐dimensional points, etc.
///
/// Conformance Requirements:
///
/// - `Equatable`
/// - `static func += (lhs: inout Self, rhs: Vector)`
/// - `static func − (lhs: Self, rhs: Self) -> Vector`
public protocol PointType : Equatable {

    // [_Define Documentation: SDGCornerstone.PointType.Vector_]
    /// The type to be used as a vector.
    associatedtype Vector : Negatable

    // [_Define Documentation: SDGCornerstone.PointType.+_]
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - MutatingVariant: +=
    static func + (lhs: Self, rhs: Vector) -> Self

    // [_Define Documentation: SDGCornerstone.PointType.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    static func += (lhs: inout Self, rhs: Vector)

    // [_Define Documentation: SDGCornerstone.PointType.−(_:vector:)_]
    /// Returns the point arrived at by starting at the point on the left and moving according to the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to subtract.
    ///
    /// - MutatingVariant: −=
    //static func − (lhs: Self, rhs: Vector) -> Self
    // [_Workaround: The above line is temporarily commented because it falsely triggers “ambiguous use of operator” errors. See testSubtractable. (Swift 3.1.0)_]

    // [_Define Documentation: SDGCornerstone.PointType.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    static func − (lhs: Self, rhs: Self) -> Vector

    // [_Define Documentation: SDGCornerstone.PointType.−=_]
    /// Moves the point on the left by the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to subtract.
    ///
    /// - NonmutatingVariant: −
    static func −= (lhs: inout Self, rhs: Vector)
}

extension PointType {

    fileprivate static func addAsPointType(_ lhs: Self, _ rhs: Vector) -> Self {
        var result = lhs
        result += rhs
        return result
    }
    // [_Inherit Documentation: SDGCornerstone.PointType.+_]
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Vector) -> Self {
        return addAsPointType(lhs, rhs)
    }

    fileprivate static func subtractAsPointType(_ lhs: Self, _ rhs: Vector) -> Self {
        var result = lhs
        result −= rhs
        return result
    }
    // [_Inherit Documentation: SDGCornerstone.PointType.−(_:vector:)_]
    /// Returns the point arrived at by starting at the point on the left and moving according to the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to subtract.
    ///
    /// - MutatingVariant: −=
    public static func − (lhs: Self, rhs: Vector) -> Self {
        return subtractAsPointType(lhs, rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.PointType.−=_]
    /// Moves the point on the left by the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to subtract.
    ///
    /// - NonmutatingVariant: −
    public static func −= (lhs: inout Self, rhs: Vector) {
        lhs += −rhs
    }
}

extension PointType where Self.Vector == Self {
    // MARK: - Self.Vector == Self

    // [_Inherit Documentation: SDGCornerstone.PointType.−(_:vector:)_]
    /// Returns the point arrived at by starting at the point on the left and moving according to the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to subtract.
    ///
    /// - MutatingVariant: −=
    public static func − (lhs: Self, rhs: Vector) -> Self { // [_Exempt from Code Coverage_] Apparently unreachable.
        // Disambiguate Self − Vector = Self vs Self − Self = Vector
        return subtractAsPointType(lhs, rhs)
    }
}

extension PointType where Self : IntXFamily {
    // MARK: - where Self : IntXFamily

    // [_Inherit Documentation: SDGCornerstone.PointType.+_]
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Stride) -> Self {
        return lhs.advanced(by: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.PointType.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout Self, rhs: Stride) {
        lhs = lhs.advanced(by: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.PointType.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func − (lhs: Self, rhs: Self) -> Stride {
        return rhs.distance(to: lhs)
    }
}

extension PointType where Self : Strideable {
    // MARK: - where Self : Strideable

    // [_Inherit Documentation: SDGCornerstone.PointType.+_]
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Vector) -> Self {
        // Disambiguate PointType.+ vs Strideable.+
        return addAsPointType(lhs, rhs)
    }
}

extension PointType where Self : UIntFamily {
    // MARK: - where Self : UIntFamily

    // [_Inherit Documentation: SDGCornerstone.PointType.+_]
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Stride) -> Self {
        return lhs.advanced(by: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.PointType.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout Self, rhs: Stride) {
        lhs = lhs.advanced(by: rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.PointType.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func − (lhs: Self, rhs: Self) -> Stride {
        return rhs.distance(to: lhs)
    }
}
