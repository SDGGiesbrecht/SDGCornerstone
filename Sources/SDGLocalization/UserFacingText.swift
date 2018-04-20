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

/// A user‐facing, localized element.
///
/// - SeeAlso: UserFacingDynamic
public struct UserFacing<Element, Localization : SDGLocalization.Localization> : TransparentWrapper {

    // MARK: - Initialization

    /// Creates a user‐facing element from a closure that resolves the element for a specified localization.
    ///
    /// - Parameters:
    ///     - localize: A closure that resolves the element based on a requested localization.
    ///     - localization: The requested localization.
    ///     - arguments: One or more (as a tuple) arguments necessary for the correct resolution of the element.
    @_inlineable public init(_ localize: @escaping (_ localization: Localization) -> Element) {
        self.dynamic = UserFacingDynamic<Element, Localization, Void>({ (localization, _) in
            return localize(localization)
        })
    }

    // MARK: - Properties

    /// The same instance typed as `UserFacingDynamic<Element, Localization, Void>`.
    public let dynamic: UserFacingDynamic<Element, Localization, Void>

    // MARK: - Output

    /// Returns the resolved element for the current localization.
    @_inlineable public func resolved() -> Element {
        return dynamic.resolved(using: ())
    }

    /// Returns the resolved element for the specified localization.
    @_inlineable public func resolved(for localization: Localization) -> Element {
        return dynamic.resolved(for: localization, using: ())
    }

    // MARK: - TransparentWrapper

    // [_Inherit Documentation: SDGCornerstone.TransparentWrapper.wrapped_]
    /// The wrapped instance.
    @_inlineable public var wrappedInstance: Any {
        return resolved()
    }
}
