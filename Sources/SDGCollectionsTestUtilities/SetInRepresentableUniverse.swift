/*
 SetInRepresentableUniverse.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGTesting

/// Tests a type’s conformance to SetInRepresentableUniverse.
///
/// - Parameters:
///     - type: The type.
///     - a: An element.
///     - b: Another, distinct element.
///     - c: Yet another distinct element.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testSetInRepresentableUniverseConformance<T>(
  of type: T.Type,
  a: T.Element,
  b: T.Element,
  c: T.Element,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: SetInRepresentableUniverse, T.Element: Hashable {

  testMutableSetConformance(of: type, a: a, b: b, c: c, file: file, line: line)

  test(prefixOperator: (′, "′"), on: T(), returns: T.universe, file: file, line: line)
  test(
    postfixAssignmentOperator: (′=, "′="),
    with: T.universe,
    resultsIn: T(),
    file: file,
    line: line
  )
}
