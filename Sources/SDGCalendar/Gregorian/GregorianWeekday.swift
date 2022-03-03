/*
 GregorianWeekday.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A day of the Gregorian week.
public enum GregorianWeekday: Int, ConsistentDurationCalendarComponent,
  ConsistentlyOrderedCalendarComponent & _StrideableIfNotInherited, Decodable, Encodable,
  EnumerationCalendarComponent, Weekday
{

  // MARK: - Cases

  /// Sunday.
  case sunday
  /// Monday.
  case monday
  /// Tuesday.
  case tuesday
  /// Wednesday.
  case wednesday
  /// Thursday.
  case thursday
  /// Friday.
  case friday
  /// Saturday.
  case saturday

  // MARK: - Static Properties

  /// The number of days in a week.
  public static let daysPerWeek: Int = allCases.count

  // MARK: - ConsistentDurationCalendarComponent

  public static var duration: CalendarInterval<FloatMax> {
    return (1 as FloatMax).days
  }

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    try self.init(usingOrdinalFrom: decoder)
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    try encodeUsingOrdinal(to: encoder)
  }

  // MARK: - PointProtocol

  public typealias Vector = RawValue

  // MARK: - Strideable

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func advanced(by n: Int) -> GregorianWeekday {
    return Self(rawValue: rawValue + n)!
  }
}
