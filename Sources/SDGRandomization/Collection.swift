/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension Collection where IndexDistance : RandomizableNumber {
    // MARK: - where IndexDistance : RandomizableNumber

    /// Returns a random index from the collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    @_inlineable public func randomIndex(fromRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) -> Index {
        let random = IndexDistance(randomInRange: 0 ... count − 1, fromRandomizer: randomizer)
        return index(startIndex, offsetBy: random)
    }

    /// Returns a random element from the collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    @_inlineable public func randomElement(fromRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) -> Element {
        return self[randomIndex(fromRandomizer: randomizer)]
    }
}
