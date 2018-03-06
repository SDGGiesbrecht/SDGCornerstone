/*
 Initialization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import SDGCornerstoneLocalizations

// MARK: - Initialization

private var initialized = false
/// Initializes SDGCornerstone. Call this before calling anything else from SDGCornerstone.
///
/// - Parameters:
///     - mode: The `Mode` SDGCornerstone should follow.
public func initialize(mode: Mode) {

    assert(initialized == false, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
        switch localization {
        case .englishCanada: // [_Exempt from Test Coverage_]
            return StrictString("Detected attempted to re‐initialize. SDGCornerstone is only designed to be initialized once.")
        }
    }))
    defer { initialized = true }

    Application.currentApplicationModeInitializer = mode
}

internal func preconditionFailureNotInitialized() -> Never {
    // This cannot be localized the normal way because of circularity.
    let message = APILocalization.cases.map({ // [_Exempt from Test Coverage_]
        switch $0 {
        case .englishCanada: // [_Exempt from Test Coverage_]
            return "SDGCornerstone has not been initialized. Did you forget to call SDGCornerstone.initialize(...)?"
        }
    }).joined(separator: "\n\n")

    preconditionFailure("\n\n" + message + "\n\n")
}
