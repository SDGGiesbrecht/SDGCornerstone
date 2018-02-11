/*
 PointProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
    public static func + (precedingValue: Self, followingValue: Vector) -> Self {
        // Disambiguate PointProtocol vs Strideable
        var copy = precedingValue
        copy += followingValue
        return copy
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
        notImplementedYetAndCannotReturn()
        // return Self.Vector(Δx : Δx, Δy : Δy)
    }
}
