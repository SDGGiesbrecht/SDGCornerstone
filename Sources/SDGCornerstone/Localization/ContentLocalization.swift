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

    internal static let macrolanguages = [
        // [_Define Example: Macrolanguages_]
        "zh": ["cmn"],
        "ar": ["arb"],
        "no": ["nb"],
        "ms": ["zsm"]
        // [_End_]
    ]

    internal static let groups: [String: [(script: String, countries: [String])]] = [
        // [_Define Example: Localization Groups_]
        "cmn": [
            ("Hans", ["CN", "SG"]),
            ("Hant", ["TW"])],
        "es": [("Latn", ["ES", "419", "MX", "CO", "AR", "VE", "PE", "CL", "EC", "CU", "DO", "GT", "HN", "SV", "NI", "BO", "CR", "UY", "PA", "PY", "GQ"])],
        "en": [("Latn", ["GB", "US", "CA", "AU", "ZA", "IE", "NL", "SG", "TT", "GY", "LR", "SL", "MY", "BB", "BS", "ZW", "IN", "BZ", "PG", "VC", "ZM", "GD", "AG", "VU", "JM", "KN", "LK", "PH", "LC", "NA", "BN", "SB", "NR", "FJ", "FM", "DM", "SC", "MU", "WS", "PW", "MW", "BW", "BI", "CM", "ET", "GM", "GH", "KE", "KI", "LS", "MT", "MH", "NG", "PK", "RW", "SS", "SD", "SZ", "TZ", "TO", "TV", "UG"])],
        "arb": [("Arab", ["SA", "EG", "DZ", "SD", "MA", "IQ", "SY", "YE", "TN", "JO", "LY", "LB", "SO", "AE", "MR", "OM", "IL", "KW", "TD", "QA", "BH", "DJ", "KM"])],
        "pt": [("Latn", ["PT", "BR", "AO", "MZ", "ST", "TL", "CV", "GQ", "GW"])],
        "ru": [("Cyrl", ["RU", "BY", "KZ", "KG"])],
        "ja": [("Jpan", ["JP"])],
        "de": [("Latn", ["DE", "AT", "CH", "BE", "LI", "LU"])],
        "vi": [("Latn", ["VN"])],
        "ko": [("Kore", ["KR", "KP"])],
        "fr": [("Latn", ["FR", "CA", "BE", "CH", "BF", "LU", "SN", "MU", "GA", "CG", "MG", "CI", "BJ", "MC", "DJ", "CF", "ML", "NE", "TD", "TG", "RW", "BI", "KM", "VU", "SC", "CM", "CD", "GN", "GQ", "HT"])],
        "tr": [("Latn", ["TR", "CY"])],
        "it": [("Latn", ["IT", "CH", "SM", "VA"])],
        "pl": [("Latn", ["PL"])],
        "uk": [("Cyrl", ["UA"])],
        "nl": [("Latn", ["NL", "BE", "SR"])],
        "zsm": [("Latn", ["MY", "SG", "BN"])],
        "ro": [("Latn", ["RO", "MD"])],
        "th": [("Thai", ["TH"])],
        "el": [("Grek", ["GR", "CY"])],
        "cs": [("Latn", ["CZ"])],
        "hu": [("Latn", ["HU"])],
        "sv": [("Latn", ["SE", "FI"])],
        "id": [("Latn", ["ID"])],
        "da": [("Latn", ["DK"])],
        "fi": [("Latn", ["FI"])],
        "sk": [("Latn", ["SK"])],
        "he": [("Hebr", ["IL"])],
        "nb": [("Latn", ["NO"])],
        "hr": [("Latn", ["HR"])],
        "ca": [("Latn", ["ES", "AD"])]
        // [_End_]
    ]

    internal static let macrolanguageMembership: [String: String] = {
        var result: [String: String] = [:]
        for (macrolanguage, languages) in macrolanguages {
            for language in languages {
                result[language] = macrolanguage
            }
        }
        return result
    }()

    // MARK: - Localization

    internal static let fallbackLocalization: ContentLocalization = .עברית־ישראל
}
