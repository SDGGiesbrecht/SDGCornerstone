/*
 SDGConcurrencyAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import Dispatch

import SDGConcurrency

import XCTest

import SDGXCTestUtilities

class APITests: TestCase {

  @available(macOS 10.12, iOS 10, tvOS 10, *)  // @exempt(from: unicode)
  func testRunLoop() {
    var driver: RunLoop.Driver?

    let didRun = expectation(description: "Run loop ran.")
    let didStop = expectation(description: "Run loop exited.")

    DispatchQueue.global(qos: .userInitiated).async {
      let block = {
        didRun.fulfill()
        driver = nil
      }
      _ = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (_) -> Void in
        block()
      }

      RunLoop.current.runForDriver(
        { driver = $0 },
        withCleanUp: {
          didStop.fulfill()
        }
      )
    }
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNil(driver)
  }
}
