/*
 GregorianSecond.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A second of the Gregorian minute.
public struct GregorianSecond: CardinalCalendarComponent,
  CodableViaRawRepresentableCalendarComponent, ConsistentDurationCalendarComponent,
  ICalendarComponent, ISOCalendarComponent, RawRepresentableCalendarComponent,
  SmallestCalendarComponent, TextualPlaygroundDisplay
{

  // MARK: - Static Properties

  /// The number of seconds in a minute.
  public static let secondsPerMinute: Int = 60

  // MARK: - Properties

  private var second: FloatMax

  // MARK: - ConsistentDurationCalendarComponent

  public static var duration: CalendarInterval<FloatMax> {
    return (1 as FloatMax).seconds
  }

  // MARK: - Text Representations

  /// Returns the second in digits, floored and with leading zeroes.
  public func inDigits() -> StrictString {
    return Int(second.rounded(.down)).inDigits().filled(to: 2, with: "0", from: .start)
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
    return Int((second + 0.000_001).rounded(.down)).inDigits().filled(
      to: 2,
      with: "0",
      from: .start
    )
  }

  // MARK: - PointProtocol

  public typealias Vector = FloatMax

  // MARK: - RawRepresentableCalendarComponent

  public init(unsafeRawValue: FloatMax) {
    second = unsafeRawValue
  }

  public static let validRange: Range<FloatMax>? = 0..<FloatMax(GregorianSecond.secondsPerMinute)

  public var rawValue: FloatMax {
    return second
  }
}
