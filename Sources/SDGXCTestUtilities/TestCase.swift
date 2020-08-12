/*
 TestCase.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

  // #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
  #if !os(WASI)
    // #workaround(workspace version 0.34.0, The generated Xcode project cannot import XCTest on iOS devices.)
    #if !Xcode || MANIFEST_LOADED_BY_XCODE || !(os(iOS) || os(tvOS)) || targetEnvironment(simulator)
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
            ProcessInfo.applicationIdentifier =
              "ca.solideogloria.SDGCornerstone.SharedTestingDomain"
          }

          testAssertionMethod = XCTAssert

          // The default of .userInteractive is absurd.
          Thread.current.qualityOfService = .utility

          super.setUp()
        }
      }

    #endif
  #endif
#endif
