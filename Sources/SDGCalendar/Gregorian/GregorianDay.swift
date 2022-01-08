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

  // MARK: - ConsistentDurationCalendarComponent

  public static var duration: CalendarInterval<FloatMax> {
    #warning("Debugging...")
    let x = 1 as FloatMax
    let y = x.days
    print("Call succeeded.")
    fatalError()
    #if false
    return (1 as FloatMax).days
    #endif
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

// #workaround(Swift 5.5.2, Redundant, but evades a compiler bug on Windows that leads to runtime crashes.)
extension FloatMax {

  /// Returns a calendar interval in days.
  public var days: CalendarInterval<FloatMax> {
    #warning("Debugging...")
    let x = CalendarInterval(days: self)
    fatalError("Call succeeded.")
    #if false
    return CalendarInterval(days: self)
    #endif
  }
}
