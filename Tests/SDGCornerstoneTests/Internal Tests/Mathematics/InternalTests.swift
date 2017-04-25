/*
 InternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    func testWholeNumberBinaryView() {
        XCTAssert((WholeNumber.BinaryView.Index(digit: 1, bit: 0) − WholeNumber.BinaryView.Index(digit: 0, bit: 63)).digitDistance == 0)

        var index = WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 0)
        index += 1
        XCTAssert(index == WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 1))

        index += WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: UInt.BinaryView<WholeNumber.Digit>.count − 1)
        XCTAssert(index == WholeNumber.BinaryView.IndexDistance(digitDistance: 1, bitDistance: 0))

        index −= WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 1)
        XCTAssert(index.digitDistance == 0)

        XCTAssert(WholeNumber.BinaryView(0).endIndex == WholeNumber.BinaryView.Index(digit: 0, bit: 0))
    }

    static var allTests: [(String, (InternalTests) -> () throws -> Void)] {
        return [
            ("testUIntHalvesView", testUIntHalvesView),
            ("testWholeNumberBinaryView", testWholeNumberBinaryView)
        ]
    }
}
