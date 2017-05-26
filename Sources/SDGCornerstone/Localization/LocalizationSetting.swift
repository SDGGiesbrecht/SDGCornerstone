/*
 LocalizationSetting.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A localization setting describing a list of preferred localizations and their order of precedence.
public struct LocalizationSetting : Equatable {

    // MARK: - Static Methods

    private static let systemPreferences: Shared<LocalizationSetting> = {
        // [_Warning: This needs to actually look it up._]
        let preferences = Shared(LocalizationSetting(orderOfPrecedence: [] as [String]))

        preferences.register(observer: ChangeObserver.defaultObserver)
        return preferences
    }()

    private static let sdgPreferences: Shared<LocalizationSetting?> = {
        // [_Warning: This needs to actually look it up._]
        let preferences = Shared<LocalizationSetting?>(nil)

        preferences.register(observer: ChangeObserver.defaultObserver)
        return preferences
    }()

    private static let applicationPreferences: Shared<LocalizationSetting?> = {
        // [_Warning: This needs to actually look it up._]
        let preferences = Shared<LocalizationSetting?>(nil)

        preferences.register(observer: ChangeObserver.defaultObserver)
        return preferences
    }()

    private static let overrides: Shared<[LocalizationSetting]> = {
        let overrides: Shared<[LocalizationSetting]> = Shared([])
        overrides.register(observer: ChangeObserver.defaultObserver)
        return overrides
    }()

    private static func resolveCurrentLocalization() -> LocalizationSetting {

        // Force initialization to finish before observing begins.
        let overrides = self.overrides.value.last
        let applicationPreferences = self.applicationPreferences.value
        let sdgPreferences = self.sdgPreferences.value
        let systemPreferences = self.systemPreferences.value

        // Resolve
        return overrides
            ?? applicationPreferences
            ?? sdgPreferences
            ?? systemPreferences
    }

    private static var readyToObserve = false
    private class ChangeObserver : SharedValueObserver {
        fileprivate static let defaultObserver = ChangeObserver()
        fileprivate func valueChanged(for identifier: String) {

            if readyToObserve { // Prevent circularity until resolveCurrentlocalization() has completed once and all component variables are initialized.

                let new = LocalizationSetting.resolveCurrentLocalization()
                if current.value ≠ new {
                    current.value = new
                }
            }
        }
    }

    /// The current localization setting.
    ///
    /// - Note: The value of the shared instance is intended to be read‐only.
    public static let current: Shared<LocalizationSetting> = {
        let result = Shared(resolveCurrentLocalization())

        // Prevent circularity until current has been initialized.
        result.register(observer: ChangeObserver())
        readyToObserve = true

        return result
    }()

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
