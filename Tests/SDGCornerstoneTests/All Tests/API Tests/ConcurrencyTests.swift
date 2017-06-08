/*
 ConcurrencyTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

class ConcurrencyTests : TestCase {

    func testConcurrency() {
        #if !os(Linux) && !LinuxDocs
            // [_Workaround: Linux cannot reliably get the current queue. (Swift 3.1.0)_]
            let foregroundRan = expectation(description: "Foreground ran.")
            let backgroundRan = expectation(description: "Background ran.")
        #endif
        let testQueueRan = expectation(description: "Test queue ran.")

        #if !os(Linux) && !LinuxDocs
            // [_Workaround: Linux cannot reliably get the current queue. (Swift 3.1.0)_]
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
        #endif
        OperationQueue(label: "Test Queue", serial: true).start {
            testQueueRan.fulfill()
            #if !os(Linux) && !LinuxDocs
                // [_Workaround: Linux cannot reliably get the current queue. (Swift 3.1.0)_]
                XCTAssert(OperationQueue.current?.isSerial == true)
            #endif
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRunLoop() {
        var driver: RunLoop.Driver?

        let didRun = expectation(description: "Run loop ran.")
        let didStop = expectation(description: "Run loop exited.")

        background.start() {
            let block = {
                didRun.fulfill()
                driver = nil
            }
            #if os(macOS)
                // [_Workaround: Swift’s Xcode project generation targets 10.10. (Swift 3.1.0)_]
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
        XCTAssert(driver == nil)
    }

    static var allTests: [(String, (ConcurrencyTests) -> () throws -> Void)] {
        return [
            ("testConcurrency", testConcurrency),
            ("testRunLoop", testRunLoop)
        ]
    }
}
