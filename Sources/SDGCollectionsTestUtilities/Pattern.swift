/*
 Pattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGTesting

/// Tests a subclass of Pattern.
///
/// - Parameters:
///     - pattern: A pattern.
///     - match: A collection expected to match the pattern exactly.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testPattern<P, C>(_ pattern: P, match: C, file: StaticString = #file, line: UInt = #line)
    where P : Pattern, C : SearchableCollection, C.Element == P.Element {

        let result = pattern.matches(in: match, at: match.startIndex).first
        test(result == match.bounds, "\(pattern).matches(in: \(match), at: \(match.startIndex)).first → \(String(describing: result)) ≠ \(match.bounds)", file: file, line: line)

        let result2 = pattern.primaryMatch(in: match, at: match.startIndex)
        test(result2 == match.bounds, "\(pattern).primaryMatch(in: \(match), at: \(match.startIndex)) → \(String(describing: result2)) ≠ \(match.bounds)", file: file, line: line)

        let reversedMatch: [C.Element] = match.reversed()
        let result3 = pattern.reversed().primaryMatch(in: reversedMatch, at: reversedMatch.startIndex)
        test(result3 == reversedMatch.bounds, "\(pattern).reversed().primaryMatch(in: \(reversedMatch), at: \(reversedMatch.startIndex)) → \(String(describing: result3)) ≠ \(reversedMatch.bounds)", file: file, line: line)
}
