/*
 CalendarInterval.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

// MARK: - Definition

private let hebrewPartsPerDay = HebrewHour.hoursPerDay × HebrewPart.partsPerHour
private let secondsPerDay =
  GregorianHour.hoursPerDay × GregorianMinute.minutesPerHour
  × GregorianSecond.secondsPerMinute

private let integralUnitsPerDay = lcm(hebrewPartsPerDay, secondsPerDay)

private typealias Measurement = SDGMathematics.Measurement
/// A time interval.
///
/// The units are all defined as fractions or multiples of days. This makes them convenient for calendaring, but not for physics. (Seconds are not SI seconds and leap seconds do not exist.)
public struct CalendarInterval<Scalar>: Decodable, Encodable, Measurement, TextualPlaygroundDisplay
where Scalar: RationalArithmetic {

  // MARK: - Initialization

  /// Creates an interval from a number of Gregorian leap year cycles.
  ///
  /// - Parameters:
  ///     - gregorianLeapYearCycles: The number of leap year cycles.
  public init(gregorianLeapYearCycles: Scalar) {
    self.inGregorianLeapYearCycles = gregorianLeapYearCycles
  }

  /// Creates an interval from a number of Hebrew moons.
  ///
  /// - Parameters:
  ///     - hebrewMoons: The number of moons.
  public init(hebrewMoons: Scalar) {
    self.inHebrewMoons = hebrewMoons
  }

  /// Creates an interval from a number of weeks.
  ///
  /// - Parameters:
  ///     - weeks: The number of weeks.
  public init(weeks: Scalar) {
    self.inWeeks = weeks
  }

  /// Creates an interval from a number of days.
  ///
  /// - Parameters:
  ///     - days: The number of days.
  public init(days: Scalar) {
    self.inDays = days
  }

  /// Creates an interval from a number of hours.
  ///
  /// - Parameters:
  ///     - hours: The number of hours.
  public init(hours: Scalar) {
    self.inHours = hours
  }

  /// Creates an interval from a number of minutes.
  ///
  /// - Parameters:
  ///     - minutes: The number of minutes.
  public init(minutes: Scalar) {
    self.inMinutes = minutes
  }

  /// Creates an interval from a number of Hebrew parts.
  ///
  /// - Parameters:
  ///     - hebrewParts: The number of parts.
  public init(hebrewParts: Scalar) {
    self.inHebrewParts = hebrewParts
  }

  /// Creates an interval from a number of seconds.
  ///
  /// - Parameters:
  ///     - seconds: The number of seconds.
  public init(seconds: Scalar) {
    self.inSeconds = seconds
  }

  // MARK: - Properties

  private var inUnits: Scalar = Scalar.zero

  internal var unitsPerGregorianLeapYearCycle: Scalar {
    return unitsPerDay × Scalar(GregorianYear.daysPerLeapYearCycle)
  }
  /// The numeric value in Gregorian leap year cycles.
  public var inGregorianLeapYearCycles: Scalar {
    get {
      return inUnits ÷ unitsPerGregorianLeapYearCycle
    }
    set {
      inUnits = newValue × unitsPerGregorianLeapYearCycle
    }
  }

  internal var unitsPerHebrewMoon: Scalar {
    return Scalar(HebrewMonth.lengthOfMoon.inUnits)
  }
  /// The numeric value in Hebrew moons.
  public var inHebrewMoons: Scalar {
    get {
      return inUnits ÷ unitsPerHebrewMoon
    }
    set {
      inUnits = newValue × unitsPerHebrewMoon
    }
  }

  internal var unitsPerWeek: Scalar {
    return unitsPerDay × Scalar(HebrewWeekday.daysPerWeek)
  }
  /// The numeric value in weeks.
  public var inWeeks: Scalar {
    get {
      return inUnits ÷ unitsPerWeek
    }
    set {
      inUnits = newValue × unitsPerWeek
    }
  }

  internal var unitsPerDay: Scalar {
    return Scalar(integralUnitsPerDay)
  }
  /// The numeric value in days.
  public var inDays: Scalar {
    get {
      return inUnits ÷ unitsPerDay
    }
    set {
      inUnits = newValue × unitsPerDay
    }
  }

  internal var unitsPerHour: Scalar {
    return unitsPerDay ÷ Scalar(HebrewHour.hoursPerDay)
  }
  /// The numeric value in hours.
  public var inHours: Scalar {
    get {
      return inUnits ÷ unitsPerHour
    }
    set {
      inUnits = newValue × unitsPerHour
    }
  }

  internal var unitsPerMinute: Scalar {
    return unitsPerHour ÷ Scalar(GregorianMinute.minutesPerHour)
  }
  /// The numeric value in minutes.
  public var inMinutes: Scalar {
    get {
      return inUnits ÷ unitsPerMinute
    }
    set {
      inUnits = newValue × unitsPerMinute
    }
  }

  internal var unitsPerHebrewPart: Scalar {
    return unitsPerHour ÷ Scalar(HebrewPart.partsPerHour)
  }
  /// The numeric value in Hebrew parts.
  public var inHebrewParts: Scalar {
    get {
      return inUnits ÷ unitsPerHebrewPart
    }
    set {
      inUnits = newValue × unitsPerHebrewPart
    }
  }

  internal var unitsPerSecond: Scalar {
    return unitsPerMinute ÷ Scalar(GregorianSecond.secondsPerMinute)
  }
  /// The numeric value in seconds.
  public var inSeconds: Scalar {
    get {
      return inUnits ÷ unitsPerSecond
    }
    set {
      inUnits = newValue × unitsPerSecond
    }
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(
      UserFacing<StrictString, FormatLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          let number = self.inDays.inDigits(
            maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1,
            radixCharacter: "."
          )
          if self == (1 as Scalar).days {
            return number + " day"
          } else {
            return number + " days"
          }
        case .deutschDeutschland:
          let number = self.inDays.inDigits(
            maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1,
            radixCharacter: ","
          )
          if self == (1 as Scalar).days {
            return number + " Tag"
          } else {
            return number + " Tage"
          }
        case .françaisFrance:
          let number = self.inDays.inDigits(
            maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1,
            radixCharacter: ","
          )
          if self == (1 as Scalar).days {
            return number + " jour"
          } else {
            return number + " jours"
          }
        case .ελληνικάΕλλάδα:
          let number = self.inDays.inDigits(
            maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1,
            radixCharacter: ","
          )
          if self == (1 as Scalar).days {
            return number + " ημέρα"
          } else {
            return number + " ημέρες"
          }
        case .עברית־ישראל:
          let number = self.inDays.inDigits(
            maximumDecimalPlaces: integralUnitsPerDay.inDigits().count + 1,
            radixCharacter: ","
          )
          if self == (1 as Scalar).days {
            return "יום אחד"
          } else if self == (2 as Scalar).days {
            return "יומיים"
          } else {
            return number + " יומים"
          }
        }
      }).resolved()
    )
  }

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let units = try container.decode(Scalar.self)
    let unitsPerDay = try container.decode(Int.self)
    self = CalendarInterval(days: units ÷ Scalar(unitsPerDay))
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(inUnits)
    try container.encode(integralUnitsPerDay)
  }

  // MARK: - Measurement

  public init(rawValue: Scalar) {
    inUnits = rawValue
  }

  public var rawValue: Scalar {
    get {
      return inUnits
    }
    set {
      inUnits = newValue
    }
  }
}
