/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension FloatFamily {

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    @_transparent public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {

        // 0 ..< UInt64.max
        let random: UInt64 = randomizer.randomNumber()

        // 0 ..< 1
        let converted = Self(random) ÷ Self(UInt64.max)

        // lowerBound ..< upperBound
        self = range.lowerBound + ((range.upperBound − range.lowerBound) × converted)
    }
}


extension Double : RandomizableNumber {}
#if !os(Linux)
    // MARK: - #if !os(Linux)
    extension CGFloat : RandomizableNumber {}
#endif
#if !(os(iOS) || os(watchOS) || os(tvOS))
    // MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))
    extension Float80 : RandomizableNumber {}
#endif
extension Float : RandomizableNumber {}
