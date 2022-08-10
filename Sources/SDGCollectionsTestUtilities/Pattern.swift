/*
 Pattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGTesting

/// Tests a type that conforms to Pattern.
///
/// - Parameters:
///     - pattern: A pattern.
///     - match: A collection expected to match the pattern exactly.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testPattern<P>(
  _ pattern: P,
  match: P.Searchable,
  file: StaticString = #filePath,
  line: UInt = #line
) where P: Pattern {

  let result = pattern.matches(in: match, at: match.startIndex).first
  test(
    result?.range == match.bounds,
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(pattern).matches(in: \(match), at: \(match.startIndex)).first → \(String(describing: result)) ≠ \(match.bounds)"
    }(),
    file: file,
    line: line
  )

  let result2 = pattern.primaryMatch(in: match, at: match.startIndex)
  test(
    result2?.range == match.bounds,
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(pattern).primaryMatch(in: \(match), at: \(match.startIndex)) → \(String(describing: result2)) ≠ \(match.bounds)"
    }(),
    file: file,
    line: line
  )

  let result3 = pattern.forSubSequence().primaryMatch(in: match[...], at: match.startIndex)
  test(
    result3?.range == match.bounds,
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(pattern).forSubSequence().primaryMatch(in: \(match)[...], at: \(match.startIndex)) → \(String(describing: result3)) ≠ \(match.bounds)"
    }(),
    file: file,
    line: line
  )

  if let result3 = result3 {
    let result4 = pattern.convertMatch(from: result3, in: match)
    test(
      result4.range == match.bounds,
      {  // @exempt(from: tests)
        return  // @exempt(from: tests)
          "\(pattern).convertMatch(from: \(result3), in: \(match)) → \(String(describing: result4)) ≠ \(match.bounds)"
      }(),
      file: file,
      line: line
    )
  }
}
