/*
 Weekday.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLocalization
import SDGCornerstoneLocalizations

/// A calendar compenent representing a day of the week.
public protocol Weekday : ConsistentlyOrderedCalendarComponent, TextualPlaygroundDisplay {

}

extension Weekday {

    /// Returns the English name.
    @_inlineable public func inEnglish() -> StrictString {
        switch ordinal {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            unreachable()
        }
    }

    @_inlineable @_versioned internal func aufDeutsch() -> StrictString {
        switch ordinal {
        case 1:
            return "Sonntag"
        case 2:
            return "Montag"
        case 3:
            return "Dienstag"
        case 4:
            return "Mittwoch"
        case 5:
            return "Donnerstag"
        case 6:
            return "Freitag"
        case 7:
            return "Samstag"
        default:
            unreachable()
        }
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacing<StrictString, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.inEnglish()
            case .deutschDeutschland:
                return self.aufDeutsch()
            }
        }).resolved())
    }
}
