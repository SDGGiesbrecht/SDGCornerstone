/*
 ReferenceTests.swift

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

class ReferenceTests : TestCase {

    func testShared() {
        var shared: Shared<Int>? = Shared(1)
        weak var weakShared = shared
        XCTAssert(shared?.value == 1)

        var observer1: SharedValueObserverExample? = SharedValueObserverExample(shared!, normalizing: false)
        weak var weakObserver1 = observer1
        XCTAssert(observer1?.lastReportedValue == 1)

        shared?.value = 2
        XCTAssert(shared?.value == 2)
        XCTAssert(observer1?.lastReportedValue == 2)

        var observer2: SharedValueObserverExample? = SharedValueObserverExample(shared!, normalizing: true)
        weak var weakObserver2 = observer2
        XCTAssert(shared?.value == 0)
        XCTAssert(observer1?.lastReportedValue == 0)
        XCTAssert(observer2?.lastReportedValue == 0)

        shared?.value = 3
        XCTAssert(shared?.value == 0)
        XCTAssert(observer1?.lastReportedValue == 0)
        XCTAssert(observer2?.lastReportedValue == 0)

        observer2 = nil
        XCTAssert(shared?.value == 0)
        XCTAssert(observer1?.lastReportedValue == 0)
        XCTAssert(weakObserver2 == nil)

        shared?.value = 4
        XCTAssert(shared?.value == 4)
        XCTAssert(observer1?.lastReportedValue == 4)

        observer1 = nil
        XCTAssert(shared?.value == 4)
        XCTAssert(weakObserver1 == nil)

        shared?.value = 5
        XCTAssert(shared?.value == 5)

        shared = nil
        XCTAssert(weakShared == nil)

        shared = Shared(6)
        XCTAssert(shared?.value == 6)

        observer1 = SharedValueObserverExample(shared!, normalizing: false)
        XCTAssert(shared?.value == 6)
        XCTAssert(observer1?.lastReportedValue == 6)

        shared?.cancel(observer: observer1!)
        XCTAssert(shared?.value == 6)
        XCTAssert(observer1?.lastReportedValue == 6)

        shared?.value = 7
        XCTAssert(shared?.value == 7)
        XCTAssert(observer1?.lastReportedValue == 6)
    }

    func testWeak() {
        var pointee: NSObject? = NSObject()

        let reference = Weak(pointee)
        XCTAssert(reference.pointee ≠ nil)

        pointee = nil
        XCTAssert(reference.pointee == nil)
    }

    static var allTests: [(String, (ReferenceTests) -> () throws -> Void)] {
        return [
            ("testShared", testShared),
            ("testWeak", testWeak)
        ]
    }
}
