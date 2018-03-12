/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Collection where Element == UnicodeScalar {
    // MARK: - where Element == UnicodeScalar

    // [_Inherit Documentation: SDGCornerstone.String.isMultiline_]
    /// Whether or not the string contains multiple lines.
    @_inlineable public var isMultiline: Bool {
        return contains(where: { $0 ∈ CharacterSet.newlines })
    }
}
