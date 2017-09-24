/*
 BuildConfiguration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Build Configuration

/// A build configuration.
public enum BuildConfiguration {

    // MARK: - Initialization

    private static func isDebug() -> Bool {
        return _isDebugAssertConfiguration()
    }
    /// The current build configuration.
    public static let current: BuildConfiguration = isDebug() ? .debug : .release

    // MARK: - Cases

    /// The release configuration.
    case release
    /// The debug configuration.
    case debug
}
