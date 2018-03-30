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

extension RangeReplaceableCollection where IndexDistance : RandomizableNumber {
    // MARK: - where IndexDistance : RandomizableNumber

    /// Shuffles the collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    @_inlineable public mutating func shuffle(usingRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) {
        for i in indices {
            let originalLocation = distance(from: startIndex, to: i)
            let newLocation = IndexDistance(randomInRange: 0 ... originalLocation, fromRandomizer: randomizer)
            let element = remove(at: index(startIndex, offsetBy: originalLocation))
            insert(element, at: index(startIndex, offsetBy: newLocation))
        }
    }

    /// Returns a shuffled collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    @_inlineable public func shuffled(usingRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) -> Self {
        return nonmutatingVariant(of: Self.shuffle, on: self, with: (randomizer))
    }
}
