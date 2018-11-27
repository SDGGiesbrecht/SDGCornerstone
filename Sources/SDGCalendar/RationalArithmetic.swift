/*
 RationalArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension RationalArithmetic {

    // MARK: - Calendar Intervals

    /// Returns a calendar interval in Gregorian leap year cycles.
    @inlinable public var gregorianLeapYearCycles: CalendarInterval<Self> {
        return CalendarInterval(gregorianLeapYearCycles: self)
    }

    /// Returns a calendar interval in Hebrew moons.
    @inlinable public var hebrewMoons: CalendarInterval<Self> {
        return CalendarInterval(hebrewMoons: self)
    }

    /// Returns a calendar interval in weeks.
    @inlinable public var weeks: CalendarInterval<Self> {
        return CalendarInterval(weeks: self)
    }

    /// Returns a calendar interval in days.
    @inlinable public var days: CalendarInterval<Self> {
        return CalendarInterval(days: self)
    }

    /// Returns a calendar interval in hours.
    @inlinable public var hours: CalendarInterval<Self> {
        return CalendarInterval(hours: self)
    }

    /// Returns a calendar interval in minutes.
    @inlinable public var minutes: CalendarInterval<Self> {
        return CalendarInterval(minutes: self)
    }

    /// Returns a calendar interval in Hebrew parts.
    @inlinable public var hebrewParts: CalendarInterval<Self> {
        return CalendarInterval(hebrewParts: self)
    }

    /// Returns a calendar interval in seconds.
    @inlinable public var seconds: CalendarInterval<Self> {
        return CalendarInterval(seconds: self)
    }
}
