/*
 Date.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension Date {

    /// Creates a date from a calendar date.
    public init(_ calendarDate: CalendarDate) {
        self = calendarDate.converted(to: FoundationDate.self).date
    }
}
