/*
 UserFacingText.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// User‐facing, localized text.
///
/// - SeeAlso: UserFacingDynamicText
public struct UserFacingText<Localization : SDGLocalization.Localization> : TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates user‐facing text from a closure that resolves the text for a specified localization.
    ///
    /// - Parameters:
    ///     - localize: A closure that resolves the text based on a requested localization.
    ///     - localization: The requested localization.
    ///     - arguments: One or more (as a tuple) arguments necessary for the correct resolution of the string.
    @_inlineable public init(_ localize: @escaping (_ localization: Localization) -> StrictString) {
        self.dynamic = UserFacingDynamicText<Localization, Void>({ (localization, _) in
            return localize(localization)
        })
    }

    // MARK: - Properties

    /// The same instance typed as `UserFacingDynamicText`.
    public let dynamic: UserFacingDynamicText<Localization, Void>

    // MARK: - Output

    /// Returns the resolved string for the current localization using the specified arguments.
    @_inlineable public func resolved() -> StrictString {
        return dynamic.resolved(using: ())
    }

    /// Returns the resolved string for the specified localization using the specified arguments.
    @_inlineable public func resolved(for localization: Localization) -> StrictString {
        return dynamic.resolved(for: localization, using: ())
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return String(resolved())
    }
}
