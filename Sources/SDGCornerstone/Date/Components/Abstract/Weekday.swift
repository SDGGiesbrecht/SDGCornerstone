/*
 Weekday.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar compenent representing a day of the week.
public protocol Weekday : ConsistentlyOrderedCalendarComponent {

    // [_Define Documentation: SDGCornerstone.Weekday.inEnglish()_]
    /// Returns the English name.
    func inEnglish() -> StrictString

    // [_Define Documentation: SDGCornerstone.Weekday.aufDeutsch()_]
    /// Gibt den deutschen Namen zurück.
    func aufDeutsch() -> StrictString

    // [_Define Documentation: SDGCornerstone.Weekday.enFrançais()_]
    /// Retourne le nom français.
    func enFrançais(_ majuscules: Casing) -> StrictString

    // [_Define Documentation: SDGCornerstone.Weekday.σεΕλληνικά()_]
    /// Επιστρέφει τον ελληνικό όνομα.
    func σεΕλληνικά() -> StrictString

    // [_Define Documentation: SDGCornerstone.Weekday.בעברית()_]
    /// מחזירה את השם העברי.
    func בעברית() -> StrictString
}

extension Weekday where Vector : ExpressibleByIntegerLiteral {
    // MARK: - where Vector : ExpressibleByIntegerLiteral

    // [_Inherit Documentation: SDGCornerstone.Weekday.inEnglish()_]
    /// Returns the English name.
    public func inEnglish() -> StrictString {
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

    // [_Inherit Documentation: SDGCornerstone.Weekday.aufDeutsch()_]
    /// Gibt den deutschen Namen zurück.
    public func aufDeutsch() -> StrictString {
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

    // [_Inherit Documentation: SDGCornerstone.Weekday.enFrançais()_]
    /// Retourne le nom français.
    public func enFrançais(_ majuscules: Casing) -> StrictString {
        let jour: StrictString
        switch ordinal {
        case 1:
            jour = "dimanche"
        case 2:
            jour = "lundi"
        case 3:
            jour = "mardi"
        case 4:
            jour = "mercredi"
        case 5:
            jour = "jeudi"
        case 6:
            jour = "vendredi"
        case 7:
            jour = "samedi"
        default:
            unreachable()
        }
        return majuscules.applySimpleAlgorithm(to: jour)
    }

    // [_Inherit Documentation: SDGCornerstone.Weekday.σεΕλληνικά()_]
    /// Επιστρέφει τον ελληνικό όνομα.
    public func σεΕλληνικά() -> StrictString {
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

    // [_Inherit Documentation: SDGCornerstone.Weekday.בעברית()_]
    /// מחזירה את השם העברי.
    public func בעברית() -> StrictString {
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
}
