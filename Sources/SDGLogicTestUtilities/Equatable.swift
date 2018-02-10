/*
 Equatable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGTesting

/// Tests a type’s conformance to equatable.
@_inlineable public func testEquatableConformance<T>(differingInstances: (T, T), file: StaticString = #file, line: UInt = #line) where T : Equatable {
    // [_Warning: These messages should be localized._]
    test(differingInstances.0 == differingInstances.0, "“\(differingInstances.0)” == “\(differingInstances.0)” → “\(false)”", file: file, line: line)
    test(¬(differingInstances.0 == differingInstances.1), "“\(differingInstances.0)” == “\(differingInstances.1)” → “\(true)”", file: file, line: line)
}
