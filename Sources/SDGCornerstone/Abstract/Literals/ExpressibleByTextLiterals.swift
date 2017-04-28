/*
 ExpressibleByTextLiterals.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that can be represented by a string literal.
///
/// `ExpressibleByTextLiterals` is intended to reduce boilerplate code when conforming to `ExpressibleByStringLiteral` by providing default implementations for the scalar and cluster literals.
///
/// Conformance Requirements:
///
/// - `init(stringLiteral: String)`
public protocol ExpressibleByTextLiterals : ExpressibleByStringLiteral {

    /// Creates an instance from a string literal.
    init(stringLiteral: String)
}
