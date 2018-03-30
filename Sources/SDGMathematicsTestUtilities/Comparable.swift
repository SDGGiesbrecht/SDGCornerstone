/*
 Comparable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to Comparable.
@_inlineable public func testComparableConformance<T>(less: T, greater: T, file: StaticString = #file, line: UInt = #line) where T : Comparable {
    test(operator: (<, "<"), on: (less, greater), returns: true, file: file, line: line)
    test(operator: (<, "<"), on: (greater, less), returns: false, file: file, line: line)
    test(operator: (<, "<"), on: (less, less), returns: false, file: file, line: line)
}
