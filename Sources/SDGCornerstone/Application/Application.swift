/*
 Application.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal struct Application {

    // MARK: - Static Properties

    internal static var currentApplicationIdentifierInitializer: String?
    internal static let current: Application = {
        guard let identifier = currentApplicationIdentifierInitializer else {
            preconditionFailureNotInitialized()
        }
        if let main = Bundle.main.bundleIdentifier {
            assert(identifier == main, "The application identifier does not match the main bundle identifier: \(identifier) ≠ \(main)")
        }
        return Application(identifier: identifier)
    }()

    // MARK: - Initialization

    private init(identifier: String) {
        self.identifier = identifier
    }

    // MARK: - Properties

    internal let identifier: String
    internal var domain: String {
        return identifier
    }
}
