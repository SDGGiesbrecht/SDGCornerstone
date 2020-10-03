/*
 Comparable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGTesting

/// Tests a type’s conformance to Comparable.
///
/// - Parameters:
///     - less: A comparable instance.
///     - greater: Another instance greater than `less`.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testComparableConformance<T>(
  less: T,
  greater: T,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: Comparable {
  test(operator: (<, "<"), on: (less, greater), returns: true, file: file, line: line)
  test(operator: (<, "<"), on: (greater, less), returns: false, file: file, line: line)
  test(operator: (<, "<"), on: (less, less), returns: false, file: file, line: line)
}
