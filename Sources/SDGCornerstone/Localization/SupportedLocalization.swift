/*
 SupportedLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal enum SupportedLocalization : String, Localization {

    // MARK: - Cases

    case englishUnitedKingdom = "en\u{2D}GB"
    case englishUnitedStates = "en\u{2D}US"
    case englishCanada = "en\u{2D}CA"

    case deutschDeutschland = "de\u{2D}DE"

    case françaisFrance = "fr\u{2D}FR"

    case ελληνικάΕλλάδα = "el\u{2D}GR"

    case עברית־ישראל = "he\u{2D}IL"

    internal static let countries = [ // For algorithmic fallback.
        "en": ["GB", "US", "CA", "AU", "ZA", "IE", "NL", "SG", "TT", "GY", "SL", "MY", "IN", "BB", "BS", "ZW", "BZ", "PG", "ZM", "AG", "NA", "BW", "MH", "PH", "WS", "MT", "MW", "PK", "DM", "SB", "BN", "LK", "SZ", "FJ", "MU", "SC", "FM", "PW", "VU", "ET", "LC", "TO", "GM", "GD", "NR", "KI", "VC", "KN", "NG", "TZ", "KE", "SD", "UG", "GH", "CM", "SS", "RW", "BI", "LR", "JM", "LS", "TV"],
        "de": ["DE", "BE", "LU", "AT", "CH", "LI"],
        "fr": ["FR", "CA", "BE", "CH", "BF", "LU", "SN", "GA", "MG", "CI", "DJ", "BJ", "MC", "ML", "CG", "CF", "VU", "NE", "RW", "TD", "TG", "KM", "BI", "SC", "HT", "CD", "CM", "GN", "GQ"],
        "el": ["GR", "CY"],
        "he": ["IL"]
    ]

    // MARK: - Localization

    internal static let fallbackLocalization: SupportedLocalization = .עברית־ישראל
}
