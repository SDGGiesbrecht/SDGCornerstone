/*
 FileManager.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(Glibc)
// #workaround(Swift 4.2.1, See move method below.)
import Glibc
#endif

import Foundation

import SDGControlFlow
import SDGLogic

extension FileManager {

    // MARK: - Domains

    internal static func possibleDebugDomain(_ domain: String) -> String {
        return BuildConfiguration.current == .debug ? domain + ".debug" : domain // @exempt(from: tests)
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

    private static var locations: [FileManager: [RecommendedLocation: URL]] = [:]
    private var locations: [RecommendedLocation: URL] {
        get {
            return FileManager.locations[self] ?? [:]
        }
        set {
            FileManager.locations[self] = newValue
        }
    }
    private func url(in location: RecommendedLocation, for domain: String) -> URL {

        let zoneURL = cached(in: &locations[location]) {

            #if os(Linux)
            // #workaround(Swift 4.2.1, Foundation will handle the first two itself in Swift 5.0.)

            let path: String
            switch location {
            case .applicationSupport:
                path = NSHomeDirectory() + "/.Application Support"
            case .cache:
                path = NSHomeDirectory() + "/.cache"
            case .temporary:
                path = "/tmp"
            }
            return URL(fileURLWithPath: path)

            #else

            let searchPath: FileManager.SearchPathDirectory
            switch location {
            case .applicationSupport:
                searchPath = .applicationSupportDirectory
            case .cache:
                searchPath = .cachesDirectory
            case .temporary:
                searchPath = .itemReplacementDirectory
            }

            var volume: URL?
            if location == .temporary {
                guard let documents = try? url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
                    _unreachable()
                }
                volume = documents
            }

            guard let result = try? url(for: searchPath, in: .userDomainMask, appropriateFor: volume, create: true) else {
                _unreachable()
            }
            return result

            #endif
        }

        return zoneURL.appendingPathComponent(FileManager.possibleDebugDomain(domain))
    }

    /// Returns a URL for the specified location and relative path in the application’s domain.
    ///
    /// - Parameters:
    ///     - location: The location.
    ///     - domain: The domain.
    ///     - relativePath: The path.
    public func url(in location: RecommendedLocation, at relativePath: String) -> URL {
        return url(in: location, for: ProcessInfo.applicationDomain, at: relativePath)
    }

    /// Returns a URL for the specified location, domain and relative path.
    ///
    /// - Parameters:
    ///     - location: The location.
    ///     - domain: The domain.
    ///     - relativePath: The path.
    public func url(in location: RecommendedLocation, for domain: String, at relativePath: String) -> URL {
        return url(in: location, for: domain).appendingPathComponent(relativePath)
    }

    /// Deletes everything in the specified location for the application domain.
    ///
    /// - Parameters:
    ///     - location: The location.
    public func delete(_ location: RecommendedLocation) {
        delete(location, for: ProcessInfo.applicationDomain)
    }

    /// Deletes everything in the specified location and domain.
    ///
    /// - Parameters:
    ///     - location: The location.
    ///     - domain: The domain.
    public func delete(_ location: RecommendedLocation, for domain: String) {
        let folder = url(in: location, for: domain)
        try? removeItem(at: folder)
    }

    // Moving Files and Directories

    /// Moves the item at the specified source to the specified destination, creating intermediate directories if necessary.
    ///
    /// - Parameters:
    ///     - source: The URL of the source item.
    ///     - destination: The destination URL.
    public func move(_ source: URL, to destination: URL) throws {

        try createDirectory(at: destination.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)

        #if canImport(Glibc)
        // #workaround(Swift 4.2.1, Until Linux’ Foundation implements cross‐device moves in Swift 5.)

        if ¬fileExists(atPath: destination.path) {
            // Otherwise Foundation can generate its own error.

            if rename(source.path, destination.path) == 0 {
                return // Move complete.
            } else {
                if errno == EXDEV {
                    // Cross‐device
                    try copy(source, to: destination)
                    try removeItem(at: source)
                    return // Move complete.
                } else {
                    // Foundation can generate it own error.
                }
            }
        }
        #endif

        try moveItem(at: source, to: destination)
    }

    /// Copies the item at the specified source URL to the specified destination URL, creating intermediate directories if necessary.
    ///
    /// - Parameters:
    ///     - source: The URL of the source item.
    ///     - destination: The destination URL.
    public func copy(_ source: URL, to destination: URL) throws {

        try createDirectory(at: destination.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)

        try copyItem(at: source, to: destination)
    }

    // MARK: - Enumerating Files

    private static let unknownFileReadingError = NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil)

    /// Returns a list of all files in the specified directory, including those nested within subdirectories.
    ///
    /// Directories themselves are not returned—only the files they contain.
    public func deepFileEnumeration(in directory: URL) throws -> [URL] {

        var failureReason: Error? // Thrown after enumeration stops. (See below.)
        guard let enumerator = FileManager.default.enumerator(at: directory, includingPropertiesForKeys: [.isDirectoryKey], options: [], errorHandler: { (_, error: Error) -> Bool in // @exempt(from: tests) It is unknown what circumstances would actually cause an error.
            failureReason = error
            return false // Stop.
        }) else { // @exempt(from: tests) It is unknown what circumstances would actually result in a `nil` enumerator being returned.
            throw FileManager.unknownFileReadingError
        }

        var result: [URL] = []
        for object in enumerator {
            guard let url = object as? URL else {
                throw FileManager.unknownFileReadingError // @exempt(from: tests) It is unknown why something other than a URL would be returned.
            }

            let isDirectory: Bool
            #if os(Linux)
            // #workaround(Swift 4.2.1, Linux has no implementation for resourcesValues.)
            var objCBool: ObjCBool = false
            isDirectory = FileManager.default.fileExists(atPath: url.path, isDirectory: &objCBool) ∧ objCBool.boolValue
            #else
            isDirectory = (try url.resourceValues(forKeys: [.isDirectoryKey])).isDirectory!
            #endif

            if ¬isDirectory { // Skip directories.
                result.append(url)
            }
        }

        if let error = failureReason {
            throw error // @exempt(from: tests) It is unknown what circumstances would actually cause an error.
        }

        return result
    }

    // MARK: - Working Directory

    /// Executes the closure in the specified directory.
    ///
    /// The directory will be automatically created if necessary.
    ///
    /// - Parameters:
    ///     - directory: The directory in which to execute the closure.
    ///     - closure: The closure.
    public func `do`(in directory: URL, closure: () throws -> Void) throws {

        try createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)

        let previous = currentDirectoryPath
        _ = changeCurrentDirectoryPath(directory.path)
        defer { _ = changeCurrentDirectoryPath(previous) }

        try closure()
    }
}
