/*
 Application.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal struct Application {

    // MARK: - Static Properties

    internal static var currentApplicationIdentifierInitializer: String?
    internal static var currentApplicationModeInitializer: Mode?
    internal static let current: Application = {
        guard let identifier = currentApplicationIdentifierInitializer,
            let mode = currentApplicationModeInitializer else {
                preconditionFailureNotInitialized()
        }
        if let main = Bundle.main.bundleIdentifier {
            assert(identifier == main, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada:
                    return StrictString("The application identifier does not match the main bundle identifier: \(identifier) ≠ \(main)")
                }
            }))
        }
        return Application(identifier: identifier, mode: mode)
    }()

    // MARK: - Initialization

    private init(identifier: String, mode: Mode) {
        self.identifier = identifier
        self.mode = mode
    }

    // MARK: - Properties

    internal let identifier: String
    internal var domain: String {
        return identifier
    }

    internal let mode: Mode
}
