/*
 GregorianMinute.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A minute of the Gregorian hour.
public struct GregorianMinute: CardinalCalendarComponent, CodableViaRawRepresentableCalendarComponent, ConsistentDurationCalendarComponent, ICalendarComponent, ISOCalendarComponent, RawRepresentableCalendarComponent & _StrideableIfNotInherited, TextualPlaygroundDisplay {

  // MARK: - Static Properties

  /// The number of minutes in an hour.
  public static let minutesPerHour: Int = 60

  // MARK: - Properties

  private var minute: Int

  // MARK: - ConsistentlyOrderedCalendarComponent

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public init(ordinal: RawValue) {
    self.init(ordinal − (1 as Vector))
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public var ordinal: RawValue {
    return rawValue + (1 as Vector)
  }

  // MARK: - ConsistentDurationCalendarComponent

  public static var duration: CalendarInterval<FloatMax> {
    return (1 as FloatMax).minutes
  }

  // MARK: - Text Representations

  /// Returns the minite in digits with leading zeroes.
  public func inDigits() -> StrictString {
    return minute.inDigits().filled(to: 2, with: "0", from: .start)
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(
      UserFacing<StrictString, FormatLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada, .deutschDeutschland,
          .françaisFrance, .ελληνικάΕλλάδα, .עברית־ישראל:
          return self.inDigits()
        }
      }).resolved()
    )
  }

  // MARK: - ISOCalendarComponent

  public func inISOFormat() -> StrictString {
    return minute.inDigits().filled(to: 2, with: "0", from: .start)
  }

  // MARK: - PointProtocol

  public typealias Vector = Int

  // MARK: - RawRepresentableCalendarComponent

  public init(unsafeRawValue: RawValue) {
    minute = unsafeRawValue
  }

  public static let validRange: Range<RawValue>? = 0..<GregorianMinute.minutesPerHour

  public var rawValue: RawValue {
    return minute
  }
}
