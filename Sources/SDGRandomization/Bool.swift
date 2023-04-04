/*
 Bool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Bool {

  // MARK: - Randomization

  // #example(1, alternatingBooleans)
  /// A value a `Randomizer` can return that will result in `false`.
  ///
  /// For example:
  ///
  /// ```swift
  /// var alternating = CyclicalNumberGenerator([
  ///   Bool.falseRandomizerValue,
  ///   Bool.trueRandomizerValue,
  /// ])
  ///
  /// XCTAssertEqual(Bool.random(using: &alternating), false)
  /// XCTAssertEqual(Bool.random(using: &alternating), true)
  /// XCTAssertEqual(Bool.random(using: &alternating), false)
  /// XCTAssertEqual(Bool.random(using: &alternating), true)
  /// XCTAssertEqual(Bool.random(using: &alternating), false)
  /// XCTAssertEqual(Bool.random(using: &alternating), true)
  /// // ...
  /// ```
  public static let falseRandomizerValue: UInt64 = 1 << 17

  // #example(1, alternatingBooleans)
  /// A value a `Randomizer` can return that will result in `true`.
  ///
  /// For example:
  ///
  /// ```swift
  /// var alternating = CyclicalNumberGenerator([
  ///   Bool.falseRandomizerValue,
  ///   Bool.trueRandomizerValue,
  /// ])
  ///
  /// XCTAssertEqual(Bool.random(using: &alternating), false)
  /// XCTAssertEqual(Bool.random(using: &alternating), true)
  /// XCTAssertEqual(Bool.random(using: &alternating), false)
  /// XCTAssertEqual(Bool.random(using: &alternating), true)
  /// XCTAssertEqual(Bool.random(using: &alternating), false)
  /// XCTAssertEqual(Bool.random(using: &alternating), true)
  /// // ...
  /// ```
  public static let trueRandomizerValue: UInt64 = 0
}
