/*
 PersistenceTests.swift

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

class PersistenceTests : XCTestCase {

    func testUserDefaults() {
        let testKey = "SDGTestKey"

        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: testKey)
        XCTAssert(defaults.object(forKey: testKey) == nil, "Unexpected value: \(String(describing: defaults.object(forKey: testKey)))")

        let shared = UserDefaults.standard.sharedValue(forKey: testKey)
        XCTAssert(shared.value == nil, "Unexpected value: \(String(describing: shared.value))")

        defaults.set(true, forKey: testKey)
        XCTAssert(defaults.bool(forKey: testKey) == true, "Bindings failed: \(defaults.bool(forKey: testKey)) ≠ true")
        XCTAssert(shared.value as? Bool == true, "Bindings failed: \(String(describing: shared.value as? Bool)) ≠ true")

        defaults.set("A", forKey: testKey)
        XCTAssert(defaults.string(forKey: testKey) == "A")
        XCTAssert(shared.value as? String == "A")

        let data = Data(bytes: [1, 2, 3])
        shared.value = data
        XCTAssert(shared.value as? Data == data)
        XCTAssert(defaults.data(forKey: testKey) == data)

        shared.value = nil
        XCTAssert(shared.value == nil)
        XCTAssert(defaults.object(forKey: testKey) == nil)

        defaults.removeObject(forKey: testKey)
    }

    static var allTests: [(String, (PersistenceTests) -> () throws -> Void)] {
        return [
            ("testUserDefaults", testUserDefaults)
        ]
    }
}
