/*
 HebrewMonthAndYear.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A Hebrew month of a particular year.
public struct HebrewMonthAndYear: Comparable, Equatable, FixedScaleOneDimensionalPoint,
  PointProtocol, TextualPlaygroundDisplay
{

  // MARK: - Properties

  /// The month.
  public private(set) var month: HebrewMonth
  /// The year.
  public private(set) var year: HebrewYear

  // MARK: - Initialization

  /// Creates a month in a year.
  ///
  /// - Parameters:
  ///     - month: The month.
  ///     - year: The year.
  public init(month: HebrewMonth, year: HebrewYear) {
    var month = month
    month.correctForYear(leapYear: year.isLeapYear)
    self.month = month
    self.year = year
  }

  // MARK: - Comparable

  public static func < (
    precedingValue: HebrewMonthAndYear,
    followingValue: HebrewMonthAndYear
  ) -> Bool {
    return compare(precedingValue, followingValue, by: { $0.year }, { $0.month })
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(
      UserFacing<StrictString, FormatLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
          return self.month.inEnglish() + " " + self.year.inEnglishDigits()
        case .englishUnitedStates, .englishCanada:
          return self.month.inEnglish() + ", " + self.year.inEnglishDigits()
        case .deutschDeutschland:
          return self.month._aufDeutsch() + " " + self.year._inDeutschenZiffern()
        case .françaisFrance:
          return self.month._enFrançais(.sentenceMedial) + " " + self.year._enChiffresFrançais()
        case .ελληνικάΕλλάδα:
          return self.month._σεΕλληνικά(.ονομαστική) + " " + self.year._σεΕλληνικάΨηφία()
        case .עברית־ישראל:
          return self.month._בעברית() + " " + self.year._בעברית־בספרות()
        }
      }).resolved()
    )
  }

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let month = try container.decode(HebrewMonth.self)
    let year = try container.decode(HebrewYear.self)
    self = HebrewMonthAndYear(month: month, year: year)
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(month)
    try container.encode(year)
  }

  // MARK: - Equatable

  public static func == (precedingValue: HebrewMonthAndYear, followingValue: HebrewMonthAndYear)
    -> Bool
  {
    return precedingValue.year == followingValue.year ∧ precedingValue.month == followingValue.month
  }

  // MARK: - PointProtocol

  public typealias Vector = Int

  public static func += (precedingValue: inout HebrewMonthAndYear, followingValue: Int) {
    if followingValue.isNegative {
      for _ in 1...(|followingValue|) {
        precedingValue.month.decrementCyclically(leapYear: precedingValue.year.isLeapYear) {
          precedingValue.year −= 1
        }
      }
    } else {
      for _ in 1...followingValue {
        precedingValue.month.incrementCyclically(leapYear: precedingValue.year.isLeapYear) {
          precedingValue.year += 1
        }
      }
    }
  }

  public static func − (precedingValue: HebrewMonthAndYear, followingValue: HebrewMonthAndYear)
    -> Int
  {
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
