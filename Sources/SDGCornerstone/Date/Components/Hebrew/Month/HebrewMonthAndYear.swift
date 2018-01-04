/*
 HebrewMonthAndYear.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A Hebrew month of a particular year.
public struct HebrewMonthAndYear : Comparable, Equatable, FixedScaleOneDimensionalPoint, PointProtocol {

    // MARK: - Properties

    /// The month.
    public private(set) var month: HebrewMonth
    /// The year.
    public private(set) var year: HebrewYear

    // MARK: - Initialization

    /// Creates a month in a year.
    public init(month: HebrewMonth, year: HebrewYear) {
        var month = month
        month.correctForYear(leapYear: year.isLeapYear)
        self.month = month
        self.year = year
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: HebrewMonthAndYear, rhs: HebrewMonthAndYear) -> Bool {
        return (lhs.year, lhs.month) < (rhs.year, rhs.month)
    }

    // MARK: - Decodable

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let month = try container.decode(HebrewMonth.self)
        let year = try container.decode(HebrewYear.self)
        self = HebrewMonthAndYear(month: month, year: year)
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(month)
        try container.encode(year)
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: HebrewMonthAndYear, rhs: HebrewMonthAndYear) -> Bool {
        return (lhs.year, lhs.month) == (rhs.year, rhs.month)
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Int

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout HebrewMonthAndYear, rhs: Int) {
        if rhs.isNegative {
            for _ in 1 ... |rhs| {
                lhs.month.decrementCyclically(leapYear: lhs.year.isLeapYear) { lhs.year −= 1 }
            }
        } else {
            for _ in 1 ... rhs {
                lhs.month.incrementCyclically(leapYear: lhs.year.isLeapYear) { lhs.year += 1 }
            }
        }
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func − (lhs: HebrewMonthAndYear, rhs: HebrewMonthAndYear) -> Int {
        var distance = 0
        var point = lhs

        while point ≠ rhs {
            if point > rhs {
                distance += 1
                point −= 1
            } else {
                distance −= 1
                point += 1
            }
        }
        return distance
    }
}
