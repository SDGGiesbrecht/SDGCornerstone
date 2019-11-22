/*
 CalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A component of a particular calendar.
public protocol CalendarComponent: Decodable, Encodable {

  /// The mean duration.
  static var meanDuration: CalendarInterval<FloatMax> { get }

  /// The minimum duration.
  static var minimumDuration: CalendarInterval<FloatMax> { get }

  /// The maximum duration.
  static var maximumDuration: CalendarInterval<FloatMax> { get }
}
