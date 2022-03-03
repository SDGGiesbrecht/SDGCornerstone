/*
 CalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A component of a particular calendar.
public protocol CalendarComponent: Decodable, Encodable {

  // #warning(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // @documentation(CalendarComponent.meanDuration)
  /// The mean duration.
  static var meanDuration: CalendarInterval<FloatMax> { get }

  // #warning(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // @documentation(CalendarComponent.minimumDuration)
  /// The minimum duration.
  static var minimumDuration: CalendarInterval<FloatMax> { get }

  // #warning(Swift 5.5.3, Documentation must be inherited manually due to SR‐15734 evasion.)
  // @documentation(CalendarComponent.maximumDuration)
  /// The maximum duration.
  static var maximumDuration: CalendarInterval<FloatMax> { get }
}
