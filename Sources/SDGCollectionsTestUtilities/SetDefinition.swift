/*
 SetDefinition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGTesting

/// Tests a type’s conformance to SetDefinition.
///
/// - Parameters:
///     - set: A set.
///     - member: A member of the set.
///     - nonmember: A nonmember of the set.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testSetDefinitionConformance<T>(
  of set: T,
  member: T.Element,
  nonmember: T.Element,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: SetDefinition {

  test(operator: (∈, "∈"), on: (member, set), returns: true, file: file, line: line)
  test(operator: (∉, "∉"), on: (member, set), returns: false, file: file, line: line)
  test(operator: (∋, "∋"), on: (set, member), returns: true, file: file, line: line)
  test(operator: (∌, "∌"), on: (set, member), returns: false, file: file, line: line)

  test(operator: (∈, "∈"), on: (nonmember, set), returns: false, file: file, line: line)
  test(operator: (∉, "∉"), on: (nonmember, set), returns: true, file: file, line: line)
  test(operator: (∋, "∋"), on: (set, nonmember), returns: false, file: file, line: line)
  test(operator: (∌, "∌"), on: (set, nonmember), returns: true, file: file, line: line)
}
