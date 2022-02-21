/*
 GregorianDay.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText

/// A day of a Gregorian month.
public struct GregorianDay: CodableViaRawRepresentableCalendarComponent,
  ConsistentDurationCalendarComponent, Day, ICalendarComponent, ISOCalendarComponent,
  OrdinalCalendarComponent, RawRepresentableCalendarComponent
{

  // MARK: - Properties

  private var day: Int

  // MARK: - Recurrence

  /// Corrects the day for the specified month and year, altering them if necessary.
  ///
  /// February 29 becomes March 1 in non‐leap years.
  ///
  /// - Parameters:
  ///     - month: The month.
  ///     - year: The year.
  public mutating func correct(forMonth month: inout GregorianMonth, year: GregorianYear) {
    let daysInMonth = month.numberOfDays(leapYear: year.isLeapYear)
    if self.day > daysInMonth {
      self.day −= daysInMonth
      month.increment()
    }
  }

  // MARK: - CodableViaRawRepresentableCalendarComponent

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func encode(to encoder: Encoder) throws {
    try encode(to: encoder, via: rawValue)
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public init(from decoder: Decoder) throws {
    try self.init(from: decoder, via: RawValue.self, convert: { Self(possibleRawValue: $0) })
  }

  // MARK: - ConsistentDurationCalendarComponent

  public static var duration: CalendarInterval<FloatMax> {
    return (1 as FloatMax).days
  }

  // MARK: - ISOCalendarComponent

  public func inISOFormat() -> StrictString {
    return ordinal.inDigits().filled(to: 2, with: "0", from: .start)
  }

  // MARK: - PointProtocol

  public typealias Vector = Int

  // MARK: - RawRepresentableCalendarComponent

  public init(unsafeRawValue: RawValue) {
    day = unsafeRawValue
  }

  public static let validRange: Range<RawValue>? = 1..<GregorianMonth.maximumNumberOfDays + 1

  public var rawValue: Int {
    return day
  }
}
