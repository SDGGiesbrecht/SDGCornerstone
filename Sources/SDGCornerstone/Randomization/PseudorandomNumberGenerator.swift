/*
 PseudorandomNumberGenerator.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if os(Linux)
    import Glibc
#else
    import Foundation
#endif

/// A pseudorandom number generator.
///
/// Currently, `PseudorandomNumberGenerator` uses the [xoroshiro128+](https://en.wikipedia.org/wiki/Xoroshiro128%2B) algorithm designed by David Blackman and Sebastiano Vigna.
public final class PseudorandomNumberGenerator : Randomizer {

    /// The seed.
    public typealias Seed = (UInt64, UInt64)

    private var state: Seed

    /// An automatically seeded pseudorandom number generator for general use.
    ///
    /// - Note: If deterministic behaviour is needed, use `init(seed: Seed)` instead.
    public static let defaultGenerator: PseudorandomNumberGenerator = {
        return PseudorandomNumberGenerator(seed: generateSeed())
    }()

    #if os(Linux)
        private static var _linuxState: random_data = random_data()
        private static var __linuxStateStorage: [Int8] = Array(repeating: 0, count: 256) /* Must be static to persist under memory management. */
        private static let linuxIsSeeded: Bool = {
            // “static let” in order to be run only once.
            let instantInt: Int = time(nil)
            let instant: UInt32 = UInt32(truncatingBitPattern: instantInt)

            let storagePointer: UnsafeMutablePointer<Int8> = UnsafeMutablePointer(mutating: __linuxStateStorage)

            _ = initstate_r(instant, storagePointer, __linuxStateStorage.count, &_linuxState)

            return true
        }()
        private static var linuxState: random_data {
            get {
                if linuxIsSeeded {
                    return _linuxState
                } else {
                    preconditionFailure("Failed to seed BSD random number generator.")
                }
            }
            set {
                _linuxState = newValue
            }
        }
    #endif
    /// Returns a new, randomly generated seed.
    public static func generateSeed() -> Seed {
        func systemSpecificRandom() -> UInt32 {
            #if os(Linux)

                var result: Int32 = 0
                _ = random_r(&linuxState, &result) /* 0 ≤ x < 2 ↑ 31 */
                return UInt32(bitPattern: result)

            #else

                return arc4random()

            #endif
        }

        func generateHalf() -> UInt64 {

            var result = UInt64(systemSpecificRandom())
            result = result << 32
            result += UInt64(systemSpecificRandom())
            return result
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

    // [_Inherit Documentation: SDGCornerstone.Randomizer.randomNumber()_]
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
