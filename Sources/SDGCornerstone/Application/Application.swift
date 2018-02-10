/*
 Application.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal struct Application {

    // MARK: - Static Properties

    internal static var currentApplicationModeInitializer: Mode?
    internal static let current: Application = {
        guard let mode = currentApplicationModeInitializer else {
                preconditionFailureNotInitialized()
        }
        return Application(mode: mode)
    }()

    // MARK: - Initialization

    private init(mode: Mode) {
        self.mode = mode
    }

    // MARK: - Properties

    internal let mode: Mode
}
