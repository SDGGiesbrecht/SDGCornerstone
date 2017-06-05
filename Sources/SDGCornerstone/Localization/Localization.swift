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

    // [_Example 1: Localization Groups_]
    /// Creates a localization from the specified code, or as a fallback, creates a related localization that can be reasonably used as a replacement.
    ///
    /// For example, if a type supports British but not American English, it creates an instance of British English when either code is specified.
    ///
    /// The full list of currently supported groups of related localizations is as follows (taken directly from the source code):
    ///
    /// ```swift
    /// "en": ["GB", "US", "CA", "AU", "ZA", "IE", "NL", "SG", "TT", "GY", "LR", "SL", "MY", "BB", "BS", "ZW", "IN", "BZ", "PG", "VC", "ZM", "GD", "AG", "VU", "JM", "KN", "LK", "PH", "LC", "NA", "BN", "SB", "NR", "FJ", "FM", "DM", "SC", "MU", "WS", "PW", "MW", "BW", "BI", "CM", "ET", "GM", "GH", "KE", "KI", "LS", "MT", "MH", "NG", "PK", "RW", "SS", "SD", "SZ", "TZ", "TO", "TV", "UG"],
    /// "de": ["DE", "AT", "CH", "BE", "LI", "LU"],
    /// "fr": ["FR", "CA", "BE", "CH", "BF", "SN", "LU", "MU", "GA", "CG", "MG", "CI", "BJ", "MC", "DJ", "CF", "ML", "NE", "TD", "TG", "RW", "BI", "KM", "VU", "SC", "CM", "CD", "GN", "GQ", "HT"],
    /// "el": ["GR", "CY"],
    /// "he": ["IL"]
    /// ```
    ///
    /// Requests for additional groups are welcome and can be made by [opening a Github issue](https://github.com/SDGGiesbrecht/SDGCornerstone/issues).
    public init?(reasonableMatchFor code: String) {

        let language = String(code.scalars.truncated(before: "\u{2D}".scalars))
        if let result = Self(exactly: language) {
            self = result
            return
        }
        if let relevantCountries = ContentLocalization.countries[language] {
            for country in relevantCountries {
                if let result = Self(exactly: language + "\u{2D}" + country) {
                    self = result
                    return
                }
            }
        }

        return nil
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
