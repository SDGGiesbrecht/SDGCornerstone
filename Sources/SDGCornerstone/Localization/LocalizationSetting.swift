/*
 LocalizationSetting.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A localization setting describing a list of preferred localizations and their order of precedence.
public struct LocalizationSetting : Equatable {

    // MARK: - Static Properties

    private static let sdgDomainSuffix = ".Language"
    #if !os(Linux)
    private static let osPreferenceKey = "AppleLanguages"
    #endif
    private static let sdgPreferenceKey = "SDGLanguages"

    internal static let osSystemWidePreferences: Shared<PropertyListValue?> = {
        let preferences: Shared<PropertyListValue?>
        #if os(Linux)

            if let languages = ProcessInfo.processInfo.environment["LANGUAGE"] {
                let entries = languages.components(separatedBy: ":")
                let converted = entries.map() { $0.replacingOccurrences(of: "_", with: "\u{2D}") }
                preferences = Shared<PropertyListValue?>(converted)
            } else {
                preferences = Shared<PropertyListValue?>(nil)
            }

        #else

            preferences = Preferences.preferences(for: UserDefaults.globalDomain)[osPreferenceKey]

        #endif

        preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
        return preferences
    }()

    private static let sdgSystemWidePreferences: Shared<PropertyListValue?> = {
        let preferences = Preferences.preferences(for: Preferences.sdgCornerstoneDomain + sdgDomainSuffix)[sdgPreferenceKey]
        preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
        return preferences
    }()

    private static let osApplicationPreferences: Shared<PropertyListValue?> = {
        let preferences: Shared<PropertyListValue?>
        #if os(Linux)

            // This is does not exist on Linux anyway.
            preferences = Shared<PropertyListValue?>(nil)

        #else

            preferences = Preferences.applicationPreferences[osPreferenceKey]

        #endif

        preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
        return preferences
    }()

    private static let sdgApplicationPreferences: Shared<PropertyListValue?> = {
        let preferences = Preferences.preferences(for: Application.current.domain + sdgDomainSuffix)[sdgPreferenceKey]
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
            ?? LocalizationSetting(sdgPreference: sdgApplicationPreferences.value)
            ?? LocalizationSetting(osPreference: osApplicationPreferences.value)
            ?? LocalizationSetting(sdgPreference: sdgSystemWidePreferences.value)
            ?? LocalizationSetting(osPreference: osSystemWidePreferences.value)
            ?? LocalizationSetting(orderOfPrecedence: [] as [[String]]) // [_Exempt from Code Coverage_]
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

    /// :nodoc:
    public static func internalUseSetSystemWidePreferences(to setting: LocalizationSetting?) {
        sdgSystemWidePreferences.value = setting?.orderOfPrecedence
    }

    /// Sets the application‐specific language preferences to the specified settings.
    ///
    /// This should only be used when the changes both:
    ///   - need to be remembered the next time the application is launched, and
    ///   - are at the direct request of the user.
    ///
    /// Otherwise, use `do(_:)` instead.
    public static func setApplicationPreferences(to setting: LocalizationSetting?) {

        sdgApplicationPreferences.value = setting?.orderOfPrecedence

        if let preferences = setting {
            var flattened: [String] = []
            for group in preferences.orderOfPrecedence {
                flattened.append(contentsOf: group.shuffled())
            }
            osApplicationPreferences.value = flattened
        } else {
            osApplicationPreferences.value = nil
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
        self.orderOfPrecedence = orderOfPrecedence.map() { [$0] }
    }

    private init?(osPreference preference: PropertyListValue?) {
        guard let result = preference?.asArray(of: String.self) else {
            return nil
        }
        self.init(orderOfPrecedence: result)
    }

    private init?(sdgPreference preference: PropertyListValue?) {
        guard let result = preference?.asArray(of: [String].self) else {
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

    /// Returns the preferred localization out of those supported by the type `L`.
    public func resolved<L : Localization>() -> L {
        for group in orderOfPrecedence {
            for localization in group.shuffled() {
                if let result = L(reasonableMatchFor: localization) {
                    return result
                }
            }
        }
        return L.fallbackLocalization
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: LocalizationSetting, rhs: LocalizationSetting) -> Bool {
        return lhs.orderOfPrecedence.elementsEqual(rhs.orderOfPrecedence) { (leftGroup: [String], rightGroup: [String]) -> Bool in
            return Set(leftGroup) == Set(rightGroup)
        }
    }
}
