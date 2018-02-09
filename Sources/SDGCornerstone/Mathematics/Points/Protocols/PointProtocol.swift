/*
 PointProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that can be used with `+(_:_:)` and `−(_:_:)` in conjunction with an associated `Vector` type.
///
/// - Note: Unlike `Strideable`, types conforming to `PointProtocol` do not need to conform to `Comparable`, allowing conformance by two‐dimensional points, etc.
///
/// Conformance Requirements:
///
/// - `Equatable`
/// - `static func += (precedingValue: inout Self, followingValue: Vector)`
/// - `static func − (precedingValue: Self, followingValue: Self) -> Vector`
public protocol PointProtocol : Codable, Equatable {

    // [_Define Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    associatedtype Vector : Negatable

    // [_Define Documentation: SDGCornerstone.PointProtocol.+_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to add.
    ///
    /// - MutatingVariant: +=
    static func + (precedingValue: Self, followingValue: Vector) -> Self

    // [_Define Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    static func += (precedingValue: inout Self, followingValue: Vector)

    // [_Define Documentation: SDGCornerstone.PointProtocol.−(_:vector:)_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the inverse of the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to subtract.
    ///
    /// - MutatingVariant: −=
    static func − (precedingValue: Self, followingValue: Vector) -> Self

    // [_Define Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    static func − (precedingValue: Self, followingValue: Self) -> Vector

    // [_Define Documentation: SDGCornerstone.PointProtocol.−=_]
    /// Moves the preceding point by the inverse of the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to subtract.
    ///
    /// - NonmutatingVariant: −
    static func −= (precedingValue: inout Self, followingValue: Vector)
}

extension PointProtocol {

    fileprivate static func addAsPointProtocol(_ precedingValue: Self, _ followingValue: Vector) -> Self {
        var result = precedingValue
        result += followingValue
        return result
    }
    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to add.
    ///
    /// - MutatingVariant: +=
    public static func + (precedingValue: Self, followingValue: Vector) -> Self {
        return addAsPointProtocol(precedingValue, followingValue)
    }

    fileprivate static func subtractAsPointProtocol(_ precedingValue: Self, _ followingValue: Vector) -> Self {
        var result = precedingValue
        result −= followingValue
        return result
    }
    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−(_:vector:)_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the inverse of the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to subtract.
    ///
    /// - MutatingVariant: −=
    public static func − (precedingValue: Self, followingValue: Vector) -> Self {
        return subtractAsPointProtocol(precedingValue, followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−=_]
    /// Moves the preceding point by the inverse of the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to subtract.
    ///
    /// - NonmutatingVariant: −
    public static func −= (precedingValue: inout Self, followingValue: Vector) {
        precedingValue += −followingValue
    }
}

// [_Workaround: The next line causes an abort trap compile failure. (Swift 4.0.3)_]
extension /*PointProtocol where Self : */ ConsistentlyOrderedCalendarComponent where Self : EnumerationCalendarComponent {
    // MARK: - where Self : ConsistentlyOrderedCalendarComponent, Self : EnumerationCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue = Self(numberAlreadyElapsed: precedingValue.numberAlreadyElapsed + followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        return precedingValue.numberAlreadyElapsed − followingValue.numberAlreadyElapsed
    }
}

// [_Workaround: The next line causes an abort trap compile failure. (Swift 4.0.3)_]
extension /*PointProtocol where Self : */IntFamily {
    // MARK: - where Self : IntFamily

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to add.
    ///
    /// - MutatingVariant: +=
    public static func + (precedingValue: Self, followingValue: Stride) -> Self {
        return precedingValue.advanced(by: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue = precedingValue.advanced(by: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        return followingValue.distance(to: precedingValue)
    }
}

// [_Workaround: The next line causes an abort trap compile failure. (Swift 4.0.3)_]
extension /*PointProtocol where Self : */ NumericCalendarComponent {
    // MARK: - where Self : NumericCalendarComponent

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue = Self(precedingValue.rawValue + followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        return precedingValue.rawValue − followingValue.rawValue
    }
}

extension PointProtocol where Self : Strideable {
    // MARK: - where Self : Strideable

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to add.
    ///
    /// - MutatingVariant: +=
    public static func + (precedingValue: Self, followingValue: Vector) -> Self {
        // Disambiguate PointProtocol.+ vs Strideable.+
        return addAsPointProtocol(precedingValue, followingValue)
    }
}

// [_Workaround: The next line causes an abort trap compile failure. (Swift 4.0.3)_]
extension /*PointProtocol where Self : */TwoDimensionalPoint where Self.Vector : TwoDimensionalVector, Self.Vector.Scalar == Self.Scalar {
    // MARK: - where Self : TwoDimensionalPoint, Self.Vector : TwoDimensionalVector, Self.Vector.Scalar == Self.Scalar

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue.x += followingValue.Δx
        precedingValue.y += followingValue.Δy
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        let Δx = precedingValue.x − followingValue.x
        let Δy = precedingValue.y − followingValue.y
        return Vector(Δx : Δx, Δy : Δy)
    }
}

// [_Workaround: The next line causes an abort trap compile failure. (Swift 4.0.3)_]
extension /*PointProtocol where Self : */UIntFamily {
    // MARK: - where Self : UIntFamily

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+_]
    /// Returns the point arrived at by starting at the preceding point and moving according to the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting point.
    ///     - followingValue: The vector to add.
    ///
    /// - MutatingVariant: +=
    public static func + (precedingValue: Self, followingValue: Stride) -> Self {
        return precedingValue.advanced(by: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue = precedingValue.advanced(by: followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    public static func − (precedingValue: Self, followingValue: Self) -> Stride {
        // [_Workaround: The following causes an EXC_BAD_INSTRUCTION. (Swift 4.0.3)_]
        //return followingValue.distance(to: precedingValue)
        return precedingValue.toStride() − followingValue.toStride()
    }
}

extension UIntFamily {
    // [_Workaround: Should not be necessary but for the above workaround. (Swift 4.0.3)_]
    fileprivate func toStride() -> Stride {
        return (0 as Self).distance(to: self)
    }
}
