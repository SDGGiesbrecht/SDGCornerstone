/*
 SDGPrecisionMathematicsInternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGBinaryData
@testable import SDGPrecisionMathematics
import SDGXCTestUtilities

class SDGPrecisionMathematicsInternalTests : TestCase {

    func testUIntHalvesView() {
        XCTAssertEqual((0 as UInt).halves.index(before: 1), 0)
    }

    func testWholeNumberBinaryView() {
        XCTAssertEqual((WholeNumber.BinaryView.Index(digit: 1, bit: 0) − WholeNumber.BinaryView.Index(digit: 0, bit: 63)).digitDistance, 0)

        var index = WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 0)
        index += 1
        XCTAssertEqual(index, WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 1))

        index += WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: BinaryView<WholeNumber.Digit>.count − 1)
        XCTAssertEqual(index, WholeNumber.BinaryView.IndexDistance(digitDistance: 1, bitDistance: 0))

        index −= WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 1)
        XCTAssertEqual(index.digitDistance, 0)

        XCTAssertEqual(WholeNumber.BinaryView(0).endIndex, WholeNumber.BinaryView.Index(digit: 0, bit: 0))

        var hasher = Hasher()
        WholeNumber.BinaryView.IndexDistance(digitDistance: 0, bitDistance: 0).hash(into: &hasher)
    }
}
