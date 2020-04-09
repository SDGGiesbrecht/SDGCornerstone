/*
 Date.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation

  extension Date {

    /// Creates a date from a calendar date.
    ///
    /// - Parameters:
    ///     - calendarDate: The calendar date.
    public init(_ calendarDate: CalendarDate) {
      self = calendarDate.converted(to: FoundationDate.self).date
    }
  }
#endif
