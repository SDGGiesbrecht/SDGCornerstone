/*
 FormatLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// :nodoc:
public enum _FormatLocalization : String, InputLocalization {

    // MARK: - Cases

    /// :nodoc:
    case englishUnitedKingdom = "en\u{2D}GB"
    /// :nodoc:
    case englishUnitedStates = "en\u{2D}US"
    /// :nodoc:
    case englishCanada = "en\u{2D}CA"

    /// :nodoc:
    case deutschDeutschland = "de\u{2D}DE"

    /// :nodoc:
    case françaisFrance = "fr\u{2D}FR"

    /// :nodoc:
    case ελληνικάΕλλάδα = "el\u{2D}GR"

    /// :nodoc:
    case עברית־ישראל = "he\u{2D}IL"

    /// :nodoc:
    public static let cases: [_FormatLocalization] = [

        .englishUnitedKingdom,
        .englishUnitedStates,
        .englishCanada,

        .deutschDeutschland,

        .françaisFrance,

        .ελληνικάΕλλάδα,

        .עברית־ישראל
    ]

    // MARK: - Localization

    /// :nodoc:
    public static let fallbackLocalization: _FormatLocalization = .עברית־ישראל
}
