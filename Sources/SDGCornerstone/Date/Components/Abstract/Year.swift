/*
 Year.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar compenent representing a year.
public protocol Year {

    // [_Define Documentation: SDGCornerstone.Year.inEnglishDigits()_]
    /// Returns the year in English digits.
    func inEnglishDigits() -> StrictString

    // [_Define Documentation: SDGCornerstone.Year.inDeutschenZiffern()_]
    /// Gibt das Jahr in deutschen Ziffern zurück.
    func inDeutschenZiffern() -> StrictString

    // [_Define Documentation: SDGCornerstone.Year.enChiffresFrançais()_]
    /// Retourne l’an en chiffres français.
    func enChiffresFrançais() -> StrictString

    // [_Define Documentation: SDGCornerstone.Year.σεΕλληνικάΨηφία()_]
    /// Επιστρέφει τον χρόνο στα ελληνικά ψηφία.
    func σεΕλληνικάΨηφία() -> StrictString

    // [_Define Documentation: SDGCornerstone.Year.בעברית־בספרות()_]
    /// מחזירה את השנה בעברית ובספרות.
    func בעברית־בספרות() -> StrictString
}
