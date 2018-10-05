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

extension Measurement {


    // @documentation(SDGCornerstone.Measurement.init(randomInRange:))
    /// Returns a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @inlinable public static func random(in range: Range<Self>) -> Self {
        var generator = SystemRandomNumberGenerator()
        return random(in: range, using: &generator)
    }

    // #documentation(SDGCornerstone.Measurement.init(randomInRange:))
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    @inlinable public static func random(in range: ClosedRange<Self>) -> Self {
        var generator = SystemRandomNumberGenerator()
        return random(in: range, using: &generator)
    }

    // @documentation(SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - generator: The randomizer to use to generate the random value.
    @inlinable public static func random<R>(in range: Range<Self>, using generator: inout R) -> Self where R : RandomNumberGenerator {
        let scalar = Scalar.random(in: range.lowerBound.rawValue ..< range.upperBound.rawValue, using: &generator)
        return Self(rawValue: scalar)
    }

    // #documentation(SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    @inlinable public static func random<R>(in range: ClosedRange<Self>, using generator: inout R) -> Self where R : RandomNumberGenerator {
        let scalar = Scalar.random(in: range.lowerBound.rawValue ... range.upperBound.rawValue, using: &generator)
        return Self(rawValue: scalar)
    }
}
