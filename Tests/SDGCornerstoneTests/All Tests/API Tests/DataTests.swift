/*
 DataTests.swift

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

class DataTests : TestCase {

    func testData() {
        let data = Data(bytes: [UInt8.max])
        XCTAssertEqual(data.binary.count, 8)
        XCTAssertEqual(data.binary.map({ $0 ? "1" : "0"}).joined(), "11111111")

        var toReverse = Data(bytes: [0b11110000, 0b00000000])
        toReverse.binary.reverse()
        XCTAssertEqual(toReverse, Data(bytes: [0b000000000, 0b00001111]))

        let alternating = Data(bytes: [0b01010101, 0b01010101])
        let sorted = Data(bytes: [0b00000000, 0b11111111])

        XCTAssertEqual(alternating.bitwiseNot(), Data(bytes: [0b10101010, 0b10101010]))
        XCTAssertEqual(alternating.bitwiseAnd(with: sorted), Data(bytes: [0b00000000, 0b01010101]))
        XCTAssertEqual(alternating.bitwiseOr(with: sorted), Data(bytes: [0b01010101, 0b11111111]))
        XCTAssertEqual(alternating.bitwiseExclusiveOr(with: sorted), Data(bytes: [0b01010101, 0b10101010]))
    }

    func testDataStream() {
        var inputStream = DataStream()
        var outputStream = DataStream()

        var forwards = Data()
        for byte in (0x00 as Data.Element) ... (0xFF as Data.Element) {
            forwards.append(byte)
        }
        let backwards = Data(forwards.reversed())

        inputStream.append(unit: forwards)
        inputStream.append(unit: backwards)

        var results: [Data] = []
        while ¬inputStream.buffer.isEmpty {
            let transfer = inputStream.buffer.removeFirst()
            outputStream.buffer.append(transfer)

            results.append(contentsOf: outputStream.extractCompleteUnits())
        }
        XCTAssertEqual(results, [forwards, backwards])
    }

    static var allTests: [(String, (DataTests) -> () throws -> Void)] {
        return [
            ("testData", testData),
            ("testDataStream", testDataStream)
        ]
    }
}
