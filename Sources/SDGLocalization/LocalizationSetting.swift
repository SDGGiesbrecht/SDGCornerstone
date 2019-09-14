/*
 LocalizationSetting.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGPersistence

/// A localization setting describing a list of preferred localizations and their order of precedence.
public struct LocalizationSetting : Decodable, Encodable, Equatable {

    // MARK: - Static Properties

    private static let sdgDomainSuffix = ".Language"
    private static let languageDomain = PreferenceSet._sdgCornerstoneDomain + sdgDomainSuffix
    #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
    private static let osPreferenceKey = "AppleLanguages"
    #endif
    private static let sdgPreferenceKey = "SDGLanguages" // In application domain too.
    private static let stabilityCacheKey = "StabilityCache" // SDGCornerstone domain only.

    internal static let osSystemWidePreferences: Shared<Preference> = {
        let preferences: Shared<Preference>
        #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

        preferences = PreferenceSet.preferences(for: UserDefaults.globalDomain)[osPreferenceKey]

        #elseif os(Linux)

        preferences = Shared(Preference.mock())

        func convert(locale: String) -> String {
            return locale.replacingOccurrences(of: "_", with: "\u{2D}")
        }

        if let languages = ProcessInfo.processInfo.environment["LANGUAGE"] {
            let entryMatches: [PatternMatch<String>] = languages.components(separatedBy: ":")
            let converted = entryMatches.map { convert(locale: String($0.contents)) }
            preferences.value.set(to: converted)
        } else if let language = ProcessInfo.processInfo.environment["LANG"],
            let locale: PatternMatch<String> = language.prefix(upTo: ".") {
            let converted = convert(locale: String(locale.contents)) // @exempt(from: tests)
            preferences.value.set(to: [converted])
        } else {
            preferences.value.set(to: nil)
        }

        #endif

        preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
        return preferences
    }()

    private static let sdgSystemWidePreferences: Shared<Preference> = {
        let preferences = PreferenceSet.preferences(for: LocalizationSetting.languageDomain)[sdgPreferenceKey]
        preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
        return preferences
    }()

    private static let osApplicationPreferences: Shared<Preference> = {
        guard ProcessInfo.possibleApplicationIdentifier ≠ nil else {
            return Shared(Preference.mock()) // @exempt(from: tests)
        }

        let preferences: Shared<Preference>
        #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

        preferences = PreferenceSet.applicationPreferences[osPreferenceKey]

        #elseif os(Linux)

        // This is does not exist on Linux anyway.
        preferences = Shared(Preference.mock())

        #endif

        preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
        return preferences
    }()

    private static let sdgApplicationPreferences: Shared<Preference> = {
        guard let applicationDomain = ProcessInfo.possibleApplicationIdentifier else {
            return Shared(Preference.mock()) // @exempt(from: tests)
        }
        let preferences = PreferenceSet.preferences(for: applicationDomain + sdgDomainSuffix)[sdgPreferenceKey]
        preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
        return preferences
    }()

    private static let overrides: Shared<[LocalizationSetting]> = {
        let overrides: Shared<[LocalizationSetting]> = Shared([])
        overrides.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
        return overrides
    }()

    private static func resolveCurrentLocalization() -> LocalizationSetting {
        return overrides.value.last
            ?? sdgApplicationPreferences.value.as(LocalizationSetting.self)
            ?? LocalizationSetting(osPreference: osApplicationPreferences.value)
            ?? sdgSystemWidePreferences.value.as(LocalizationSetting.self)
            ?? LocalizationSetting(osPreference: osSystemWidePreferences.value)
            ?? LocalizationSetting(orderOfPrecedence: [] as [[String]]) // @exempt(from: tests)
    }

    private class ChangeObserver : SharedValueObserver {
        fileprivate static let defaultObserver = ChangeObserver()
        fileprivate func valueChanged(for identifier: String) {

            let new = LocalizationSetting.resolveCurrentLocalization()
            if current.value ≠ new {
                current.value = new
            }
        }
    }

    /// The current localization setting.
    ///
    /// - Note: The value of the shared instance is intended to be read‐only.
    public static let current: Shared<LocalizationSetting> = {
        let result = Shared(resolveCurrentLocalization())
        result.register(observer: ChangeObserver(), reportInitialState: false)
        return result
    }()

    // MARK: - Static Methods

    // For user available menus.
    public static func _setSystemWidePreferences(to setting: LocalizationSetting?) {
        sdgSystemWidePreferences.value.set(to: setting)
    }
    internal static func setSystemWidePreferences(to setting: LocalizationSetting?) {
        _setSystemWidePreferences(to: setting)
    }

    /// Sets the application‐specific language preferences to the specified settings.
    ///
    /// This should only be used when the changes both:
    ///   - need to be remembered the next time the application is launched, and
    ///   - are at the direct request of the user.
    ///
    /// Otherwise, use `do(_:)` instead.
    ///
    /// - Parameters:
    ///     - setting: The new localization setting.
    public static func setApplicationPreferences(to setting: LocalizationSetting?) {
        _ = ProcessInfo.applicationIdentifier // Make sure this was set and it is not just a silent mock preference.

        sdgApplicationPreferences.value.set(to: setting)

        if let preferences = setting {
            var flattened: [String] = []
            for group in preferences.orderOfPrecedence {
                flattened.append(contentsOf: group.shuffled())
            }
            osApplicationPreferences.value.set(to: flattened)
        } else {
            osApplicationPreferences.value.set(to: nil)
        }
    }

    // MARK: - Initialization

    /// Creates a localization setting from a list of precedence groups.
    ///
    /// - Parameters:
    ///     - orderOfPrecedence: An array of precedence groups. The outer array represents the order of precedence. Each inner array represents a group of localizations with equal precedence. Within a specific group, localizations will be mixed and matched at random. Each string must be an [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) representing a desired localization.
    public init(orderOfPrecedence: [[String]]) {
        self.orderOfPrecedence = orderOfPrecedence
    }

    /// Creates a localization setting from a precedence list.
    ///
    /// - Parameters:
    ///     - orderOfPrecedence: An array of localizations describing there order of precedence. Each string must be an [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) representing a desired localization.
    public init(orderOfPrecedence: [String]) {
        self.orderOfPrecedence = orderOfPrecedence.map { [$0] }
    }

    private init?(osPreference preference: Preference) {
        guard let result = preference.as([String].self) else {
            return nil
        }
        self.init(orderOfPrecedence: result)
    }

    // MARK: - Properties

    private let orderOfPrecedence: [[String]]

    // MARK: - Usage

    /// Executes the closure under the localization settings described by `self`.
    ///
    /// - Parameters:
    ///     - closure: The closure to execute.
    public func `do`(_ closure: () throws -> Void) rethrows {
        LocalizationSetting.overrides.value.append(self)
        defer { LocalizationSetting.overrides.value.removeLast() }

        try closure()
    }

    private func resolvedFresh<L : Localization>() -> L {
        for group in orderOfPrecedence {
            for localization in group.shuffled() {
                if let result = L(reasonableMatchFor: localization) {
                    return result
                }
            }
        }
        return L.fallbackLocalization
    }

    private static func stabilizationCacheKey<L>(for: L.Type) -> String {
        return LocalizationSetting.stabilityCacheKey + ".\(type(of: L.self))"
    }

    /// Returns the preferred localization out of those supported by the type `L`.
    ///
    /// - Parameters:
    ///     - stabilization: The stabilization mode.
    public func resolved<L : Localization>(stabilization: StabilizationMode = .none) -> L {
        switch stabilization {
        case .none:
            return resolvedFresh()
        case .stabilized:
            let preferences = PreferenceSet.preferences(for: LocalizationSetting.languageDomain)
            let key = LocalizationSetting.stabilizationCacheKey(for: L.self)
            print(key)
            var cache: CachedLocalization<L>? {
                get {
                    return preferences[key].value.as(CachedLocalization<L>.self)
                }
                set {
                    preferences[key].value.set(to: newValue)
                }
            }
            let container = cached(in: &cache) {
                return CachedLocalization<L>(
                    localization: resolvedFresh(),
                    date: Date() + 24 /*h*/ × 60 /*m*/ × 60 /*s*/)
            }
            return container.localization
        }
    }

    internal static func resetStabilization<L>(for: L.Type) {
        let preferences = PreferenceSet.preferences(for: LocalizationSetting.languageDomain)
        let key = stabilizationCacheKey(for: L.self)
        preferences[key].value.set(to: nil)
    }

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: [[String]].self, convert: { LocalizationSetting(orderOfPrecedence: $0) })
    }

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: orderOfPrecedence)
    }

    // MARK: - Equatable

    public static func == (precedingValue: LocalizationSetting, followingValue: LocalizationSetting) -> Bool {
        return precedingValue.orderOfPrecedence.elementsEqual(followingValue.orderOfPrecedence) { (leftGroup: [String], rightGroup: [String]) -> Bool in
            return Set(leftGroup) == Set(rightGroup)
        }
    }
}
