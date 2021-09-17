/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
    #warning("Debugging...")
    print("A")
      testBitFieldConformance(
        start: Data([0b0101_0110]),
        not: Data([0b1010_1001]),
        other: Data([0b1101_0010]),
        and: Data([0b0101_0010]),
        or: Data([0b1101_0110]),
        exclusiveOr: Data([0b1000_0100])
      )

      #warning("Debugging...")
      print("B")
      let data = Data([UInt8.max])
      XCTAssertEqual(data.binary.count, 8)
      XCTAssertEqual(data.binary.map({ $0 ? "1" : "0" }).joined(), "11111111")

      #warning("Debugging...")
      print("C")
      var toReverse = Data([0b11110000, 0b00000000])
      toReverse.binary.reverse()
      XCTAssertEqual(toReverse, Data([0b000000000, 0b00001111]))

      #warning("Debugging...")
      print("D")
      let alternating = Data([0b01010101, 0b01010101])
      let sorted = Data([0b00000000, 0b11111111])

      #warning("Debugging...")
      print("E")
      XCTAssertEqual(alternating.bitwiseNot(), Data([0b10101010, 0b10101010]))
      XCTAssertEqual(alternating.bitwiseAnd(with: sorted), Data([0b00000000, 0b01010101]))
      XCTAssertEqual(alternating.bitwiseOr(with: sorted), Data([0b01010101, 0b11111111]))
      XCTAssertEqual(alternating.bitwiseExclusiveOr(with: sorted), Data([0b01010101, 0b10101010]))

      #warning("Debugging...")
      print("F")
      var forDescription = Data([0, 0])
      forDescription.binary[11] = true
      testCustomStringConvertibleConformance(
        of: forDescription.binary,
        localizations: InterfaceLocalization.self,
        uniqueTestName: "10th",
        overwriteSpecificationInsteadOfFailing: false
      )
    #warning("Debugging...")
    print("G")
  }

  func testDataStream() {
    #if !PLATFORM_SUFFERS_SEGMENTATION_FAULTS
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
        results.append(contentsOf: outputStream.extractCompleteUnits())
      }
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
