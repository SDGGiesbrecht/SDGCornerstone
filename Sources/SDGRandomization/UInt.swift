/*
 UInt.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension UIntFamily {

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let value = UIntMax(randomInRange: UIntMax(range.lowerBound) ... UIntMax(range.upperBound), fromRandomizer: randomizer)
        self.init(value)
    }
}

extension UIntMax {

    // MARK: - RandomizableNumber

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<UIntMax>, fromRandomizer randomizer: Randomizer) {
        self = randomizer.randomNumber(inRange: range)
    }
}

extension UInt : RandomizableNumber {}
extension UInt64 : RandomizableNumber {}
extension UInt32 : RandomizableNumber {}
extension UInt16 : RandomizableNumber {}
extension UInt8 : RandomizableNumber {}
