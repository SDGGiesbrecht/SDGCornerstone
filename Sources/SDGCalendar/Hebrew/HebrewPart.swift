/*
 HebrewPart.swift

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

/// A part of the Hebrew hour.
public struct HebrewPart: CardinalCalendarComponent, CodableViaRawRepresentableCalendarComponent,
  ConsistentDurationCalendarComponent, RawRepresentableCalendarComponent, SmallestCalendarComponent,
  TextualPlaygroundDisplay
{

  // MARK: - Static Properties

  /// The number of parts in a Hebrew hour.
  public static let partsPerHour: Int = 1080

  // MARK: - Properties

  private var part: FloatMax

  // MARK: - Text Representations

  /// Returns the part in digits.
  public func inDigits() -> StrictString {
    return Int(part.rounded(.down)).inDigits()
  }

  // MARK: - ConsistentDurationCalendarComponent

  public static var duration: CalendarInterval<FloatMax> {
    return (1 as FloatMax).hebrewParts
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

  public typealias Vector = FloatMax

  // MARK: - RawRepresentableCalendarComponent

  public init(unsafeRawValue: RawValue) {
    part = unsafeRawValue
  }

  // #workaround(workspace version 0.41.0, Indirection because “let” is not detected as protocol conformance during documentation.)
  @usableFromInline internal static let _validRange: Range<RawValue>? =
    0..<FloatMax(HebrewPart.partsPerHour)
  @inlinable public static var validRange: Range<RawValue>? {
    return _validRange
  }

  public var rawValue: RawValue {
    return part
  }
}
