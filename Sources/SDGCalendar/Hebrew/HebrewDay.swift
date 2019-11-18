/*
 HebrewDay.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A day of the Hebrew month.
public struct HebrewDay: CodableViaRawRepresentableCalendarComponent,
  ConsistentDurationCalendarComponent, Day, OrdinalCalendarComponent,
  RawRepresentableCalendarComponent
{

  // MARK: - Properties

  private var day: Int

  // MARK: - Recurrence

  /// Corrects the day for the specified month and year, altering them if necessary.
  ///
  /// If it doesn’t exist that year, Cheshvan 30 will be replaced by Kislev 1, etc.
  ///
  /// - Parameters:
  ///     - month: The month to correct for.
  ///     - year: The year to correct for.
  public mutating func correct(forMonth month: inout HebrewMonth, year: inout HebrewYear) {
    month.correctForYear(leapYear: year.isLeapYear)

    let daysInMonth = month.numberOfDays(yearLength: year.length, leapYear: year.isLeapYear)
    if day > daysInMonth {
      day −= daysInMonth
      month.incrementCyclically(leapYear: year.isLeapYear) { year += 1 }
    }
  }

  // MARK: - ConsistentDurationCalendarComponent

  public static var duration: CalendarInterval<FloatMax> {
    return (1 as FloatMax).days
  }

  // MARK: - PointProtocol

  public typealias Vector = Int

  // MARK: - RawRepresentableCalendarComponent

  public init(unsafeRawValue: RawValue) {
    day = unsafeRawValue
  }

  public static let validRange: Range<RawValue>? = 1..<HebrewMonth.maximumNumberOfDays + 1

  public var rawValue: RawValue {
    return day
  }
}
