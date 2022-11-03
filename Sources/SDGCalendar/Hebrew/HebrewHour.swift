/*
 HebrewHour.swift

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

/// An hour of the Hebrew day.
public struct HebrewHour: CardinalCalendarComponent, CodableViaRawRepresentableCalendarComponent,
  ConsistentDurationCalendarComponent, RawRepresentableCalendarComponent, TextualPlaygroundDisplay
{

  // MARK: - Static Properties

  /// The number of hours in a day.
  public static let hoursPerDay: Int = 24

  // MARK: - Properties

  private var hour: Int

  // MARK: - Text Representations

  /// Returns the hour in digits.
  public func inDigits() -> StrictString {
    return hour.inDigits()
  }

  // MARK: - ConsistentDurationCalendarComponent

  public static var duration: CalendarInterval<FloatMax> {
    return (1 as FloatMax).hours
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

  // MARK: - PointProtocol

  public typealias Vector = Int

  // MARK: - RawRepresentableCalendarComponent

  public init(unsafeRawValue: RawValue) {
    hour = unsafeRawValue
  }

  // #workaround(workspace version 0.41.1, Indirection because “let” is not detected as protocol conformance during documentation.)
  @usableFromInline internal static let _validRange: Range<RawValue>? = 0..<HebrewHour.hoursPerDay
  @inlinable public static var validRange: Range<RawValue>? {
    return _validRange
  }

  public var rawValue: RawValue {
    return hour
  }
}
