/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGBinaryData

import SDGCornerstoneLocalizations

import XCTest

import SDGXCTestUtilities
import SDGMathematicsTestUtilities
import SDGLocalizationTestUtilities

class APITests: TestCase {

  func testData() {
    testBitFieldConformance(
      start: Data([0b0101_0110]),
      not: Data([0b1010_1001]),
      other: Data([0b1101_0010]),
      and: Data([0b0101_0010]),
      or: Data([0b1101_0110]),
      exclusiveOr: Data([0b1000_0100])
    )

    let data = Data([UInt8.max])
    XCTAssertEqual(data.binary.count, 8)
    XCTAssertEqual(data.binary.map({ $0 ? "1" : "0" }).joined(), "11111111")

    var toReverse = Data([0b11110000, 0b00000000])
    toReverse.binary.reverse()
    XCTAssertEqual(toReverse, Data([0b000000000, 0b00001111]))

    let alternating = Data([0b01010101, 0b01010101])
    let sorted = Data([0b00000000, 0b11111111])

    XCTAssertEqual(alternating.bitwiseNot(), Data([0b10101010, 0b10101010]))
    XCTAssertEqual(alternating.bitwiseAnd(with: sorted), Data([0b00000000, 0b01010101]))
    XCTAssertEqual(alternating.bitwiseOr(with: sorted), Data([0b01010101, 0b11111111]))
    XCTAssertEqual(alternating.bitwiseExclusiveOr(with: sorted), Data([0b01010101, 0b10101010]))

    var forDescription = Data([0, 0])
    forDescription.binary[11] = true
    testCustomStringConvertibleConformance(
      of: forDescription.binary,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "10th",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testDataStream() {
      var inputStream = DataStream()
      var outputStream = DataStream()

      var forwards = Data()
      for byte in (0x00 as Data.Element)...(0xFF as Data.Element) {
        forwards.append(byte)
      }
      let backwards = Data(forwards.reversed())

      inputStream.append(unit: forwards)
      inputStream.append(unit: backwards)

      var results: [Data] = []
      while ¬inputStream.buffer.isEmpty {
        let transfer = inputStream.buffer.removeFirst()
        outputStream.buffer.append(transfer)
        #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
        results.append(contentsOf: outputStream.extractCompleteUnits())
        #endif
      }
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
      XCTAssertEqual(results, [forwards, backwards])
    #endif
  }

  func testUInt() {
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
      var forDescription: UInt8 = 0
      forDescription.binary[0] = true
      testCustomStringConvertibleConformance(
        of: forDescription.binary,
        localizations: InterfaceLocalization.self,
        uniqueTestName: "1st",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }
}
