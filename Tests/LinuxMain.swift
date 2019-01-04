/*
 LinuxMain.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstoneDocumentationExampleTests
import SDGBinaryDataTests
import SDGCalendarTests
import SDGCollectionsTests
import SDGConcurrencyTests
import SDGControlFlowTests
import SDGExternalProcessTests
import SDGGeometryTests
import SDGLocalizationTests
import SDGLogicTests
import SDGMathematicsTests
import SDGPersistenceTests
import SDGPrecisionMathematicsTests
import SDGRandomizationTests
import SDGTextTests
import SDGXCTestUtilities

var tests = [XCTestCaseEntry]()
tests += SDGCornerstoneDocumentationExampleTests.__allTests()
tests += SDGBinaryDataTests.__allTests()
tests += SDGCalendarTests.__allTests()
tests += SDGCollectionsTests.__allTests()
tests += SDGConcurrencyTests.__allTests()
tests += SDGControlFlowTests.__allTests()
tests += SDGExternalProcessTests.__allTests()
tests += SDGGeometryTests.__allTests()
tests += SDGLocalizationTests.__allTests()
tests += SDGLogicTests.__allTests()
tests += SDGMathematicsTests.__allTests()
tests += SDGPersistenceTests.__allTests()
tests += SDGPrecisionMathematicsTests.__allTests()
tests += SDGRandomizationTests.__allTests()
tests += SDGTextTests.__allTests()

XCTMain(tests)
