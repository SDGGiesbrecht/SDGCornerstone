/*
 Day.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar compenent representing a day of the month.
public protocol Day : ConsistentlyOrderedCalendarComponent {

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    associatedtype Vector : IntegerProtocol
}

extension Day {

    // MARK: - Text Representations

    /// Returns the day in English digits. (“1”, “2”, “3”, etc.)
    public func inEnglishDigits() -> StrictString {
        return ordinal.inDigits()
    }

    /// Gibt den Tag in deutschen Ziffern zurück. („1.“, „2.“, „3.“, usw.)
    public func inDeutschenZiffern() -> StrictString {
        return ordinal.inDigits() + "."
    }

    /// Retourne le jour en chiffres français. (« 1er », « 2 », « 3 », etc.)
    public func enChiffresFrançais() -> StrictString {
        if ordinal == 1 {
            return ordinal.ordinalFrançaisAbrégé(genre: .masculin, nombre: .singular)
        } else {
            return ordinal.inDigits()
        }
    }

    /// Επιστρέφει την ημέρα στα ελληνικά ψηφία. («1», «2», «3», κ.λπ.)
    public func σταΕλληνικάΨηφία() -> StrictString {
        return ordinal.inDigits()
    }

    /// מחזירה את היום בעברית ובספרות. (”1“, ”2“, ”3“, וכו׳)
    public func בעברית־בספרות() -> StrictString {
        return ordinal.inDigits()
    }
}
