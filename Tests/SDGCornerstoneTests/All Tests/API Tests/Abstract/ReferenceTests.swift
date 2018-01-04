/*
 ReferenceTests.swift

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

class ReferenceTests : TestCase {

    func testShared() {
        var shared: Shared<Int>? = Shared(1)
        weak var weakShared = shared
        XCTAssertEqual(shared?.value, 1)

        var observer1: SharedValueObserverExample? = SharedValueObserverExample(shared!, normalizing: false)
        weak var weakObserver1 = observer1
        XCTAssertEqual(observer1?.lastReportedValue, 1)

        shared?.value = 2
        XCTAssertEqual(shared?.value, 2)
        XCTAssertEqual(observer1?.lastReportedValue, 2)

        var observer2: SharedValueObserverExample? = SharedValueObserverExample(shared!, normalizing: true)
        weak var weakObserver2 = observer2
        XCTAssertEqual(shared?.value, 0)
        XCTAssertEqual(observer1?.lastReportedValue, 0)
        XCTAssertEqual(observer2?.lastReportedValue, 0)

        shared?.value = 3
        XCTAssertEqual(shared?.value, 0)
        XCTAssertEqual(observer1?.lastReportedValue, 0)
        XCTAssertEqual(observer2?.lastReportedValue, 0)

        observer2 = nil
        XCTAssertEqual(shared?.value, 0)
        XCTAssertEqual(observer1?.lastReportedValue, 0)
        XCTAssertNil(weakObserver2)

        shared?.value = 4
        XCTAssertEqual(shared?.value, 4)
        XCTAssertEqual(observer1?.lastReportedValue, 4)

        observer1 = nil
        XCTAssertEqual(shared?.value, 4)
        XCTAssertNil(weakObserver1)

        shared?.value = 5
        XCTAssertEqual(shared?.value, 5)

        shared = nil
        XCTAssertNil(weakShared)

        shared = Shared(6)
        XCTAssertEqual(shared?.value, 6)

        observer1 = SharedValueObserverExample(shared!, normalizing: false)
        XCTAssertEqual(shared?.value, 6)
        XCTAssertEqual(observer1?.lastReportedValue, 6)

        shared?.cancel(observer: observer1!)
        XCTAssertEqual(shared?.value, 6)
        XCTAssertEqual(observer1?.lastReportedValue, 6)

        shared?.value = 7
        XCTAssertEqual(shared?.value, 7)
        XCTAssertEqual(observer1?.lastReportedValue, 6)
    }

    func testWeak() {
        var pointee: NSObject? = NSObject()

        let reference = Weak(pointee)
        XCTAssertNotNil(reference.pointee)

        pointee = nil
        XCTAssertNil(reference.pointee)
    }

    static var allTests: [(String, (ReferenceTests) -> () throws -> Void)] {
        return [
            ("testShared", testShared),
            ("testWeak", testWeak)
        ]
    }
}
