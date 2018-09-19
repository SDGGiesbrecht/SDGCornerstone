/*
 Bool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Bool {

    // MARK: - Randomization

    private static let randomizationBit: UInt64 = 1 << 48

    // #example(1, alternatingBooleans)
    /// A value a `Randomizer` can return that will result in `false`.
    ///
    /// For example:
    ///
    /// ```swift
    /// let alternating = CyclicalNumberGenerator([
    ///     Bool.falseRandomizerValue,
    ///     Bool.trueRandomizerValue
    ///     ])
    ///
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// // ...
    /// ```
    public static let falseRandomizerValue: UInt64 = 0

    // #example(1, alternatingBooleans)
    /// A value a `Randomizer` can return that will result in `true`.
    ///
    /// For example:
    ///
    /// ```swift
    /// let alternating = CyclicalNumberGenerator([
    ///     Bool.falseRandomizerValue,
    ///     Bool.trueRandomizerValue
    ///     ])
    ///
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// // ...
    /// ```
    public static let trueRandomizerValue: UInt64 = randomizationBit

    /// Creates a random Boolean value derived from a particular randomizer.
    ///
    /// - Parameters:
    ///     - randomizer: The randomizer.
    public init(fromRandomizer randomizer: Randomizer) {
        self = randomizer.randomNumber().bitwiseAnd(with: Bool.randomizationBit) == Bool.randomizationBit
    }
}
