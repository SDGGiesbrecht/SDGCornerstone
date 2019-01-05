/*
 NumericCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar component defined by a numeric raw value.
public protocol NumericCalendarComponent : RawRepresentableCalendarComponent {

}

extension NumericCalendarComponent {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.+=)
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    @inlinable public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue = Self(precedingValue.rawValue + followingValue)
    }

    // #documentation(SDGCornerstone.PointProtocol.−)
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        return precedingValue.rawValue − followingValue.rawValue
    }
}
