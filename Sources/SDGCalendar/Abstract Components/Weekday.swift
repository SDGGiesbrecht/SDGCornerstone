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
    @inlinable public func inEnglish() -> StrictString {
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

    @inlinable @usableFromInline internal func aufDeutsch() -> StrictString {
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

    @inlinable @usableFromInline internal func enFrançais(_ majuscules: Casing) -> StrictString {
        switch ordinal {
        case 1:
            return majuscules.apply(to: "dimanche")
        case 2:
            return majuscules.apply(to: "lundi")
        case 3:
            return majuscules.apply(to: "mardi")
        case 4:
            return majuscules.apply(to: "mercredi")
        case 5:
            return majuscules.apply(to: "jeudi")
        case 6:
            return majuscules.apply(to: "vendredi")
        case 7:
            return majuscules.apply(to: "samedi")
        default:
            unreachable()
        }
    }

    @inlinable @usableFromInline internal func σεΕλληνικά() -> StrictString {
        switch ordinal {
        case 1:
            return "Κυριακή"
        case 2:
            return "Δευτέρα"
        case 3:
            return "Τρίτη"
        case 4:
            return "Τετάρτη"
        case 5:
            return "Πέμπτη"
        case 6:
            return "Παρασκευή"
        case 7:
            return "Σάββατο"
        default:
            unreachable()
        }
    }

    @inlinable @usableFromInline internal func בעברית() -> StrictString {
        let יום: StrictString = "יום "
        switch ordinal {
        case 1:
            return יום.appending(contentsOf: "ראשון")
        case 2:
            return יום.appending(contentsOf: "שני")
        case 3:
            return יום.appending(contentsOf: "שלישי")
        case 4:
            return יום.appending(contentsOf: "רביעי")
        case 5:
            return יום.appending(contentsOf: "חמישי")
        case 6:
            return יום.appending(contentsOf: "ששי")
        case 7:
            return "שבת"
        default:
            unreachable()
        }
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacing<StrictString, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.inEnglish()
            case .deutschDeutschland:
                return self.aufDeutsch()
            case .françaisFrance:
                return self.enFrançais(.sentenceMedial)
            case .ελληνικάΕλλάδα:
                return self.σεΕλληνικά()
            case .עברית־ישראל:
                return self.בעברית()
            }
        }).resolved())
    }
}
