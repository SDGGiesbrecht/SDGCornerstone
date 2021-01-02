/*
 TestCase.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

  import XCTest

  import SDGLogic
  import SDGPersistence
  import SDGTesting

  /// A test case which simplifies testing for targets which link against the `SDGCornerstone` package.
  open class TestCase: XCTestCase {

    private static var initialized = false
    open override func setUp() {
      if ¬TestCase.initialized {
        TestCase.initialized = true
        #if !os(WASI)  // #workaround(Swift 5.3.1, ProcessInfo unavailable.)
          ProcessInfo.applicationIdentifier =
            "ca.solideogloria.SDGCornerstone.SharedTestingDomain"
        #endif
      }

      testAssertionMethod = XCTAssert

      #if !os(WASI)  // #workaround(Swift 5.3.1, Thread unavailable.)
        // The default of .userInteractive is absurd.
        Thread.current.qualityOfService = .utility
      #endif

      super.setUp()
    }
  }

#endif
