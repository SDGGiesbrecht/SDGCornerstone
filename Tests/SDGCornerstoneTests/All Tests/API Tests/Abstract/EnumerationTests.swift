/*
 EnumerationTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import SDGCornerstone

class EnumerationTests : TestCase {

    func testIterableEnumeration() {
        XCTAssertEqual(IterableEnumerationExample.cases.count, 3)
    }

    func testOrderedEnumeration() {
        XCTAssertEqual(OrderedEnumerationExample.a.cyclicSuccessor(), OrderedEnumerationExample.b)
        XCTAssertEqual(OrderedEnumerationExample.c.cyclicPredecessor(), OrderedEnumerationExample.b)
        XCTAssertEqual(OrderedEnumerationExample.a.cyclicPredecessor(), OrderedEnumerationExample.c)
        XCTAssertEqual(OrderedEnumerationExample.c.cyclicSuccessor(), OrderedEnumerationExample.a)
        XCTAssert(OrderedEnumerationExample.a < OrderedEnumerationExample.b)

        var weekday = GregorianWeekday.tuesday
        weekday.increment()
        XCTAssertEqual(weekday, .wednesday)
        weekday.decrement()
        XCTAssertEqual(weekday, .tuesday)
        XCTAssertEqual(weekday.successor(), .wednesday)
    }

    static var allTests: [(String, (EnumerationTests) -> () throws -> Void)] {
        return [
            ("testIterableEnumeration", testIterableEnumeration),
            ("testOrderedEnumeration", testOrderedEnumeration)
        ]
    }
}
