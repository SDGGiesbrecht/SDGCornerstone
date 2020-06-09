/*
 FileManager.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation

  import SDGControlFlow
  import SDGLogic

  extension FileManager {

    // MARK: - Domains

    internal static func possibleDebugDomain(_ domain: String) -> String {
      #if DEBUG
        return domain + ".debug"
      #else
        return domain
      #endif
    }

    // MARK: - Recommended File Locations

    /// A recommended location for file operations.
    ///
    /// For the temporary files used only transiently, use `FileManager.withTemporaryDirectory(appropriateFor:_:)` instead.
    public enum RecommendedLocation {

      /// Permanent, backed‐up storage for application‐related, internal‐use files that are hidden from the user.
      case applicationSupport

      /// For caches that are saved to improve performance. The operating system may empty this if it needs to create space. Do not save anything here that cannot be regenerated if necessary.
      case cache
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

        let searchPath: FileManager.SearchPathDirectory
        switch location {
        case .applicationSupport:
          searchPath = .applicationSupportDirectory
        case .cache:
          searchPath = .cachesDirectory
        }

        do {
          return try url(
            for: searchPath,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
          )
        } catch {
          do {  // @exempt(from: tests)
            // Enable read queries even if directories could not be created, such as on a read‐only file system.
            return try url(
              for: searchPath,
              in: .userDomainMask,
              appropriateFor: nil,
              create: false
            )
          } catch {
            preconditionFailure("\(error.localizedDescription)")
          }
        }
      }

      return zoneURL.appendingPathComponent(FileManager.possibleDebugDomain(domain))
    }

    /// Returns a URL for the specified location and relative path in the application’s domain.
    ///
    /// - Parameters:
    ///     - location: The location.
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
    public func url(in location: RecommendedLocation, for domain: String, at relativePath: String)
      -> URL
    {
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

    /// Performs an operation with a temporary directory.
    ///
    /// This method cleans up the directory its provides immediately after the operation completes.
    ///
    /// The directory will be in a location where the operating system will clean it up eventually in the event of a crash preventing the method from performing clean‐up itself.
    ///
    /// - Parameters:
    ///     - destination: The approximate destination of any files that will be moved out of the temporary directory. The method will attempt to use a temporary directory on the same volume so the move can be made faster. Pass `nil` if it does not matter.
    ///     - body: The body of the operation.
    ///     - directory: The provided temporary directory.
    public func withTemporaryDirectory<Result>(
      appropriateFor destination: URL?,
      _ body: (_ directory: URL) throws -> Result
    ) rethrows -> Result {
      var directory: URL

      #if os(Android)
        // #workaround(Swift 5.2.4, .itemReplacementDirectory leads to illegal instruction.)
        directory = temporaryDirectory
      #else
        let volume = try? url(
          for: .documentDirectory,
          in: .userDomainMask,
          appropriateFor: nil,
          create: true
        )
        if let itemReplacement = try? url(
          for: .itemReplacementDirectory,
          in: .userDomainMask,
          appropriateFor: volume,
          create: true
        ) {
          directory = itemReplacement
        } else {
          // @exempt(from: tests) macOS fails to find the preferred item replacement directory from time to time.
          if let anyVolume = try? url(
            for: .itemReplacementDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
          ) {
            directory = anyVolume
          } else {
            // @exempt(from: tests)
            if #available(macOS 10.12, iOS 10, watchOS 3, tvOS 10, *) {  // @exempt(from: tests)
              directory = temporaryDirectory
            } else {  // @exempt(from: tests)
              directory = URL(fileURLWithPath: NSTemporaryDirectory())
            }
          }
        }
      #endif

      directory.appendPathComponent(UUID().uuidString)
      defer { try? removeItem(at: directory) }
      return try body(directory)
    }

    // MARK: - Unicode Path Representations

    /// Returns the URL with any path components adjusted to match their on‐disk Unicode representations.
    ///
    /// - Parameters:
    ///   - url: The URL to adjust.
    public func existingRepresentation(of url: URL) -> URL {
      if (try? url.checkResourceIsReachable()) == true
        ∨ url.pathComponents.isEmpty
      {
        return url
      } else {
        let component = url.lastPathComponent
        let parent = existingRepresentation(of: url.deletingLastPathComponent())
        for existing
          in (try? FileManager.default.contentsOfDirectory(
            at: parent,
            includingPropertiesForKeys: nil
          )) ?? []
        {
          let onDisk = existing.lastPathComponent
          if onDisk == component {  // @exempt(from: tests) Not reachable from some file systems.
            return parent.appendingPathComponent(onDisk)
          }
        }
        return parent.appendingPathComponent(component)
      }
    }

    // MARK: - Making Changes to the File System

    /// Creates a directory at the specified location.
    ///
    /// This method creates any missing intermediate directories. All directories are created with the default attributes.
    ///
    /// This method will automatically use the on disk Unicode representation of any existing path components.
    ///
    /// - Parameters:
    ///   - location: The location where the directory should be created.
    public func createDirectory(at location: URL) throws {
      return try createDirectory(
        at: existingRepresentation(of: location),
        withIntermediateDirectories: true,
        attributes: nil
      )
    }

    /// Moves the item at the specified source to the specified destination, creating intermediate directories if necessary.
    ///
    /// This method will automatically use the on disk Unicode representation of any existing path components.
    ///
    /// - Parameters:
    ///     - source: The URL of the source item.
    ///     - destination: The destination URL.
    public func move(_ source: URL, to destination: URL) throws {
      try createDirectory(at: destination.deletingLastPathComponent())
      try moveItem(
        at: existingRepresentation(of: source),
        to: existingRepresentation(of: destination)
      )
    }

    /// Copies the item at the specified source URL to the specified destination URL, creating intermediate directories if necessary.
    ///
    /// This method will automatically use the on disk Unicode representation of any existing path components.
    ///
    /// - Parameters:
    ///     - source: The URL of the source item.
    ///     - destination: The destination URL.
    public func copy(_ source: URL, to destination: URL) throws {
      try createDirectory(at: destination.deletingLastPathComponent())
      try copyItem(
        at: existingRepresentation(of: source),
        to: existingRepresentation(of: destination)
      )
    }

    // MARK: - Enumerating Files

    /// Returns a list files and directories located immediately inside in the specified directory.
    ///
    /// This method will automatically use the on disk Unicode representation of any existing path components.
    ///
    /// - Parameters:
    ///     - directory: The root directory for the search.
    public func contents(ofDirectory directory: URL) throws -> [URL] {
      return try contentsOfDirectory(
        at: existingRepresentation(of: directory),
        includingPropertiesForKeys: nil,
        options: []
      )
    }

    private static let unknownFileReadingError = NSError(
      domain: NSCocoaErrorDomain,
      code: NSFileReadUnknownError,
      userInfo: nil
    )

    /// Returns a list of all files in the specified directory, including those nested within subdirectories.
    ///
    /// Directories themselves are not returned—only the files they contain.
    ///
    /// - Parameters:
    ///     - directory: The root directory for the search.
    public func deepFileEnumeration(in directory: URL) throws -> [URL] {

      var failureReason: Error?  // Thrown after enumeration stops. (See below.)
      guard
        let enumerator = FileManager.default.enumerator(
          at: existingRepresentation(of: directory),
          includingPropertiesForKeys: [.isDirectoryKey],
          options: [],
          errorHandler: { (_, error: Error) -> Bool in  // @exempt(from: tests)
            // @exempt(from: tests) It is unknown what circumstances would actually cause an error.
            failureReason = error
            return false  // Stop.
          }
        )
      else {  // @exempt(from: tests)
        // @exempt(from: tests) It is unknown what circumstances would actually result in a `nil` enumerator being returned.
        throw FileManager.unknownFileReadingError
      }

      var result: [URL] = []
      for object in enumerator {
        guard let url = object as? URL else {
          throw FileManager.unknownFileReadingError  // @exempt(from: tests)
          //It is unknown why something other than a URL would be returned.
        }

        var objCBool: ObjCBool = false
        let isDirectory =
          FileManager.default.fileExists(atPath: url.path, isDirectory: &objCBool)
          ∧ objCBool.boolValue

        if ¬isDirectory {  // Skip directories.
          result.append(url)
        }
      }

      if let error = failureReason {
        throw error  // @exempt(from: tests)
        // It is unknown what circumstances would actually cause an error.
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

      try createDirectory(at: directory)

      let previous = currentDirectoryPath
      _ = changeCurrentDirectoryPath(directory.path)
      defer { _ = changeCurrentDirectoryPath(previous) }

      try closure()
    }
  }
#endif
