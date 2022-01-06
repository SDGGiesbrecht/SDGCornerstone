/*
 Hashable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogicTestUtilities

/// Tests a type’s conformance to Hashable.
///
/// - Parameters:
///     - differingInstances: Two instances expected to be inequal.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testHashableConformance<T>(
  differingInstances: (T, T),
  file: StaticString = #filePath,
  line: UInt = #line
) where T: Hashable {
  var hasher = Hasher()
  testEquatableConformance(differingInstances: differingInstances, file: file, line: line)
  differingInstances.0.hash(into: &hasher)
}
