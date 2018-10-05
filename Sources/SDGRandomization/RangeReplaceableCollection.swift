/*
 RangeReplaceableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension RangeReplaceableCollection {

    /// Shuffles the collection.
    @inlinable public mutating func shuffle() {
        var generator = SystemRandomNumberGenerator()
        self = Self(shuffled(using: &generator))
    }

    /// Shuffles the collection.
    ///
    /// - Parameters:
    ///     - generator: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    @inlinable public mutating func shuffle<R>(using generator: inout R) where R : RandomNumberGenerator {
        self = Self(shuffled(using: &generator))
    }
}
