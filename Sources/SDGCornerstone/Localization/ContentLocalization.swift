/*
 ContentLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal enum ContentLocalization : String, Localization {

    // MARK: - Cases

    case englishUnitedKingdom = "en\u{2D}GB"
    case englishUnitedStates = "en\u{2D}US"
    case englishCanada = "en\u{2D}CA"

    case deutschDeutschland = "de\u{2D}DE"

    case françaisFrance = "fr\u{2D}FR"

    case ελληνικάΕλλάδα = "el\u{2D}GR"

    case עברית־ישראל = "he\u{2D}IL"

    internal static let cases: [ContentLocalization] = [

        .englishUnitedKingdom,
        .englishUnitedStates,
        .englishCanada,

        .deutschDeutschland,

        .françaisFrance,

        .ελληνικάΕλλάδα,

        .עברית־ישראל
    ]

    // MARK: - Localization

    internal static let fallbackLocalization: ContentLocalization = .עברית־ישראל
}
