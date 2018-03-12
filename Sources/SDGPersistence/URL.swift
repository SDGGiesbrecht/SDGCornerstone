/*
 URL.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension URL : Comparable {

    /// Returns `true` if the URL is in the location described by the specified URL.
    ///
    /// The URL is considered to be inside if it:
    ///     - points to a file or subfolder of the other URL, or
    ///     - points to the same file or folder as the other URL.
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
            if otherPath.hasSuffix("/") {
                otherDirectory = otherPath
            } else {
                otherDirectory = otherPath + "/"
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
        if relative.hasPrefix("/") {
            relative = relative.dropFirst()
        }
        return String(relative)
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func < (precedingValue: URL, followingValue: URL) -> Bool {
        return precedingValue.absoluteString < followingValue.absoluteString
    }
}
