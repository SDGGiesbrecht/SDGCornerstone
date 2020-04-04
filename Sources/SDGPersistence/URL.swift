/*
 URL.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, Web doesn’t have foundation yet.)
#if !os(WASI)
  import Foundation

  import SDGMathematics

  // @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
  /// Ein Wert, der den Standort einer Ressource kennzeichnet. (`URL`)
  public typealias EinheitlicherRessourcenzeiger = URL

  extension URL: Comparable {

    private var platformPathSeparator: Unicode.Scalar {
      #if os(Windows)
        return #"\"#
      #else
        return "/"
      #endif
    }

    /// Returns `true` if the URL is in the location described by the specified URL.
    ///
    /// The URL is considered to be inside if it:
    ///
    /// - points to a file or subfolder of the other URL, or
    /// - points to the same file or folder as the other URL.
    ///
    /// - Parameters:
    ///     - other: Another URL.
    public func `is`(in other: URL) -> Bool {
      let path = self.path
      let otherPath = other.path
      if path == otherPath {
        return true
      } else {
        let otherDirectory: String
        if otherPath.scalars.last == platformPathSeparator {
          otherDirectory = otherPath
        } else {
          otherDirectory = otherPath + String(platformPathSeparator)
        }
        return path.hasPrefix(otherDirectory)
      }
    }

    /// Returns the relative path from another URL.
    ///
    /// - Parameters:
    ///     - other: Another URL.
    ///
    /// - Returns: The relative path from the specified URL (or the absolute path if the URL is not a parent directory).
    public func path(relativeTo other: URL) -> String {
      guard `is`(in: other) else {
        return path
      }
      let otherLength = other.path.clusters.count
      var relative = path.clusters.dropFirst(otherLength)
      if relative.first == Character(platformPathSeparator) {
        relative = relative.dropFirst()
      }
      return String(relative)
    }

    // MARK: - Comparable

    public static func < (precedingValue: URL, followingValue: URL) -> Bool {
      return compare(precedingValue, followingValue) { $0.absoluteString }
    }
  }
#endif
