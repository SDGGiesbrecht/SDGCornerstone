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
import SDGLocalization

import SDGCornerstoneLocalizations

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

  // MARK: - ConsistentlyOrderedCalendarComponent

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public var ordinal: Vector {
    return rawValue
  }

  // MARK: - Day

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func inEnglishDigits() -> StrictString {
#warning("Debugging...")
return ""
#if false
    return ordinal.inDigits()
    #endif
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func inDeutschenZiffern() -> StrictString {
    return ordinal.abgekürzteDeutscheOrdnungszahl()
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func enChiffresFrançais() -> SemanticMarkup {
    if ordinal == 1 {
      return ordinal.ordinalFrançaisAbrégé(genre: .masculin, nombre: .singular)
    } else {
      return SemanticMarkup(ordinal.inDigits())
    }
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func σεΕλληνικάΨηφία() -> StrictString {
    return ordinal.inDigits()
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func בעברית־בספרות() -> StrictString {
    return ordinal.inDigits()
  }

  // MARK: - ISOCalendarComponent

  public func inISOFormat() -> StrictString {
    return ordinal.inDigits().filled(to: 2, with: "0", from: .start)
  }
  
  // MARK: - MarkupPlaygroundDisplay

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func playgroundDescriptionMarkup() -> SemanticMarkup {
    return UserFacing<SemanticMarkup, FormatLocalization>({ localization in
      switch localization {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
#warning("Debugging...")
return ""
#if false
        return SemanticMarkup(self.inEnglishDigits())
        #endif
      case .deutschDeutschland:
        #warning("Debugging...")
        return ""
        #if false
        return SemanticMarkup(self.inDeutschenZiffern())
        #endif
      case .françaisFrance:
#warning("Debugging...")
return ""
#if false
        return self.enChiffresFrançais()
#endif
      case .ελληνικάΕλλάδα:
#warning("Debugging...")
return ""
#if false
        return SemanticMarkup(self.σεΕλληνικάΨηφία())
#endif
      case .עברית־ישראל:
#warning("Debugging...")
return ""
#if false
        return SemanticMarkup(self.בעברית־בספרות())
#endif
      }
    }).resolved()
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
