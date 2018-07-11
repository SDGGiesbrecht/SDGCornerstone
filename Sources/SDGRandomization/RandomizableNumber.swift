/*
 RandomizableNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

/// A number that can be randomized.
///
/// Conformance Requirements:
///
/// - `init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)`
public protocol RandomizableNumber : WholeArithmetic {

    // @documentation(SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)
}

extension RandomizableNumber {

    // @documentation(SDGCornerstone.WholeArithmetic.init(randomInRange:))
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @_inlineable public init(randomInRange range: ClosedRange<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }
}

extension RandomizableNumber where Self : RationalArithmetic {
    // MARK: - where Self : RationalArithmetic

    // #documentation(SDGCornerstone.WholeArithmetic.init(randomInRange:))
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @_inlineable public init(randomInRange range: Range<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    @_inlineable public init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer) {

        _assert(¬range.isEmpty, { (localization: _APILocalization) in
            switch localization { // [_Exempt from Test Coverage_]
            case .englishCanada:
                return "Empty range."
            }
        })

        var random = range.upperBound

        while random == range.upperBound {
            random = Self(randomInRange: range.lowerBound ... range.upperBound, fromRandomizer: randomizer)
        }

        self = random
    }
}
