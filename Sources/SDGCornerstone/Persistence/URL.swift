/*
 URL.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension URL {

    /// Returns a URL created by appending the specified path components, encoding any characters that cannot be used directly in URL paths.
    ///
    /// - Parameters:
    ///     - pathComponents: The path components to append.
    public func encodingAndAppending(pathComponents: String) -> URL {
        guard let encoded = pathComponents.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) else {
            unreachable()
        }
        return appendingPathComponent(encoded)
    }
}
