/*
 ExpressibleByUnicodeScalarLiteral.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension ExpressibleByUnicodeScalarLiteral where Self : ExpressibleByTextLiterals {
    // MARK: - where Self : ExpressibleByTextLiterals

    // [_Define Documentation: SDGCornerstone.ExpressibleByUnicodeScalarLiteral.init(unicodeScalarLiteral:)_]
    /// Creates an instance from a Unicode scalar literal.
    public init(unicodeScalarLiteral: String) {
        self.init(stringLiteral: unicodeScalarLiteral)
    }
}
