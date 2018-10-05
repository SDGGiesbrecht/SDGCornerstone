/*
 PseudorandomNumberGenerator.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(Glibc)
import Glibc
#endif

import SDGControlFlow
import SDGMathematics

/// A pseudorandom number generator.
///
/// Two independent instances that have been initialized the same way will return the same sequence of values. For example, in a networked game, as long as each device initializes their instance of the `PseudorandomNumberGenerator` the same, each device can safely rely on its local instance to return the same values as are being returned on the other devices with no risk of the game states diverging.
///
/// - Warning: The above guarantee of deterministic behaviour does not apply between differing module versions.
///
/// Currently, `PseudorandomNumberGenerator` uses the [xoroshiro128+](https://en.wikipedia.org/wiki/Xoroshiro128%2B) algorithm designed by David Blackman and Sebastiano Vigna.
public final class PseudorandomNumberGenerator : RandomNumberGenerator {

    /// The seed.
    public typealias Seed = (UInt64, UInt64)

    private var state: Seed

    /// Returns a new, randomly generated seed.
    public static func generateSeed() -> Seed {
        func generateHalf() -> UInt64 {
            return UInt64.random(in: UInt64.min ... UInt64.max)
        }
        return (generateHalf(), generateHalf())
    }

    /// Creates a pseudorandom number generator with a specific seed.
    ///
    /// - Parameters:
    ///     - seed: The seed.
    public init(seed: Seed) {
        self.state = seed
        _ = randomNumber() // Step away from seed itself.
    }

    // MARK: - Randomizer

    // #documentation(SDGCornerstone.Randomizer.randomNumber())
    /// Returns a random value.
    ///
    /// - SeeAlso: `randomNumber(inRange:)`
    public func randomNumber() -> UIntMax {

        // This is derived from the C code of David Blackman and Sebastiano Vigna’s xoroshiro128+ algorithm, which they have dedicated to the public domain. (retrieved on 2016‐12‐08 from http://vigna.di.unimi.it/xorshift/xoroshiro128plus.c)

        let result = state.0 &+ state.1

        state.1.formBitwiseExclusiveOr(with: state.0)

        func bits(of value: UInt64, rotatedLeft distance: UInt64) -> UInt64 {
            return (value << distance).bitwiseOr(with: value >> (64 − distance))
        }
        state.0 = bits(of: state.0, rotatedLeft: 55).bitwiseExclusiveOr(with: state.1).bitwiseExclusiveOr(with: state.1 << 14)
        state.1 = bits(of: state.1, rotatedLeft: 36)

        return result
    }
}
