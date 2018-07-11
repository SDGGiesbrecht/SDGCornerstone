/*
 Measurement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

// [_Workaround: In Swift 4.1, this can be just “extension Measurement {” (Swift 4.1.2)_]
extension Measurement where Scalar : RandomizableNumber {
    // MARK: - where Scalar : RandomizableNumber

    // @documentation(SDGCornerstone.Measurement.init(randomInRange:))
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @_inlineable public init(randomInRange range: Range<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // #documentation(SDGCornerstone.Measurement.init(randomInRange:))
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @_inlineable public init(randomInRange range: ClosedRange<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // @documentation(SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    @_inlineable public init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer) {
        let scalar = Scalar(randomInRange: range.lowerBound.rawValue ..< range.upperBound.rawValue, fromRandomizer: randomizer)
        self.init(rawValue: scalar)
    }

    // #documentation(SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    @_inlineable public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let scalar = Scalar(randomInRange: range.lowerBound.rawValue ... range.upperBound.rawValue, fromRandomizer: randomizer)
        self.init(rawValue: scalar)
    }
}
