/*
 EnumerationTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import SDGCornerstone

class EnumerationTests : TestCase {

    func testIterableEnumeration() {
        XCTAssert(IterableEnumerationExample.cases.count == 3)
    }

    func testOrderedEnumeration() {
        XCTAssert(OrderedEnumerationExample.a.cyclicSuccessor() == OrderedEnumerationExample.b)
        XCTAssert(OrderedEnumerationExample.c.cyclicPredecessor() == OrderedEnumerationExample.b)
        XCTAssert(OrderedEnumerationExample.a.cyclicPredecessor() == OrderedEnumerationExample.c)
        XCTAssert(OrderedEnumerationExample.c.cyclicSuccessor() == OrderedEnumerationExample.a)
        XCTAssert(OrderedEnumerationExample.a < OrderedEnumerationExample.b)
    }

    static var allTests: [(String, (EnumerationTests) -> () throws -> Void)] {
        return [
            ("testIterableEnumeration", testIterableEnumeration),
            ("testOrderedEnumeration", testOrderedEnumeration)
        ]
    }
}
