/*
 ExpressibleByTextLiterals.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    // [_Define Documentation: SDGCornerstone.ExpressibleByTextLiterals.init(stringLiteral:)_]
    /// Creates an instance from a string literal.
    ///
    /// - Parameters:
    ///     - stringLiteral: The string literal.
    init(stringLiteral: String)
}

extension ExpressibleByTextLiterals where Self : WholeArithmetic {
    // MARK: - where Self : WholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByTextLiterals.init(stringLiteral:)_]
    /// Creates an instance from a string literal.
    ///
    /// - Parameters:
    ///     - stringLiteral: The string literal.
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }
}
