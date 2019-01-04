/*
 Localization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

/// An enumeration that describes the set of localizations available for a particular usage.
///
/// Conformance Requirements:
///   - `RawRepresentable` with raw values that correspond to [IETF language tags](https://en.wikipedia.org/wiki/IETF_language_tag), or both of the following:
///     - `init?(code: String)`, and
///     - `var code: String { get }`
///   - `static var developmentLocalization: Self { get }`
public protocol Localization : TextualPlaygroundDisplay {

    // @documentation(SDGCornerstone.Localization.init(code:))
    /// Creates an instance from an [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
    ///
    /// This initializer does not attempt to resolve to a related localization. i.e. A request for Australian English prefers failure over the creation of an instance of British English. (Where such resolution is desired, use `init(reasonableMatchFor:)` instead.)
    init?(exactly code: String)

    // @documentation(SDGCornerstone.Localization.code)
    /// The corresponding [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
    var code: String { get }

    // @documentation(SDGCornerstone.Localization.fallbackLocalization)
    /// The localization to use whenever none of the localizations requested by the user are available.
    static var fallbackLocalization: Self { get }
}

extension Localization {

    // #example(1, macrolanguages) #example(2, localizationGroups)
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
    /// "en": [("Latn", ["GB", "US", "CA", "AU", "ZA", "IE", "NZ", "SG", "TT", "GY", "LR", "SL", "MY", "BB", "BS", "ZW", "IN", "BZ", "PG", "VC", "ZM", "GD", "AG", "VU", "JM", "KN", "LK", "PH", "LC", "NA", "BN", "SB", "NR", "FJ", "FM", "DM", "SC", "MU", "WS", "PW", "MW", "BW", "BI", "CM", "ET", "GM", "GH", "KE", "KI", "LS", "MT", "MH", "NG", "PK", "RW", "SS", "SD", "SZ", "TZ", "TO", "TV", "UG"])],
    /// "arb": [("Arab", ["SA", "EG", "DZ", "SD", "MA", "IQ", "SY", "YE", "TN", "JO", "LY", "LB", "SO", "AE", "MR", "OM", "IL", "KW", "TD", "QA", "BH", "DJ", "KM"])],
    /// "hi": [("Deva", ["IN"])],
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

    internal init?(reasonableMatchFor code: String, skippingParents: Bool) {

        if let result = Self(exactly: code) {
            self = result
            return
        }

        let originalTags: [String] = code.components(separatedBy: "\u{2D}")
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
                if possibleCountry ≠ nil { // @exempt(from: tests)
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

    /// The native text direction of the localization, if known.
    public var textDirection: TextDirection? {
        return ContentLocalization(reasonableMatchFor: code)?.language.textDirection
    }

    /// Creates a localization from an icon.
    ///
    /// - SeeAlso: `icon`
    public init?(icon: StrictString) {
        if let recognized = ContentLocalization(definedIcon: icon) {
            self.init(reasonableMatchFor: recognized.code)
        } else {
            return nil
        }
    }

    /// An icon representing the localization suitable for buttons or links that switch languages.
    ///
    /// The icon consists of a flag and an abbreviation for the language endonym. (e.g. 🇬🇧EN, 🇺🇸EN, 🇬🇷ΕΛ)
    ///
    /// For localizations not directly supported by SDGCornerstone, this property may be `nil`.
    public var icon: StrictString? {
        return ContentLocalization(reasonableMatchFor: code)?.definedIcon
    }

    /// Returns the code corresponding to the specified icon.
    ///
    /// Use this to convert abritrary, user‐provided codes, even when they are not directly supported by the application.
    public static func code(for icon: StrictString) -> String? {
        return ContentLocalization(icon: icon)?.code
    }

    /// Returns the icon corresponding to the specified code.
    ///
    /// Use this to convert abritrary, user‐provided icons, even when they are not directly supported by the application.
    public static func icon(for code: String) -> StrictString? {
        return ContentLocalization(reasonableMatchFor: code)?.icon
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    public var description: String {
        guard let contentLocalization = ContentLocalization(exactly: code) else {
            return code
        }
        return String(contentLocalization.localizedIsolatedName())
    }
}

extension Localization where Self : RawRepresentable, Self.RawValue == String {

    // #documentation(SDGCornerstone.Localization.init(code:))
    /// Creates an instance from an [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
    ///
    /// This initializer does not attempt to resolve to a related localization. i.e. A request for Australian English prefers failure over the creation of an instance of British English. (Where such resolution is desired, use `init(reasonableMatchFor:)` instead.)
    @inlinable public init?(exactly code: String) {
        self.init(rawValue: code)
    }

    // #documentation(SDGCornerstone.Localization.code)
    /// The corresponding [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
    @inlinable public var code: String {
        return rawValue
    }
}
