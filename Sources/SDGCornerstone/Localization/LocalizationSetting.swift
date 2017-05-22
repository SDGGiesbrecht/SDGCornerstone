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
public struct LocalizationSetting {

    // MARK: - Static Methods

    /// The current localization setting.
    public static var current: LocalizationSetting {
        // [_Warning: This should be shared so that changes propagate._]

        // [_Warning: Enable manual in‐source override (e.g. for command line arguments and application preferences)._]

        // [_Warning: SDG preferences should be used at this point._]

        // [_Warning: System preferences should be used here._]
        return LocalizationSetting(orderOfPrecedence: [] as [String])
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

    // MARK: - Properties

    private let orderOfPrecedence: [[String]]

    // MARK: - Usage

    /// Returns the preferred localization out of those supported by the localization type `L`.
    public func resolved<L : Localization>() -> L {
        for group in orderOfPrecedence {

            let shuffled = group // [_Warning: This should be shuffled._]

            for localization in shuffled {
                if let result = L(reasonableMatchFor: localization) {
                    return result
                }
            }
        }
        return L.fallbackLocalization
    }
}
