/*
 RationalArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension RationalArithmetic {

  // MARK: - Calendar Intervals

  /// Returns a calendar interval in Gregorian leap year cycles.
  public var gregorianLeapYearCycles: CalendarInterval<Self> {
    return CalendarInterval(gregorianLeapYearCycles: self)
  }

  /// Returns a calendar interval in Hebrew moons.
  public var hebrewMoons: CalendarInterval<Self> {
    return CalendarInterval(hebrewMoons: self)
  }

  /// Returns a calendar interval in weeks.
  public var weeks: CalendarInterval<Self> {
    return CalendarInterval(weeks: self)
  }

  /// Returns a calendar interval in days.
  public var days: CalendarInterval<Self> {
    return CalendarInterval(days: self)
  }

  /// Returns a calendar interval in hours.
  public var hours: CalendarInterval<Self> {
    return CalendarInterval(hours: self)
  }

  /// Returns a calendar interval in minutes.
  public var minutes: CalendarInterval<Self> {
    return CalendarInterval(minutes: self)
  }

  /// Returns a calendar interval in Hebrew parts.
  public var hebrewParts: CalendarInterval<Self> {
    return CalendarInterval(hebrewParts: self)
  }

  /// Returns a calendar interval in seconds.
  public var seconds: CalendarInterval<Self> {
    return CalendarInterval(seconds: self)
  }
}
