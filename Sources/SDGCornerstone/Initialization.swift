/*
 Initialization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

// MARK: - Initialization

private var initialized = false
/// Initializes SDGCornerstone. Call this before calling anything else from SDGCornerstone.
///
/// - Parameters:
///     - applicationIdentifier: An identifier for the application. If the application has a main bundle, this should match its identifier.
///     - applicationPreferencesClass: A subclass of `Preferences` to use for the application preferences. Defaults to the `Preferences` class itself.
///     - mode: The `Mode` SDGCornerstone should follow.
public func initialize(mode: Mode, applicationIdentifier: String, applicationPreferencesClass: Preferences.Type = Preferences.self) {

    assert(initialized == false, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
        switch localization {
        case .englishCanada:
            return StrictString("Detected attempted to re‐initialize. SDGCornerstone is only designed to be initialized once.")
        }
    }))
    defer { initialized = true }

    Application.currentApplicationModeInitializer = mode
    Application.currentApplicationIdentifierInitializer = applicationIdentifier
    Preferences.subclassForApplicationPreferencesInitializer = applicationPreferencesClass
}

internal func preconditionFailureNotInitialized() -> Never {
    // This cannot be localized the normal way because of circularity.
    let message = APILocalization.cases.map({ // [_Exempt from Code Coverage_]
        switch $0 {
        case .englishCanada:
            return "SDGCornerstone has not been initialized. Did you forget to call SDGCornerstone.initialize(...)?"
        }
    }).joined(separator: "\n\n")

    preconditionFailure("\n\n" + message + "\n\n")
}
