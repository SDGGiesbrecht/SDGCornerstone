/*
 ConsistentlyOrderedCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGLocalization
import SDGText

import SDGCornerstoneLocalizations

/// A calendar component with a consistent order.
public protocol ConsistentlyOrderedCalendarComponent: CalendarComponent,
  FixedScaleOneDimensionalPoint
{

  /// Creates a component from the number of complete components already elapsed.
  ///
  /// - Precondition: The number must be valid for the particular compenent.
  ///
  /// - Parameters:
  ///     - numberAlreadyElapsed: The number of complete compenents already elapsed.
  init(numberAlreadyElapsed: Vector)

  /// Creates a component from an ordinal.
  ///
  /// - Precondition: The ordinal must be valid for the particular compenent.
  ///
  /// - Parameters:
  ///     - ordinal: The ordinal.
  init(ordinal: Vector)

  /// The number of complete components already elapsed.
  var numberAlreadyElapsed: Vector { get }

  /// The ordinal.
  var ordinal: Vector { get }
}

extension ConsistentlyOrderedCalendarComponent
where Self: EnumerationCalendarComponent, Self.RawValue == Int {

  public init(numberAlreadyElapsed: RawValue) {
    guard let result = Self(rawValue: numberAlreadyElapsed) else {
      preconditionFailure(
        UserFacing<StrictString, APILocalization>({ localization in
          switch localization {
          case .englishCanada:  // @exempt(from: tests)
            return
              "Invalid raw value “\(numberAlreadyElapsed.inDigits())” for \(typeName: Self.self)."
          }
        })
      )
    }
    self = result
  }

  public init(ordinal: RawValue) {
    self.init(numberAlreadyElapsed: ordinal − 1)
  }

  public var numberAlreadyElapsed: RawValue {
    return rawValue
  }

  public var ordinal: RawValue {
    return rawValue + 1
  }

  // MARK: - PointProtocol

  public static func += (precedingValue: inout Self, followingValue: Vector) {
    precedingValue = Self(
      numberAlreadyElapsed: precedingValue.numberAlreadyElapsed + followingValue
    )
  }

  public static func − (precedingValue: Self, followingValue: Self) -> Vector {
    return precedingValue.numberAlreadyElapsed − followingValue.numberAlreadyElapsed
  }
}

extension ConsistentlyOrderedCalendarComponent
where Self: EnumerationCalendarComponent, Self.RawValue == Self.Vector {

  // MARK: - Decodable

  internal init(usingOrdinalFrom decoder: Decoder) throws {
    // For GregorianMonth, GregorianWeekday & HebrewWeekday
    try self.init(from: decoder, via: Vector.self, convert: { Self(rawValue: $0 − (1 as Vector)) })
  }

  // MARK: - Encodable

  internal func encodeUsingOrdinal(to encoder: Encoder) throws {
    // For GregorianMonth, GregorianWeekday & HebrewWeekday
    try encode(to: encoder, via: ordinal)
  }
}
