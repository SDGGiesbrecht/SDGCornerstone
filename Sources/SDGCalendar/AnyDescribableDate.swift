/*
 AnyDescribableDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An opaque wrapper for a `DescribableDate`.
public struct AnyDescribableDate: DescribableDate {

  // MARK: - Initialization

  /// Creates a wrapped date.
  ///
  /// - Parameters:
  ///     - wrapped: The date.
  public init(_ wrapped: DescribableDate) {
    self.date = wrapped
  }

  // MARK: - Properties

  private var date: DescribableDate

  // MARK: - CustomDebugStringConvertible

  public var debugDescription: String {
    return date.debugDescription
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return date.description
  }

  // MARK: - CustomPlaygroundDisplayConvertible

  public var playgroundDescription: Any {
    return date.playgroundDescription
  }

  // MARK: - DescribableDate

  public var hebrewYear: HebrewYear {
    return date.hebrewYear
  }

  public var hebrewMonth: HebrewMonth {
    return date.hebrewMonth
  }

  public var hebrewWeekday: HebrewWeekday {
    return date.hebrewWeekday
  }

  public var hebrewDay: HebrewDay {
    return date.hebrewDay
  }

  public var hebrewHour: HebrewHour {
    return date.hebrewHour
  }

  public var hebrewPart: HebrewPart {
    return date.hebrewPart
  }

  public var gregorianYear: GregorianYear {
    return date.gregorianYear
  }

  public var gregorianMonth: GregorianMonth {
    return date.gregorianMonth
  }

  public var gregorianWeekday: GregorianWeekday {
    return date.gregorianWeekday
  }

  public var gregorianDay: GregorianDay {
    return date.gregorianDay
  }

  public var gregorianHour: GregorianHour {
    return date.gregorianHour
  }

  public var gregorianMinute: GregorianMinute {
    return date.gregorianMinute
  }

  public var gregorianSecond: GregorianSecond {
    return date.gregorianSecond
  }

}
