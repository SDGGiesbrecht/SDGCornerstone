/*
 Randomizer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGTesting

/// Tests a type’s conformance to RandomNumberGenerator.
///
/// - Parameters:
///     - randomizer: A randomizer to test.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testRandomNumberGeneratorConformance<T>(
  of randomizer: T,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: RandomNumberGenerator {

  let range: ClosedRange<UInt64> = 0...10

  for _ in 1...10 {
    var generator = randomizer
    _ = generator.next()
    let random = UInt64.random(in: range, using: &generator)
    test(range.contains(random), "\(random) ∉ \(range)")
  }
}
