/*
 SetDefinition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to SetDefinition.
@inlinable public func testSetDefinitionConformance<T>(of set: T, member: T.Element, nonmember: T.Element, file: StaticString = #file, line: UInt = #line) where T : SetDefinition {

    test(operator: (∈, "∈"), on: (member, set), returns: true, file: file, line: line)
    test(operator: (∉, "∉"), on: (member, set), returns: false, file: file, line: line)
    test(operator: (∋, "∋"), on: (set, member), returns: true, file: file, line: line)
    test(operator: (∌, "∌"), on: (set, member), returns: false, file: file, line: line)

    test(operator: (∈, "∈"), on: (nonmember, set), returns: false, file: file, line: line)
    test(operator: (∉, "∉"), on: (nonmember, set), returns: true, file: file, line: line)
    test(operator: (∋, "∋"), on: (set, nonmember), returns: false, file: file, line: line)
    test(operator: (∌, "∌"), on: (set, nonmember), returns: true, file: file, line: line)
}
