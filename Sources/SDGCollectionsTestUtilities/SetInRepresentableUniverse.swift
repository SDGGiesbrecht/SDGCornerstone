/*
 SetInRepresentableUniverse.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to SetInRepresentableUniverse.
@inlinable public func testSetInRepresentableUniverseConformance<T>(of type: T.Type, a: T.Element, b: T.Element, c: T.Element, file: StaticString = #file, line: UInt = #line) where T : SetInRepresentableUniverse, T.Element : Hashable {

    testMutableSetConformance(of: type, a: a, b: b, c: c, file: file, line: line)

    test(prefixOperator: (′, "′"), on: T(), returns: T.universe, file: file, line: line)
    test(postfixAssignmentOperator: (′=, "′="), with: T.universe, resultsIn: T(), file: file, line: line)
}
