/*
 Equatable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import Foundation
#endif

import SDGTesting

/// Tests a type’s conformance to Equatable.
///
/// - Parameters:
///     - differingInstances: Two instances expected to be inequal.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testEquatableConformance<T>(
  differingInstances: (T, T),
  file: StaticString = #file,
  line: UInt = #line
) where T: Equatable {
  test(
    operator: (==, "=="),
    on: (differingInstances.0, differingInstances.0),
    returns: true,
    file: file,
    line: line
  )
  test(operator: (==, "=="), on: differingInstances, returns: false, file: file, line: line)
}
