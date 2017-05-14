/*
 ExpressibleByExtendedGraphemeClusterLiteral.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension ExpressibleByExtendedGraphemeClusterLiteral where Self : ExpressibleByTextLiterals {
    // MARK: - where Self : ExpressibleByTextLiterals

    // [_Define Documentation: SDGCornerstone.ExpressibleByExtendedGraphemeClusterLiteral.init(extendedGraphemeClusterLiteral:)_]
    /// Creates an instance from an extended grapheme cluster literal.
    public init(extendedGraphemeClusterLiteral: String) { // [_Exempt from Code Coverage_] (Apparently unreachable.)
        self.init(stringLiteral: extendedGraphemeClusterLiteral)
    }
}
