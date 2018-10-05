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
public protocol RandomizableNumber : WholeArithmetic {}

extension RandomizableNumber where Self : RationalArithmetic {

    // #documentation(SDGCornerstone.WholeArithmetic.init(randomInRange:))
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @inlinable public static func random(in range: Range<Self>) -> Self {
        var generator = SystemRandomNumberGenerator()
        return random(in: range, using: &generator)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    @inlinable public static func random<R>(in range: Range<Self>, using generator: inout R) -> Self where R : RandomNumberGenerator {

        _assert(¬range.isEmpty, { (localization: _APILocalization) in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "Empty range."
            }
        })

        var result = range.upperBound

        while result == range.upperBound {
            result = Self.random(in: range.lowerBound ... range.upperBound, using: &generator)
        }

        return result
    }
}
