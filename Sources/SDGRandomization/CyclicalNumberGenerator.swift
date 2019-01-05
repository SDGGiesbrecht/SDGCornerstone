/*
 CyclicalNumberGenerator.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

/// A “random” number generator that returns numbers in a pre‐determined cycle.
public struct CyclicalNumberGenerator : RandomNumberGenerator {

    private let sequence: [UInt64]
    private var index: Array<UInt64>.Index

    /// Creates a cyclical number generator that returns numbers according to `sequence`.
    ///
    /// - Precondition: `sequence` is not empty.
    ///
    /// - Parameters:
    ///     - sequence: The sequence.
    public init(_ sequence: [UInt64]) {
        _assert(¬sequence.isEmpty, { (localization: _APILocalization) -> String in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "Empty sequence."
            }
        })

        self.sequence = sequence
        self.index = sequence.startIndex
    }

    // MARK: - RandomNumberGenerator

    /// Returns the next value in the sequence.
    public mutating func next() -> UInt64 {

        let result = sequence[index]

        index.increment()
        if index == sequence.endIndex {
            index = sequence.startIndex
        }

        return result
    }
}
