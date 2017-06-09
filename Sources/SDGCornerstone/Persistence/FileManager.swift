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

    // MARK: - Searching

    private static func url(for searchPath: FileManager.SearchPathDirectory) -> URL {
        do {
            // [_Warning: What do these actually do on Linux?_]
            return try FileManager.default.url(for: searchPath, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            unreachable()
        }
    }

    // MARK: - Application Support

    private static let applicationSupportDirectory: URL =  url(for: .applicationSupportDirectory)

    internal static func support(for domain: String) -> URL {
        return applicationSupportDirectory.encodingAndAppending(pathComponents: possibleDebugDomain(domain))
    }

    // MARK: - Cache

    private static let cache: URL = url(for: .cachesDirectory)

    internal static func cache(for domain: String) -> URL {
        return cache.encodingAndAppending(pathComponents: possibleDebugDomain(domain))
    }

    // MARK: - Temporary

    private static let temporaryDirectory: URL = url(for: .itemReplacementDirectory)

    internal static func temporaryDirectory(for domain: String) -> URL {
        return temporaryDirectory.encodingAndAppending(pathComponents: possibleDebugDomain(domain))
    }
}
