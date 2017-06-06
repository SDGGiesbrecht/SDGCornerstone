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

    internal static let countries = [
        // [_Define Example: Localization Groups_]
        "es": ["ES", "MX", "CO", "AR", "VE", "PE", "CL", "EC", "CU", "DO", "GT", "HN", "SV", "NI", "BO", "CR", "UY", "PA", "PY", "GQ"],
        "en": ["GB", "US", "CA", "AU", "ZA", "IE", "NL", "SG", "TT", "GY", "LR", "SL", "MY", "BB", "BS", "ZW", "IN", "BZ", "PG", "VC", "ZM", "GD", "AG", "VU", "JM", "KN", "LK", "PH", "LC", "NA", "BN", "SB", "NR", "FJ", "FM", "DM", "SC", "MU", "WS", "PW", "MW", "BW", "BI", "CM", "ET", "GM", "GH", "KE", "KI", "LS", "MT", "MH", "NG", "PK", "RW", "SS", "SD", "SZ", "TZ", "TO", "TV", "UG"],
        "de": ["DE", "AT", "CH", "BE", "LI", "LU"],
        "fr": ["FR", "CA", "BE", "CH", "BF", "SN", "LU", "MU", "GA", "CG", "MG", "CI", "BJ", "MC", "DJ", "CF", "ML", "NE", "TD", "TG", "RW", "BI", "KM", "VU", "SC", "CM", "CD", "GN", "GQ", "HT"],
        "el": ["GR", "CY"],
        "he": ["IL"]
        // [_End_]
    ]

    // MARK: - Localization

    internal static let fallbackLocalization: ContentLocalization = .עברית־ישראל
}
