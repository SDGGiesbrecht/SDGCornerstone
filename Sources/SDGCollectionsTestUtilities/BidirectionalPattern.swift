/*
 BidirectionalPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGTesting

/// Tests a type that conforms to BidirectionalPattern.
///
/// - Parameters:
///     - pattern: A pattern.
///     - match: A collection expected to match the pattern exactly.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testBidirectionalPattern<P>(
  _ pattern: P,
  match: P.Searchable,
  file: StaticString = #filePath,
  line: UInt = #line
) where P: BidirectionalPattern {
  testPattern(pattern, match: match)

  let reversedMatch: ReversedCollection<P.Searchable> = match.reversed()
  #warning("Not implemented yet.")
  fatalError()
  /*let result3 = pattern.reversed().primaryMatch(in: reversedMatch, at: reversedMatch.startIndex)
  test(
    result3?.range == reversedMatch.bounds,
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(pattern).reversed().primaryMatch(in: \(reversedMatch), at: \(reversedMatch.startIndex)) → \(String(describing: result3)) ≠ \(reversedMatch.bounds)"
    }(),
    file: file,
    line: line
  )

  if let result3 = result3 {
    test(
      pattern.forward(match: result3, in: match).range == match.bounds,
      {  // @exempt(from: tests)
        return  // @exempt(from: tests)
          "\(pattern).forward(match: \(result3), in: \(match)) → \(pattern.forward(match: result3, in: match)) ≠ \(match.bounds)"
      }(),
      file: file,
      line: line
    )
  }*/
}
