/*
 RunLoopExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGCornerstone

class RunLoopExampleTests : TestCase {

    func testRunLoopUsage() {

        // [_Define Example: Run Loop Usage_]
        var driver: RunLoop.Driver?
        background.start {
            RunLoop.current.runForDriver { driver = $0 }
        }
        // The background run loop is now running.

        driver = nil
        // The background run loop has now stopped.
        // [_End_]

        XCTAssertNil(driver)
    }

    static var allTests: [(String, (RunLoopExampleTests) -> () throws -> Void)] {
        return [
            ("testRunLoopUsage", testRunLoopUsage)
        ]
    }
}
