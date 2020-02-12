/*
 SDGRandomizationAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGRandomization

import XCTest

import SDGRandomizationTestUtilities
import SDGXCTestUtilities

class SDGRandomizationAPITests: TestCase {

  func testBool() {
    var values: Set<Bool> = []
    for _ in 1..<100 {
      values.insert(Bool.random())
    }
    XCTAssertEqual(values.count, 2)
  }

  func testCollection() {
    let forDrawing = (1...6)
    var sameOccurred = false
    var differentOccurred = false
    for _ in 1...100 {
      let random = forDrawing.randomElement()
      if random == 1 {
        sameOccurred = true
      } else {
        differentOccurred = true
      }
    }
    XCTAssert(sameOccurred)
    XCTAssert(differentOccurred)
    _ = [1, 2, 3].randomElement()
  }

  func testCyclicalNumberGenerator() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault)
      testRandomNumberGeneratorConformance(
        of: CyclicalNumberGenerator([0, 1, 6, 7, 11, 12, UInt64.max])
      )
    #endif
  }

  func testMeasurement() {
    XCTAssertEqual(Angle<Double>.random(in: 0.rad...0.rad), 0.rad)
    XCTAssert((0°..<1°).contains(Angle<Double>.random(in: 0°..<1°)))
  }

  func testPseudorandomNumberGenerator() {
    var randomizer = PseudorandomNumberGenerator(seed: PseudorandomNumberGenerator.generateSeed())
    testRandomNumberGeneratorConformance(of: randomizer)

    var uInt64sReturned: Set<UInt64> = []
    var int64sReturned: Set<Int64> = []
    var positiveInt64sReturned: Set<Int64> = []

    for _ in 1...100 {
      let random = UInt64.random(in: 1...6, using: &randomizer)
      uInt64sReturned.insert(random)
      XCTAssert(1 ≤ random ∧ random ≤ 6)

      let randomInt = Int64.random(in: −3...3, using: &randomizer)
      int64sReturned.insert(randomInt)
      XCTAssert(−3 ≤ randomInt ∧ randomInt ≤ 3)

      let randomPositiveInt = Int64.random(in: 1...6, using: &randomizer)
      positiveInt64sReturned.insert(randomPositiveInt)
      XCTAssert(1 ≤ randomPositiveInt ∧ randomPositiveInt ≤ 6)

      let randomDouble = Double.random(in: −3...3, using: &randomizer)
      XCTAssert(−3 ≤ randomDouble ∧ randomDouble ≤ 3)
    }

    XCTAssertEqual(uInt64sReturned.count, 6)
    XCTAssertEqual(int64sReturned.count, 7)
    XCTAssertEqual(positiveInt64sReturned.count, 6)
  }

  func testRangeReplaceableCollection() {
    var last = "12345"
    var same = true
    for _ in 1...100 where same {
      let next = String(last.shuffled())
      if ¬next.elementsEqual(last) {
        same = false
      }
      last = next
    }
    XCTAssert(¬same)

    last.shuffle()
  }
}
