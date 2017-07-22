/*
 Localization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An enumeration that describes the set of localizations available for a particular usage.
///
/// Conformance Requirements:
///   - `RawRepresentable` with raw values that correspond to [IETF language tags](https://en.wikipedia.org/wiki/IETF_language_tag), or both of the following:
///     - `init?(code: String)`, and
///     - `var code: String { get }`
///   - `static var developmentLocalization: Self { get }`
public protocol Localization {

    // [_Define Documentation: SDGCornerstone.Localization.init(code:)_]
    /// Creates an instance from an [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
    ///
    /// This initializer does not attempt to resolve to a related localization. i.e. A request for Australian English prefers failure over the creation of an instance of British English. (Where such resolution is desired, use `init(reasonableMatchFor:)` instead.)
    init?(exactly code: String)

    // [_Define Documentation: SDGCornerstone.Localization.code_]
    /// The corresponding [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
    var code: String { get }

    // [_Define Documentation: SDGCornerstone.Localization.developmentLocalization_]
    /// The localization to use whenever none of the localizations requested by the user are available.
    static var fallbackLocalization: Self { get }
}

extension Localization {

    // [_Example 1: Macrolanguages_] [_Example 2: Localization Groups_]
    /// Creates a localization from the specified code, or as a fallback, creates a related localization that can be reasonably used as a replacement.
    ///
    /// For example, if a type supports British but not American English, it creates an instance of British English when either code is specified.
    ///
    /// The full list of currently supported groups of related localizations is as follows (taken directly from the source code):
    ///
    /// ```swift
    /// "zh": ["cmn"],
    /// "ar": ["arb"],
    /// "no": ["nb"],
    /// "ms": ["zsm"]
    /// ```
    ///
    /// ```swift
    /// "cmn": [
    ///     ("Hans", ["CN", "SG"]),
    ///     ("Hant", ["TW"])],
    /// "es": [("Latn", ["ES", "419", "MX", "CO", "AR", "VE", "PE", "CL", "EC", "CU", "DO", "GT", "HN", "SV", "NI", "BO", "CR", "UY", "PA", "PY", "GQ"])],
    /// "en": [("Latn", ["GB", "US", "CA", "AU", "ZA", "IE", "NL", "SG", "TT", "GY", "LR", "SL", "MY", "BB", "BS", "ZW", "IN", "BZ", "PG", "VC", "ZM", "GD", "AG", "VU", "JM", "KN", "LK", "PH", "LC", "NA", "BN", "SB", "NR", "FJ", "FM", "DM", "SC", "MU", "WS", "PW", "MW", "BW", "BI", "CM", "ET", "GM", "GH", "KE", "KI", "LS", "MT", "MH", "NG", "PK", "RW", "SS", "SD", "SZ", "TZ", "TO", "TV", "UG"])],
    /// "arb": [("Arab", ["SA", "EG", "DZ", "SD", "MA", "IQ", "SY", "YE", "TN", "JO", "LY", "LB", "SO", "AE", "MR", "OM", "IL", "KW", "TD", "QA", "BH", "DJ", "KM"])],
    /// "pt": [("Latn", ["PT", "BR", "AO", "MZ", "ST", "TL", "CV", "GQ", "GW"])],
    /// "ru": [("Cyrl", ["RU", "BY", "KZ", "KG"])],
    /// "ja": [("Jpan", ["JP"])],
    /// "de": [("Latn", ["DE", "AT", "CH", "BE", "LI", "LU"])],
    /// "vi": [("Latn", ["VN"])],
    /// "ko": [("Kore", ["KR", "KP"])],
    /// "fr": [("Latn", ["FR", "CA", "BE", "CH", "BF", "LU", "SN", "MU", "GA", "CG", "MG", "CI", "BJ", "MC", "DJ", "CF", "ML", "NE", "TD", "TG", "RW", "BI", "KM", "VU", "SC", "CM", "CD", "GN", "GQ", "HT"])],
    /// "tr": [("Latn", ["TR", "CY"])],
    /// "it": [("Latn", ["IT", "CH", "SM", "VA"])],
    /// "pl": [("Latn", ["PL"])],
    /// "uk": [("Cyrl", ["UA"])],
    /// "nl": [("Latn", ["NL", "BE", "SR"])],
    /// "zsm": [("Latn", ["MY", "SG", "BN"])],
    /// "ro": [("Latn", ["RO", "MD"])],
    /// "th": [("Thai", ["TH"])],
    /// "el": [("Grek", ["GR", "CY"])],
    /// "cs": [("Latn", ["CZ"])],
    /// "hu": [("Latn", ["HU"])],
    /// "sv": [("Latn", ["SE", "FI"])],
    /// "id": [("Latn", ["ID"])],
    /// "da": [("Latn", ["DK"])],
    /// "fi": [("Latn", ["FI"])],
    /// "sk": [("Latn", ["SK"])],
    /// "he": [("Hebr", ["IL"])],
    /// "nb": [("Latn", ["NO"])],
    /// "hr": [("Latn", ["HR"])],
    /// "ca": [("Latn", ["ES", "AD"])]
    /// ```
    ///
    /// Requests for additional groups are welcome and can be made by [opening a Github issue](https://github.com/SDGGiesbrecht/SDGCornerstone/issues).
    public init?(reasonableMatchFor code: String) {
        if let result = Self(reasonableMatchFor: code, skippingParents: false) {
            self = result
        } else {
            return nil
        }
    }

    private init?(reasonableMatchFor code: String, skippingParents: Bool) {

        if let result = Self(exactly: code) {
            self = result
            return
        }

        let originalTags = code.components(separatedBy: "\u{2D}")
        var processingTags = originalTags

        let language = processingTags.removeFirst()

        var possibleScript: String?
        if processingTags.first?.scalars.count == 4 {
            possibleScript = processingTags.removeFirst()
        }

        var possibleCountry: String?
        if processingTags.first ≠ nil {
            possibleCountry = processingTags.removeFirst()
        }

        if let scripts = ContentLocalization.groups[language] {

            if let script = possibleScript {
                if possibleCountry ≠ nil { // [_Exempt from Code Coverage_]
                    // language‐script‐country

                    // Already covered by exact match.
                } else {
                    // language‐script

                    if let countries = scripts.first(where: {$0.script == script})?.countries {
                        for country in countries {
                            if let result = Self(exactly: [language, script, country].joined(separator: "\u{2D}")) {
                                self = result
                                return
                            }
                        }
                    }
                }
            } else {
                if let country = possibleCountry {
                    // language‐country

                    for entry in scripts where entry.countries.contains(country) {
                        if let result = Self(exactly: [language, entry.script, country].joined(separator: "\u{2D}")) {
                            self = result
                            return
                        }
                    }
                } else {
                    // language

                    for entry in scripts {
                        for country in entry.countries {
                            if let result = Self(reasonableMatchFor: [language, entry.script].joined(separator: "\u{2D}"), skippingParents: true) {
                                self = result
                                return
                            }
                            if let result = Self(reasonableMatchFor: [language, country].joined(separator: "\u{2D}"), skippingParents: true) {
                                self = result
                                return
                            }
                        }
                    }
                }
            }
        }

        if let members = ContentLocalization.macrolanguages[language] {
            for member in members {
                var alteredTags = originalTags
                alteredTags[0] = member
                if let result = Self(reasonableMatchFor: alteredTags.joined(separator: "\u{2D}"), skippingParents: true) {
                    self = result
                    return
                }
            }
        }

        if ¬skippingParents {
            if language ≠ code {
                let moreGeneral = originalTags.dropLast().joined(separator: "\u{2D}")
                if let result = Self(reasonableMatchFor: moreGeneral, skippingParents: false) {
                    self = result
                    return
                }
            } else {
                if let macrolanguage = ContentLocalization.macrolanguageMembership[language] {
                    var alteredTags = originalTags
                    alteredTags[0] = macrolanguage
                    if let result = Self(reasonableMatchFor: alteredTags.joined(separator: "\u{2D}"), skippingParents: false) {
                        self = result
                        return
                    }
                }
            }
        }

        return nil
    }

    /// An icon representing the localization suitable for buttons or links that switch languages.
    ///
    /// The icon consists of a flag and an abbreviation for the language endonym. (e.g. 🇬🇧EN, 🇺🇸EN, 🇬🇷ΕΛ)
    ///
    /// For localizations SDGCornerstone does not provide content in, this property is `nil`.
    public var icon: StrictString? {
        return ContentLocalization(reasonableMatchFor: code)?.definedIcon
    }
}

extension Localization where Self : RawRepresentable, Self.RawValue == String {
    // MARK: - where Self : RawRepresentable, Self.RawValue == String

    // [_Inherit Documentation: SDGCornerstone.Localization.init(code:)_]
    /// Creates an instance from an [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
    ///
    /// This initializer does not attempt to resolve to a related localization. i.e. A request for Australian English prefers failure over the creation of an instance of British English. (Where such resolution is desired, use `init(reasonableMatchFor:)` instead.)
    public init?(exactly code: String) {
        self.init(rawValue: code)
    }

    // [_Inherit Documentation: SDGCornerstone.Localization.code_]
    /// The corresponding [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
    public var code: String {
        return rawValue
    }
}
