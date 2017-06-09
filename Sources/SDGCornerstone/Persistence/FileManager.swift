/*
 FileManager.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension FileManager {

    // MARK: - Domains

    internal static func possibleDebugDomain(_ domain: String) -> String {
        return BuildConfiguration.current == .debug ? domain + ".debug" : domain // [_Exempt from Code Coverage_]
    }

    // MARK: - Recommended File Locations

    /// A recommended location for file operations.
    public enum RecommendedLocation {

        /// Permanent, backed‐up storage for application‐related, internal‐use files that are hidden from the user.
        case applicationSupport

        /// For caches that are saved to improve performance. The operating system may empty this if it needs to create space. Do not save anything here that cannot be regenerated if necessary.
        case cache

        /// For files that are used only transiently. The operating system empties this periodically.
        case temporary
    }

    /// Returns a URL for the specified location and relative path in the application’s domain.
    ///
    /// - Parameters:
    ///     - location: The location.
    ///     - domain: The domain.
    ///     - relativePath: The path.
    public func url(in location: RecommendedLocation, at relativePath: String) -> URL {
        return url(in: location, for: Application.current.domain, at: relativePath)
    }

    /// Returns a URL for the specified location, domain and relative path.
    ///
    /// - Parameters:
    ///     - location: The location.
    ///     - domain: The domain.
    ///     - relativePath: The path.
    public func url(in location: RecommendedLocation, for domain: String, at relativePath: String) -> URL {
        let searchPath: FileManager.SearchPathDirectory
        switch location {
        case .applicationSupport:
            searchPath = .applicationSupportDirectory
        case .cache:
            searchPath = .cachesDirectory
        case .temporary:
            searchPath = .itemReplacementDirectory
        }

        guard let zoneURL = try? url(for: searchPath, in: .userDomainMask, appropriateFor: nil, create: true) else {
            unreachable()
        }

        return zoneURL.encodingAndAppending(pathComponents: FileManager.possibleDebugDomain(domain)).encodingAndAppending(pathComponents: relativePath)
    }
}
