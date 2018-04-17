/*
 HebrewMonthAndYear.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCornerstoneLocalizations

/// A Hebrew month of a particular year.
public struct HebrewMonthAndYear : Comparable, Equatable, FixedScaleOneDimensionalPoint, PointProtocol, TextualPlaygroundDisplay {

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
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func < (precedingValue: HebrewMonthAndYear, followingValue: HebrewMonthAndYear) -> Bool {
        return (precedingValue.year, precedingValue.month) < (followingValue.year, followingValue.month)
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    public var description: String {
        return String(UserFacingText({ (localization: InterfaceLocalization) in
            switch localization {
            case .englishUnitedKingdom:
                return self.month.inEnglish() + " " + self.year.inEnglishDigits()
            case .englishUnitedStates, .englishCanada:
                return self.month.inEnglish() + ", " + self.year.inEnglishDigits()
            }
        }).resolved())
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
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (precedingValue: HebrewMonthAndYear, followingValue: HebrewMonthAndYear) -> Bool {
        return (precedingValue.year, precedingValue.month) == (followingValue.year, followingValue.month)
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Int

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    public static func += (precedingValue: inout HebrewMonthAndYear, followingValue: Int) {
        if followingValue.isNegative {
            for _ in 1 ... |followingValue| {
                precedingValue.month.decrementCyclically(leapYear: precedingValue.year.isLeapYear) { precedingValue.year −= 1 }
            }
        } else {
            for _ in 1 ... followingValue {
                precedingValue.month.incrementCyclically(leapYear: precedingValue.year.isLeapYear) { precedingValue.year += 1 }
            }
        }
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    public static func − (precedingValue: HebrewMonthAndYear, followingValue: HebrewMonthAndYear) -> Int {
        var distance = 0
        var point = precedingValue

        while point ≠ followingValue {
            if point > followingValue {
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
