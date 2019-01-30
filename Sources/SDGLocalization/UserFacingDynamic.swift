/*
 UserFacingDynamicText.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A user‐facing, localized element that changes dynamically according to supplied arguments.
public struct UserFacingDynamic<Element, Localization : SDGLocalization.Localization, Arguments> {

    // MARK: - Initialization

    /// Creates a user‐facing element from a closure that resolves the element for a specified localization.
    ///
    /// - Parameters:
    ///     - localize: A closure that resolves the element based on a requested localization.
    ///     - localization: The requested localization.
    ///     - arguments: One or more (as a tuple) arguments necessary for the correct resolution of the element.
    @inlinable public init(_ localize: @escaping (_ localization: Localization, _ arguments: Arguments) -> Element) {
        self.localize = localize
    }

    // MARK: - Properties

    @usableFromInline internal var localize: (Localization, Arguments) -> Element

    // MARK: - Output

    /// Returns the resolved element for the current localization using the specified arguments.
    ///
    /// - Parameters:
    ///     - arguments: The arguments to interpolate.
    @inlinable public func resolved(using arguments: Arguments) -> Element {
        return localize(LocalizationSetting.current.value.resolved(), arguments)
    }

    /// Returns the resolved element for the specified localization using the specified arguments.
    ///
    /// - Parameters:
    ///     - localization: The target localization.
    ///     - argmuents: The arguments to interpolate.
    @inlinable public func resolved(for localization: Localization, using arguments: Arguments) -> Element {
        return localize(localization, arguments)
    }

    // MARK: - Conversions

    /// The static instance typed as `UserFacing<Element, Localization>`.
    ///
    /// - Parameters:
    ///     - arguments: The arguments to interpolate.
    @inlinable public func `static`(using arguments: Arguments) -> UserFacing<Element, Localization> {
        let resolution = localize
        return UserFacing<Element, Localization>({ resolution($0, arguments) })
    }
}
