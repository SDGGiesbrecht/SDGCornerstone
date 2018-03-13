/*
 UserFacingDynamicText.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// User‐facing, localized text that changes dynamically according to supplied arguments.
public struct UserFacingDynamicText<Localization : SDGLocalization.Localization, Arguments> {

    // MARK: - Initialization

    /// Creates user‐facing text from a closure that resolves the text for a specified localization.
    ///
    /// - Parameters:
    ///     - localize: A closure that resolves the text based on a requested localization.
    ///     - localization: The requested localization.
    ///     - arguments: One or more (as a tuple) arguments necessary for the correct resolution of the string.
    @_inlineable public init(_ localize: @escaping (_ localization: Localization, _ arguments: Arguments) -> StrictString) {
        self.localize = localize
    }

    // MARK: - Properties

    @_versioned internal var localize: (Localization, Arguments) -> StrictString

    // MARK: - Output

    /// Returns the resolved string for the current localization using the specified arguments.
    @_inlineable public func resolved(using arguments: Arguments) -> StrictString {
        return localize(LocalizationSetting.current.value.resolved(), arguments)
    }

    /// Returns the resolved string for the specified localization using the specified arguments.
    @_inlineable public func resolved(for localization: Localization, using arguments: Arguments) -> StrictString {
        return localize(localization, arguments)
    }

    // MARK: - Conversions

    /// The static instance typed as `UserFacingText`.
    @_inlineable public func `static`(using arguments: Arguments) -> UserFacingText<Localization> {
        let resolution = localize
        return UserFacingText<Localization>({ resolution($0, arguments) })
    }
}
