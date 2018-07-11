/*
 Exports.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(XCTest) && (!(os(iOS) || os(watchOS) || os(tvOS)) || targetEnvironment(simulator)) // XCTest does not contain bitcode.
@_exported import XCTest
#endif

func aFunctionToTriggerTestCoverage() {} // @exempt(from: tests)
