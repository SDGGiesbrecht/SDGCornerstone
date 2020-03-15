/*
 CalendarDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import Foundation
#endif

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A date on a particular calendar.
///
/// The `CalendarDate` structure will remain accurate to its initial definition even if calendar or time zone rules change in the future, such as a change in the Daylight Savings start or end times. (This is in contrast to `Date`, which simply defines itself by a number of seconds since an epoch. If any rules were changed in the future, converting it back to a calendar‐based representation would result in a different date and time.)
///
/// To get the current time, use a static function such as `hebrewNow()` or `gregorianNow()`. Each returns a date representing the current time, but is defined according to a different calendar.
public struct CalendarDate: Comparable, DescribableDate, Equatable, OneDimensionalPoint,
  PointProtocol, TransparentWrapper
{

  // MARK: - Static Properties

  internal static let epoch = HebrewDate.epoch

  // MARK: - Static Functions

  /// Returns the current date on the Hebrew calendar.
  public static func hebrewNow() -> CalendarDate {
    return CalendarDate(definition: CalendarDate(Date()).converted(to: HebrewDate.self))
  }

  /// Returns the current date on the Gregorian calendar.
  public static func gregorianNow() -> CalendarDate {
    return CalendarDate(definition: CalendarDate(Date()).converted(to: GregorianDate.self))
  }

  // MARK: - Initialization

  /// Creates an instance with the provided definition.
  ///
  /// - Parameters:
  ///     - definition: The definition of the date.
  public init(definition: DateDefinition) {
    self.definition = definition
  }

  /// Creates a date using the Hebrew calendar.
  ///
  /// This initializer has two written forms whose effects are the same:
  /// - `init(hebrewYear:month:day:hour:part:)` tends to be more legible when used with variables.
  /// - `init(hebrew:_:_:at:_:)` tends to be more legible when used with literals.
  ///
  /// - Parameters:
  ///     - year: The year.
  ///     - month: The month.
  ///     - day: The day of the month.
  ///     - hour: The hour.
  ///     - part: The part.
  public init(
    hebrewYear year: HebrewYear,
    month: HebrewMonth = .tishrei,
    day: HebrewDay = 1,
    hour: HebrewHour = 0,
    part: HebrewPart = 0
  ) {
    self.init(definition: HebrewDate(year: year, month: month, day: day, hour: hour, part: part))
  }

  /// Creates a date using the Hebrew calendar.
  ///
  /// This initializer has two written forms whose effects are the same:
  /// - `init(hebrewYear:month:day:hour:part:)` tends to be more legible when used with variables.
  /// - `init(hebrew:_:_:at:_:)` tends to be more legible when used with literals.
  ///
  /// - Parameters:
  ///     - month: The month.
  ///     - day: The day of the month.
  ///     - year: The year.
  ///     - hour: The hour.
  ///     - part: The part.
  public init(
    hebrew month: HebrewMonth,
    _ day: HebrewDay,
    _ year: HebrewYear,
    at hour: HebrewHour = 0,
    part: HebrewPart = 0
  ) {
    self.init(hebrewYear: year, month: month, day: day, hour: hour, part: part)
  }

  /// Creates a date using the Gregorian calendar.
  ///
  /// This initializer has two written forms whose effects are the same:
  /// - `init(gregorianYear:month:day:hour:minute:second:)` tends to be more legible when used with variables.
  /// - `init(gregorian:_:_:at:_:_:)` tends to be more legible when used with literals.
  ///
  /// - Parameters:
  ///     - year: The year.
  ///     - month: The month.
  ///     - day: The day of the month.
  ///     - hour: The hour.
  ///     - minute: The minute.
  ///     - second: The second.
  public init(
    gregorianYear year: GregorianYear,
    month: GregorianMonth = .january,
    day: GregorianDay = 1,
    hour: GregorianHour = 0,
    minute: GregorianMinute = 0,
    second: GregorianSecond = 0
  ) {
    let definition = GregorianDate(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second
    )
    self.init(definition: definition)
  }

  /// Creates a date using the Gregorian calendar.
  ///
  /// This initializer has two written forms whose effects are the same:
  /// - `init(gregorianYear:month:day:hour:minute:second:)` tends to be more legible when used with variables.
  /// - `init(gregorian:_:_:at:_:_:)` tends to be more legible when used with literals.
  ///
  /// - Parameters:
  ///     - month: The month.
  ///     - day: The day of the month.
  ///     - year: The year.
  ///     - hour: The hour.
  ///     - minute: The minute.
  ///     - second: The second.
  public init(
    gregorian month: GregorianMonth,
    _ day: GregorianDay,
    _ year: GregorianYear,
    at hour: GregorianHour = 0,
    _ minute: GregorianMinute = 0,
    _ second: GregorianSecond = 0
  ) {
    self.init(
      gregorianYear: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second
    )
  }

  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)
    /// Creates a calendar date using an instance of `Date`.
    ///
    /// - Parameters:
    ///     - dateInstance: The `Date` instance.
    public init(_ dateInstance: Date) {
      self.init(definition: FoundationDate(dateInstance))
    }
  #endif

  // MARK: - Properties

  private var definition: DateDefinition {
    willSet {
      cache = Cache()
    }
    didSet {
      cache.conversions[ObjectIdentifier(type(of: definition))] = definition
    }
  }

  private class Cache {
    fileprivate init() {}
    fileprivate var conversions: [ObjectIdentifier: DateDefinition] = [:]
  }
  private var cache = Cache()

  private var intervalSinceEpoch: CalendarInterval<FloatMax> {
    if let hebrew = definition as? HebrewDate {
      return hebrew.intervalSinceReferenceDate
    } else {
      return type(of: definition).referenceDate.intervalSinceEpoch
        + definition.intervalSinceReferenceDate
    }
  }

  // MARK: - Conversions

  private func recomputeDefinition<D: DateDefinition>(as type: D.Type) -> D {
    if type == HebrewDate.self {
      return D(intervalSinceReferenceDate: intervalSinceEpoch)
    } else {
      return D(intervalSinceReferenceDate: intervalSinceEpoch − D.referenceDate.intervalSinceEpoch)
    }
  }

  /// Returns a conversion of the definition to a specific `DateDefinition` type.
  ///
  /// This method is preferred to manual conversions, as the returned conversions are automatically cached.
  ///
  /// - Parameters:
  ///     - type: The type to convert to.
  ///
  /// - Returns: The converted definition.
  public func converted<D: DateDefinition>(to type: D.Type) -> D {

    let cachedDefinition: DateDefinition = cached(in: &cache.conversions[ObjectIdentifier(D.self)])
    {
      return recomputeDefinition(as: D.self)
    }

    if let result = cachedDefinition as? D {
      return result
    } else {  // @exempt(from: tests)
      return recomputeDefinition(as: D.self)  // @exempt(from: tests)
    }
  }

  // MARK: - Text Representations

  /// Returns the date in the ISO format.
  public func dateInISOFormat() -> StrictString {
    var result = gregorianYear.inISOFormat()
    result += "‐"
    result += gregorianMonth.inISOFormat()
    result += "‐"
    result += gregorianDay.inISOFormat()
    return result
  }

  /// Returns the time in the ISO format.
  ///
  /// - Parameters:
  ///     - includeSeconds: Whether or not to include the seconds.
  public func timeInISOFormat(includeSeconds: Bool = false) -> StrictString {
    var result = gregorianHour.inISOFormat() + ":" + gregorianMinute.inISOFormat()
    if includeSeconds {
      result += ":" + gregorianSecond.inISOFormat()
    }
    return result
  }

  /// Returns a string representation in the floating iCalendar format.
  public func floatingICalendarFormat() -> StrictString {
    var result = gregorianYear.inICalendarFormat()
    result += gregorianMonth.inICalendarFormat()
    result += gregorianDay.inICalendarFormat()
    result += "T"
    result += gregorianHour.inICalendarFormat()
    result += gregorianMinute.inICalendarFormat()
    result += gregorianSecond.inICalendarFormat()
    return result
  }

  /// Returns a string representation in UTC in the iCalendar format.
  public func iCalendarFormat() -> StrictString {
    return floatingICalendarFormat() + "Z"
  }

  // MARK: - Time Zones

  /// Returns date properties adjusted to the specified time zone.
  ///
  /// - Parameters:
  ///     - timeZone: The target time zone.
  public func adjusted(to timeZone: TimeZone) -> AnyDescribableDate {
    let date = self + FloatMax(timeZone.secondsFromGMT(for: Date(self))).seconds
    return AnyDescribableDate(date)
  }

  /// Returns date properties adjusted to mean solar time at the specified longitude, with negative angles representing west.
  ///
  /// - Parameters:
  ///     - longitude: The target longitude.
  public func adjustedToMeanSolarTime<N>(atLongitude longitude: Angle<N>) -> AnyDescribableDate
  where N: BinaryFloatingPoint {
    let convertedAngle = Angle(rawValue: FloatMax(longitude.rawValue))
    let date = self + CalendarInterval(days: convertedAngle.inRotations)
    return AnyDescribableDate(date)
  }

  // MARK: - Comparable

  public static func < (precedingValue: CalendarDate, followingValue: CalendarDate) -> Bool {
    return compare(precedingValue, followingValue) { $0.intervalSinceEpoch }
  }

  // MARK: - Decodable

  internal static var knownDateDefinitions: [StrictString: DateDefinition.Type] = {
    var definitions: [StrictString: DateDefinition.Type] = [
      HebrewDate.identifier: HebrewDate.self,
      GregorianDate.identifier: GregorianDate.self,
      RelativeDate.identifier: RelativeDate.self
    ]
    // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
    #if canImport(Foundation)
      definitions[FoundationDate.identifier] = FoundationDate.self
    #endif
    return definitions
  }()

  /// Registers a definition type so that its instances can be decoded.
  ///
  /// - Parameters:
  ///     - type: The type to register.
  public static func register(_ type: DateDefinition.Type) {
    knownDateDefinitions[type.identifier] = type
  }

  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let encodingIdentifier = try container.decode(StrictString.self)
    let encodedDefinition = try container.decode(StrictString.self)
    let lastCalculatedInstant = try container.decode(CalendarInterval<FloatMax>.self)

    if let definitionType = CalendarDate.knownDateDefinitions[encodingIdentifier] {
      self.init(
        definition: try definitionType.init(
          decoding: encodedDefinition,
          codingPath: container.codingPath
        )
      )
    } else {
      self.init(
        definition: UnknownDate(
          encodingIdentifier: encodingIdentifier,
          encodedDefinition: encodedDefinition,
          lastCalculatedInstant: lastCalculatedInstant
        )
      )
    }
  }

  // MARK: - DesbcribableDate

  public var hebrewYear: HebrewYear {
    return converted(to: HebrewDate.self).year
  }
  public var hebrewMonth: HebrewMonth {
    return converted(to: HebrewDate.self).month
  }
  public var hebrewWeekday: HebrewWeekday {
    return converted(to: HebrewWeekdayDate.self).weekday
  }
  public var hebrewDay: HebrewDay {
    return converted(to: HebrewDate.self).day
  }
  public var hebrewHour: HebrewHour {
    return converted(to: HebrewDate.self).hour
  }
  public var hebrewPart: HebrewPart {
    return converted(to: HebrewDate.self).part
  }

  public var gregorianYear: GregorianYear {
    return converted(to: GregorianDate.self).year
  }
  public var gregorianMonth: GregorianMonth {
    return converted(to: GregorianDate.self).month
  }
  public var gregorianWeekday: GregorianWeekday {
    return converted(to: GregorianWeekdayDate.self).weekday
  }
  public var gregorianDay: GregorianDay {
    return converted(to: GregorianDate.self).day
  }
  public var gregorianHour: GregorianHour {
    return converted(to: GregorianDate.self).hour
  }
  public var gregorianMinute: GregorianMinute {
    return converted(to: GregorianDate.self).minute
  }
  public var gregorianSecond: GregorianSecond {
    return converted(to: GregorianDate.self).second
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    if let unknown = definition as? UnknownDate {
      try container.encode(unknown.encodingIdentifier)
      try container.encode(unknown.encodedDefinition)
      try container.encode(unknown.lastCalculatedInstant)
    } else {
      let encodedDefinition = try definition.encode()
      try container.encode(type(of: definition).identifier)
      try container.encode(encodedDefinition)
      try container.encode(intervalSinceEpoch)
    }
  }

  // MARK: - Equatable

  public static func == (precedingValue: CalendarDate, followingValue: CalendarDate) -> Bool {
    return precedingValue.intervalSinceEpoch == followingValue.intervalSinceEpoch
  }

  // MARK: - PointProtocol

  public typealias Vector = CalendarInterval<FloatMax>

  public static func += (
    precedingValue: inout CalendarDate,
    followingValue: CalendarInterval<FloatMax>
  ) {
    if let relative = precedingValue.definition as? RelativeDate {
      precedingValue.definition = RelativeDate(
        relative.intervalSince + followingValue,
        after: relative.baseDate
      )
    } else {
      precedingValue.definition = RelativeDate(followingValue, after: precedingValue)
    }
  }

  public static func − (precedingValue: CalendarDate, followingValue: CalendarDate)
    -> CalendarInterval<FloatMax>
  {
    return precedingValue.intervalSinceEpoch − followingValue.intervalSinceEpoch
  }

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return definition
  }
}
