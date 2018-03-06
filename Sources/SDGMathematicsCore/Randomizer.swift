/*
 Randomizer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A class that generates random numbers.
///
/// The definition of “random” is up to the particular conforming class. For example, instead of actual random numbers, a class could return a cyclical pattern or a single repeating value. This makes it easy to swap one class out for another, such as for testing or for distinct game modes.
///
/// For every SDG class that conforms to `Randomizer`, two independent instances that have been initialized the same way will return the same sequence of values.
///
/// For example, in a networked game, as long as each device initializes their instance of the `Randomizer` the same, each device can safely rely on its local instance to return the same values as are being returned on the other devices with no risk of the game states diverging.
///
/// - Warning: The above guarantee of deterministic behaviour does not apply between differing module versions.
///
/// - Note: Nothing in SDG relies on the above guarantee. If you make your own conforming class and do not need or want it to be deterministic, you can safely conform to `Randomizer` and use its interface anyway.
///
/// Conformance Requirements:
///
/// - `func randomNumber() -> UInt64`
public protocol Randomizer : class {

    // [_Define Documentation: SDGCornerstone.Randomizer.randomNumber()_]
    /// Returns a random value.
    ///
    /// - SeeAlso: `randomNumber(inRange:)`
    func randomNumber() -> SDGMathematicsCore.UIntMax

    // [_Define Documentation: SDGCornerstone.Randomizer.randomNumber(inRange:)_]
    /// Returns a random value within the specified range.
    ///
    /// The following information applies to the default implementation:
    ///
    /// - If the value returned by `randomNumber()` is in the allowed range, it will be returned unaltered.
    /// - If the value returned by `randomNumber()` is outside the allowed range, it will be mapped to a value in the allowed range.
    ///
    /// If `randomNumber()` returns every possible value of `UInt64` with equal probability, `randomNumber(inRange:)` will also return each of its possible values with equal probability. (Specifically, no modulo bias is introduced.)
    ///
    /// - Precondition: `randomNumber()` must eventually return a value in `range` or less than `UInt64.max.rounded(.down, toMultipleOf: UInt64(range.count))`.
    ///
    /// - Parameters:
    ///     - range: The range of acceptable values for the random number.
    func randomNumber(inRange range: ClosedRange<UIntMax>) -> UIntMax
}

extension Randomizer {

    // [_Inherit Documentation: SDGCornerstone.Randomizer.randomNumber(inRange:)_]
    /// Returns a random value within the specified range.
    ///
    /// The following information applies to the default implementation:
    ///
    /// - If the value returned by `randomNumber()` is in the allowed range, it will be returned unaltered.
    /// - If the value returned by `randomNumber()` is outside the allowed range, it will be mapped to a value in the allowed range.
    ///
    /// If `randomNumber()` returns every possible value of `UInt64` with equal probability, `randomNumber(inRange:)` will also return each of its possible values with equal probability. (Specifically, no modulo bias is introduced.)
    ///
    /// - Precondition: `randomNumber()` must eventually return a value in `range` or less than `UInt64.max.rounded(.down, toMultipleOf: UInt64(range.count))`.
    ///
    /// - Parameters:
    ///     - range: The range of acceptable values for the random number.
    @_inlineable public func randomNumber(inRange range: ClosedRange<UIntMax>) -> UIntMax {

        var unboundedRandom = randomNumber()

        if range.contains(unboundedRandom) {
            // Valid, return as‐is.
            return unboundedRandom

        } else {
            // Remove valid range.

            let rangeSize = UIntMax(range.count)

            let unboundedMaximum: UIntMax = UIntMax.max − rangeSize
            if unboundedRandom > range.upperBound {
                unboundedRandom −= rangeSize
            }

            // Catch modulo bias.

            let firstBiasedValue = unboundedMaximum.rounded(.down, toMultipleOf: rangeSize)
            if unboundedRandom ≥ firstBiasedValue {
                // Try again.
                return randomNumber(inRange: range)
            } else {

                // Return remainder.

                let remainder = unboundedRandom.mod(rangeSize)
                return range.lowerBound + remainder
            }
        }
    }
}
