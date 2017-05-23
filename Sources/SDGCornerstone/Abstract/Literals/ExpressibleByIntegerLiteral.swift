/*
 ExpressibleByIntegerLiteral.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension ExpressibleByIntegerLiteral where Self : WholeArithmetic {
    // MARK: - where Self : WholeNumberProtocol

    // [_Define Documentation: SDGCornerstone.ExpressibleByIntegerLiteral.init(integerLiteral:)_]
    /// Creates an instance from an integer literal.
    ///
    /// - Parameters:
    ///     - integerLiteral: The integer literal.
    public init(integerLiteral: UIntMax) {
        self.init(integerLiteral)
    }
}
