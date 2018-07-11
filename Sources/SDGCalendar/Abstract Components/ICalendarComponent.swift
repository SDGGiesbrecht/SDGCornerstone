/*
 ICalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar component with an iCalendar representation.
public protocol ICalendarComponent {

    // @documentation(SDGCornerstone.ICalendarCompenent.inICalendarFormat())
    /// Returns a string representation in the iCalendar format.
    func inICalendarFormat() -> StrictString
}

extension ICalendarComponent where Self : ISOCalendarComponent {
    // MARK: - where Self : ISOCalendarComponent

    // #documentation(SDGCornerstone.ICalendarCompenent.inICalendarFormat())
    /// Returns a string representation in the iCalendar format.
    @_inlineable public func inICalendarFormat() -> StrictString {
        return inISOFormat()
    }
}
