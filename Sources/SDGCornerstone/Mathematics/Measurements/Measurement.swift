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

public protocol Measurement : MeasurementCore where Scalar : RationalArithmetic {

    // MARK: - Randomization

    // [_Define Documentation: SDGCornerstone.Measurement.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: Range<Self>)

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: ClosedRange<Self>)

    // [_Define Documentation: SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer)

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)
}

// [_Workaround: In Swift 4.1, this can be just “extension Measurement {” (Swift 4.1)_]
extension MeasurementCore where Scalar : RationalArithmetic {

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: Range<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: ClosedRange<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer) {
        let scalar = Scalar(randomInRange: range.lowerBound.rawValue ..< range.upperBound.rawValue, fromRandomizer: randomizer)
        self.init(rawValue: scalar)
    }

    // [_Inherit Documentation: SDGCornerstone.Measurement.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let scalar = Scalar(randomInRange: range.lowerBound.rawValue ... range.upperBound.rawValue, fromRandomizer: randomizer)
        self.init(rawValue: scalar)
    }
}
