/*
 ConcurrencyTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

import SDGXCTestUtilities

class ConcurrencyTests : TestCase {

    func testConcurrency() {
        let foregroundRan = expectation(description: "Foreground ran.")
        let backgroundRan = expectation(description: "Background ran.")
        let testQueueRan = expectation(description: "Test queue ran.")

        foreground.finish {
            foregroundRan.fulfill()
            XCTAssert(executing(in: foreground))
            if executing(in: foreground) {
                assert(in: foreground)
            }
        }
        background.finish {
            backgroundRan.fulfill()
            XCTAssert(executing(in: background))
            if executing(in: background) {
                assert(in: background)
            }
        }
        OperationQueue(label: "Test Queue", serial: true).start {
            testQueueRan.fulfill()
            XCTAssert(OperationQueue.current?.isSerial == true)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRunLoop() {
        var driver: RunLoop.Driver?

        let didRun = expectation(description: "Run loop ran.")
        let didStop = expectation(description: "Run loop exited.")

        background.start {
            let block = {
                didRun.fulfill()
                driver = nil
            }
            #if os(macOS)
                // [_Workaround: Swift’s Xcode project generation targets 10.10. (Swift 4.0.3)_]
                Timer.scheduledTimer(timeInterval: 0, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
            #else
                _ = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (_) -> Void in
                    block()
                }
            #endif

            RunLoop.current.runForDriver({ driver = $0 }, withCleanUp: {
                didStop.fulfill()
            })
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(driver)
    }

    static var allTests: [(String, (ConcurrencyTests) -> () throws -> Void)] {
        return [
            ("testConcurrency", testConcurrency),
            ("testRunLoop", testRunLoop)
        ]
    }
}
