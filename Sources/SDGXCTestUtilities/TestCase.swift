/*
 TestCase.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogicCore
import SDGPersistence
import SDGTesting

/// A test case which simplifies testing for targets which link against the `SDGCornerstone` package.
open class TestCase : XCTestCase {

    static var initialized = false
    /// Provides an opportunity to reset state before each test method in a test case is called.
    ///
    /// - Note: Subclasses must call `super.setUp()`.
    open override func setUp() {
        if ¬TestCase.initialized {
            TestCase.initialized = true
            ProcessInfo.applicationIdentifier = "ca.solideogloria.SDGCornerstone.SharedTestingDomain"
        }

        testAssertionMethod = XCTAssert

        super.setUp()
    }
}
