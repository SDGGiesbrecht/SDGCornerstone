/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
import CoreGraphics
#endif

import SDGMathematics

extension FloatFamily {

    // #documentation(SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:))
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {

        // 0 ..< UInt64.max
        let random: UInt64 = randomizer.randomNumber()

        // 0 ..< 1
        let converted = Self(random) ÷ Self(UInt64.max)

        // lowerBound ..< upperBound
        let rangeSize: Self = range.upperBound − range.lowerBound
        self = range.lowerBound + (rangeSize × converted)
    }
}

extension Double : RandomizableNumber {}
#if canImport(CoreGraphics)
// MARK: - #if canImport(CoreGraphics)
extension CGFloat : RandomizableNumber {}
#endif
#if !(os(iOS) || os(watchOS) || os(tvOS))
// MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))
// #workaround(Swift 4.1.2, Probably available in Swift 4.2.)
extension Float80 : RandomizableNumber {}
#endif
extension Float : RandomizableNumber {}
