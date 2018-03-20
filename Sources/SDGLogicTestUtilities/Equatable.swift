/*
 Equatable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// Tests a type’s conformance to Equatable.
@_inlineable public func testEquatableConformance<T>(differingInstances: (T, T), file: StaticString = #file, line: UInt = #line) where T : Equatable {
    test(operator: (==, "=="), on: (differingInstances.0, differingInstances.0), returns: true, file: file, line: line)
    test(operator: (==, "=="), on: differingInstances, returns: false, file: file, line: line)
}
