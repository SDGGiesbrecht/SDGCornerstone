/*
 FileConvertible.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A type than can be saved to the disk or initialized from a file.
///
/// Conformance Requirements:
///
/// - `init(file: Data, origin: URL?) throws`
/// - `var file: Data { get }`
public protocol FileConvertible {

    // [_Define Documentation: SDGCornerstone.FileConvertible.init(file:origin:)_]
    /// Creates an instance using raw data from a file on the disk.
    ///
    /// - Parameters:
    ///     - file: The data.
    ///     - origin: A URL indicating where the data came from. In some cases this may be helpful in determining how to interpret the data, such as by checking the file extension. This parameter may be `nil` if the data did not come from a file on the disk.
    init(file: Data, origin: URL?) throws

    // [_Define Documentation: SDGCornerstone.FileConvertible.file_]
    /// A binary representation that can be written as a file.
    var file: Data { get }
}

extension FileConvertible {

    // MARK: - Application Support

    /// Saves the file at the specified path in the application’s domain of the application support directory.
    ///
    /// - Parameters:
    ///     - relativePath: The relative path at which to save.
    ///
    /// - Throws: Any error encountered by `save(at:)`
    public func saveInApplicationSupport(at relativePath: String) throws {
        try saveInApplicationSupport(domain: Application.current.domain, at: relativePath)
    }

    /// Reads the file at the specified path in the application’s domain of the application support directory.
    ///
    /// - Parameters:
    ///     - relativePath: The relative path from which to read.
    ///
    /// - Throws: Any error encountered by `init(from:)`.
    public init(fromApplicationSupportAt relativePath: String) throws {
        try self.init(fromApplicationSupportDomain: Application.current.domain, at: relativePath)
    }

    /// Saves the file at the specified path in the specified domain of the application support directory.
    ///
    /// - Parameters:
    ///     - domain: The domain in which to save.
    ///     - relativePath: The relative path at which to save.
    ///
    /// - Throws: Any error encountered by `save(at:)`
    public func saveInApplicationSupport(domain: String, at relativePath: String) throws {
        try save(at: FileManager.support(for: domain).encodingAndAppending(pathComponents: relativePath))
    }

    /// Reads the file at the specified path in the specified domain of the application support directory.
    ///
    /// - Parameters:
    ///     - domain: The domain from which to read.
    ///     - relativePath: The relative path from which to read.
    ///
    /// - Throws: Any error encountered by `init(from:)`.
    public init(fromApplicationSupportDomain domain: String, at relativePath: String) throws {
        try self.init(from: FileManager.support(for: domain).encodingAndAppending(pathComponents: relativePath))
    }

    // MARK: - Cache

    /// Saves the file at the specified path in the application’s cache.
    ///
    /// - Parameters:
    ///     - relativePath: The relative path at which to save.
    ///
    /// - Throws: Any error encountered by `save(at:)`
    public func saveInCache(at relativePath: String) throws {
        try saveInCache(domain: Application.current.domain, at: relativePath)
    }

    /// Reads the file at the specified path in the application’s cache.
    ///
    /// - Parameters:
    ///     - relativePath: The relative path from which to read.
    ///
    /// - Throws: Any error encountered by `init(from:)`.
    public init(fromCacheAt relativePath: String) throws {
        try self.init(fromCacheDomain: Application.current.domain, at: relativePath)
    }

    /// Saves the file at the specified path in the cache for the specified domain.
    ///
    /// - Parameters:
    ///     - domain: The domain in which to save.
    ///     - relativePath: The relative path at which to save.
    ///
    /// - Throws: Any error encountered by `save(at:)`
    public func saveInCache(domain: String, at relativePath: String) throws {
        try save(at: FileManager.cache(for: domain).encodingAndAppending(pathComponents: relativePath))
    }

    /// Reads the file at the specified path in the cache for the specified domain.
    ///
    /// - Parameters:
    ///     - domain: The domain from which to read.
    ///     - relativePath: The relative path from which to read.
    ///
    /// - Throws: Any error encountered by `init(from:)`.
    public init(fromCacheDomain domain: String, at relativePath: String) throws {
        try self.init(from: FileManager.cache(for: domain).encodingAndAppending(pathComponents: relativePath))
    }

    // MARK: - Temporary Directory

    /// Saves the file at the specified path in the application’s temporary directory.
    ///
    /// - Parameters:
    ///     - relativePath: The relative path at which to save.
    ///
    /// - Throws: Any error encountered by `save(at:)`
    public func saveInTemporaryDirectory(at relativePath: String) throws {
        try saveInTemporaryDirectory(domain: Application.current.domain, at: relativePath)
    }

    /// Reads the file at the specified path in the application’s temporary directory.
    ///
    /// - Parameters:
    ///     - relativePath: The relative path from which to read.
    ///
    /// - Throws: Any error encountered by `init(from:)`.
    public init(fromTemporaryDirectoryAt relativePath: String) throws {
        try self.init(fromTemporaryDirectoryDomain: Application.current.domain, at: relativePath)
    }

    /// Saves the file at the specified path in the temporary directory for the specified domain.
    ///
    /// - Parameters:
    ///     - domain: The domain in which to save.
    ///     - relativePath: The relative path at which to save.
    ///
    /// - Throws: Any error encountered by `save(at:)`
    public func saveInTemporaryDirectory(domain: String, at relativePath: String) throws {
        try save(at: FileManager.temporaryDirectory(for: domain).encodingAndAppending(pathComponents: relativePath))
    }

    /// Reads the file at the specified path in the temporary directory for the specified domain.
    ///
    /// - Parameters:
    ///     - domain: The domain from which to read.
    ///     - relativePath: The relative path from which to read.
    ///
    /// - Throws: Any error encountered by `init(from:)`.
    public init(fromTemporaryDirectoryDomain domain: String, at relativePath: String) throws {
        try self.init(from: FileManager.temporaryDirectory(for: domain).encodingAndAppending(pathComponents: relativePath))
    }

    // MARK: - Arbitrary Locations

    /// Saves the file to the specified URL.
    ///
    /// - Parameters:
    ///     - url: The URL to save to.
    ///
    /// - Throws: Any error encountered by `FileManager.createDirectory(at:withIntermediateDirectories:attributes:)` or `Data.write(to:options:)`
    public func save(at url: URL) throws {
        let directory = url.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        try file.write(to: url, options: [.atomic])
    }

    /// Loads the file at the specified URL.
    ///
    /// - Parameters:
    ///     - url: The URL to read from.
    ///
    /// - Throws: Any error encountered by `Data(contentsOfURL:options:)` or `init(file:origin:)`.
    public init(from url: URL) throws {
        try self.init(file: try Data(contentsOf: url, options: [.mappedIfSafe]), origin: url)
    }
}
