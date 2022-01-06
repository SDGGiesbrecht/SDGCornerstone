/*
 NumericCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A calendar component defined by a numeric raw value.
public protocol NumericCalendarComponent: RawRepresentableCalendarComponent {}

extension NumericCalendarComponent {

  // MARK: - PointProtocol

  public static func += (precedingValue: inout Self, followingValue: Vector) {
    precedingValue = Self(precedingValue.rawValue + followingValue)
  }

  public static func − (precedingValue: Self, followingValue: Self) -> Vector {
    return precedingValue.rawValue − followingValue.rawValue
  }
}
