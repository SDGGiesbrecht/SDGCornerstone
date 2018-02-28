/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogicCore
import SDGCollectionsCore

extension Collection {

    internal func assertIndexExists(_ index: Index) {
        assert(index ∈ bounds, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "Index out of bounds."
            }
        }))
    }
}

extension Collection where IndexDistance : WholeArithmetic {
    // MARK: - where IndexDistance : WholeArithmetic

    /// Returns a random index from the collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    public func randomIndex(fromRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) -> Index {
        let random = IndexDistance(randomInRange: 0 ... count − 1, fromRandomizer: randomizer)
        return index(startIndex, offsetBy: random)
    }

    /// Returns a random element from the collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    public func randomElement(fromRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) -> Element {
        return self[randomIndex(fromRandomizer: randomizer)]
    }
}

extension Collection where Element == UnicodeScalar {
    // MARK: - where Element == UnicodeScalar

    // [_Inherit Documentation: SDGCornerstone.String.isMultiline_]
    /// Whether or not the string contains multiple lines.
    public var isMultiline: Bool {
        return contains(where: { $0 ∈ CharacterSet.newlines })
    }
}
