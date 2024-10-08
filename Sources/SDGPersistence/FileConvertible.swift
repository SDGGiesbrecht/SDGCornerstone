/*
 FileConvertible.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A type than can be saved to the disk or initialized from a file.
public protocol FileConvertible {

  /// Creates an instance using raw data from a file on the disk.
  ///
  /// - Parameters:
  ///   - file: The data.
  ///   - origin: A URL indicating where the data came from. In some cases this may be helpful in determining how to interpret the data, such as by checking the file extension. This parameter may be `nil` if the data did not come from a file on the disk.
  init(file: Data, origin: URL?) throws

  /// A binary representation that can be written as a file.
  var file: Data { get }
}

extension FileConvertible {

  #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
    /// Saves the file to the specified URL.
    ///
    /// - Parameters:
    ///   - url: The URL to save to.
    public func save(to url: URL) throws {
      let adjusted = FileManager.default.existingRepresentation(of: url)
      let directory = adjusted.deletingLastPathComponent()
      try FileManager.default.createDirectory(at: directory)
      try file.write(to: adjusted, options: [.atomic])
    }

    /// Loads the file at the specified URL.
    ///
    /// - Parameters:
    ///   - url: The URL to read from.
    public init(from url: URL) throws {
      let adjusted = FileManager.default.existingRepresentation(of: url)
      try self.init(
        file: try Data(contentsOf: adjusted, options: [.mappedIfSafe]),
        origin: adjusted
      )
    }
  #endif
}
