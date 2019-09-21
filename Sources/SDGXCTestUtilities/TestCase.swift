/*
 TestCase.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(XCTest) && (!(os(watchOS) || os(tvOS)) || targetEnvironment(simulator)) // XCTest does not contain bitcode.

import XCTest

import SDGLogic
import SDGPersistence
import SDGTesting

/// A test case which simplifies testing for targets which link against the `SDGCornerstone` package.
open class TestCase : XCTestCase {

    static var initialized = false
    open override func setUp() {
        if ¬TestCase.initialized {
            TestCase.initialized = true
            ProcessInfo.applicationIdentifier = "ca.solideogloria.SDGCornerstone.SharedTestingDomain"
        }

        testAssertionMethod = XCTAssert

        #if !os(Linux) // #workaround(Swift 5.1, Linux will gain this property in 5.2.)
        Thread.current.qualityOfService = .utility // The default of .userInteractive is absurd.
        #endif

        super.setUp()
    }
}

#endif
