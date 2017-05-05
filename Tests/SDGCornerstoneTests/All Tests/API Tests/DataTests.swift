/*
 DataTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

class DataTests : XCTestCase {

    func testData() {
        let data = Data(bytes: [UInt8.max])
        XCTAssert(data.binary.count == 8, "\(data).binary.count ≠ 8")
        XCTAssert(data.binary.map({ $0 ? "1" : "0"}).joined() == "11111111", "\(data.binary.map({ $0 ? "1" : "0"}).joined()) ≠ 11111111")

        var toReverse = Data(bytes: [0b11110000, 0b00000000])
        toReverse.binary.reverse()
        XCTAssert(toReverse == Data(bytes: [0b000000000, 0b00001111]))

        let alternating = Data(bytes: [0b01010101, 0b01010101])
        let sorted = Data(bytes: [0b00000000, 0b11111111])

        XCTAssert(alternating.bitwiseNot() == Data(bytes: [0b10101010, 0b10101010]))
        XCTAssert(alternating.bitwiseAnd(with: sorted) == Data(bytes: [0b00000000, 0b01010101]))
        XCTAssert(alternating.bitwiseOr(with: sorted) == Data(bytes: [0b01010101, 0b11111111]))
        XCTAssert(alternating.bitwiseExclusiveOr(with: sorted) == Data(bytes: [0b01010101, 0b10101010]))

        // BitwiseOperations

        XCTAssert(~alternating == Data(bytes: [0b10101010, 0b10101010]))
        XCTAssert(alternating & sorted == Data(bytes: [0b00000000, 0b01010101]))
        XCTAssert(alternating | sorted == Data(bytes: [0b01010101, 0b11111111]))
        XCTAssert(alternating ^ sorted == Data(bytes: [0b01010101, 0b10101010]))
    }

    static var allTests: [(String, (DataTests) -> () throws -> Void)] {
        return [
            ("testData", testData)
        ]
    }
}
