/*
 InternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

@testable import SDGCornerstone

class InternalTests : XCTestCase {

    func testUIntHalvesView() {
        XCTAssert((0 as UInt).halves.index(before: 1) == 0)
    }

    func testUserDefaults() {
        #if !os(Linux)

            let testKey = "SDGTestKey"

            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: testKey)
            XCTAssert(defaults.object(forKey: testKey) == nil, "Unexpected value: \(String(describing: defaults.object(forKey: testKey))) ≠ nil")

            let shared = UserDefaults.standard.sharedValue(forKey: testKey)
            XCTAssert(shared.value == nil, "Unexpected shared value: \(String(describing: shared.value)) ≠ nil")

            defaults.set(true, forKey: testKey)
            XCTAssert(defaults.bool(forKey: testKey) == true, "Bindings failed: \(defaults.bool(forKey: testKey)) ≠ true")
            XCTAssert(shared.value as? Bool == true, "Bindings failed: \(String(describing: shared.value as? Bool)) ≠ true")

            defaults.set("A", forKey: testKey)
            XCTAssert(defaults.string(forKey: testKey) == "A")
            XCTAssert(shared.value as? String == "A")

            shared.value = 10
            XCTAssert(shared.value as? Int == 10, "Unexpected shared value: \(String(describing: shared.value)) ≠ 10")
            XCTAssert(defaults.integer(forKey: testKey) == 10, "Unexpected value: \(String(describing: defaults.object(forKey: testKey))) ≠ 10")

            shared.value = nil
            XCTAssert(shared.value == nil, "Unexpected shared value: \(String(describing: shared.value)) ≠ nil")
            XCTAssert(defaults.object(forKey: testKey) == nil, "Unexpected value: \(String(describing: defaults.object(forKey: testKey))) ≠ nil")

            defaults.removeObject(forKey: testKey)

        #endif
    }

    func testWholeNumberBinaryView() {
        XCTAssert((WholeNumber.BinaryView.Index(digit: 1, bit: 0) − WholeNumber.BinaryView.Index(digit: 0, bit: 63)).digitDistance == 0)

        var index = WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 0)
        index += 1
        XCTAssert(index == WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 1))

        index += WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: BinaryView<WholeNumber.Digit>.count − 1)
        XCTAssert(index == WholeNumber.BinaryView.IndexDistance(digitDistance: 1, bitDistance: 0))

        index −= WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 1)
        XCTAssert(index.digitDistance == 0)

        XCTAssert(WholeNumber.BinaryView(0).endIndex == WholeNumber.BinaryView.Index(digit: 0, bit: 0))
    }

    static var allTests: [(String, (InternalTests) -> () throws -> Void)] {
        return [
            ("testUIntHalvesView", testUIntHalvesView),
            ("testUserDefaults", testUserDefaults),
            ("testWholeNumberBinaryView", testWholeNumberBinaryView)
        ]
    }
}
