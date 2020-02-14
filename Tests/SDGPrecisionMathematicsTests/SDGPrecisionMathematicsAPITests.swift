/*
 SDGPrecisionMathematicsAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGPrecisionMathematics

import SDGCornerstoneLocalizations

import XCTest

import SDGMathematicsTestUtilities
import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class SDGPrecisionMathematicsAPITests: TestCase {

  func testInteger() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault, entire executable)
      // #workaround(workspace version 0.30.1, GitHub Action lacks necessary permissions.)
      #if !os(Android)
        testIntegralArithmeticConformance(of: Integer.self)
      #endif

      XCTAssertNotNil(Integer(exactly: SDGMathematics.UIntMax.max))
      XCTAssertNotNil(Integer(exactly: SDGMathematics.IntMax.max))
      XCTAssertNotNil(Integer(exactly: SDGMathematics.IntMax.min))

      XCTAssertEqual(Integer.random(in: 1...1), 1)
      XCTAssertEqual(Integer.random(in: −1...(−1)), −1)

      let negativeMillion: SDGPrecisionMathematics.Integer = −1_000_000
      // #workaround(workspace version 0.30.1, GitHub Action lacks necessary permissions.)
      #if !os(Android)
        testCustomStringConvertibleConformance(
          of: negativeMillion,
          localizations: FormatLocalization.self,
          uniqueTestName: negativeMillion.inDigits(),
          overwriteSpecificationInsteadOfFailing: false
        )
      #endif
    #endif
  }

  func testRationalNumber() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault, entire executable)
      // #workaround(workspace version 0.30.1, GitHub Action lacks necessary permissions.)
      #if !os(Android)
        testRationalArithmeticConformance(of: RationalNumber.self)
      #endif

      XCTAssertEqual(RationalNumber(undecillion).numerator, Integer(undecillion))
      XCTAssertEqual(RationalNumber(50), 50)

      XCTAssertNotNil(RationalNumber(exactly: SDGMathematics.UIntMax.max))
      XCTAssertNotNil(RationalNumber(exactly: SDGMathematics.IntMax.max))
      XCTAssertNotNil(RationalNumber(exactly: SDGMathematics.IntMax.min))

      XCTAssertEqual((−19 as RationalNumber ÷ 2).asSimpleFraction(), "−19⁄2")
      XCTAssertEqual((6 as RationalNumber).asSimpleFraction(), "6")
      XCTAssertEqual((50_001 as RationalNumber ÷ 10_000).asSimpleFraction(), "(50 001)⁄(10 000)")

      XCTAssertEqual((−19 as RationalNumber ÷ 2).asMixedFraction(), "−9 1⁄2")
      XCTAssertEqual((6 as RationalNumber).asMixedFraction(), "6")
      XCTAssertEqual((50_001 as RationalNumber ÷ 10_000).asMixedFraction(), "5 + 1⁄(10 000)")

      XCTAssertEqual((−19 as RationalNumber ÷ 2).asRatio(), "−19 ∶ 2")
      XCTAssertEqual((6 as RationalNumber).asRatio(), "6 ∶ 1")
      XCTAssertEqual((50_001 as RationalNumber ÷ 10_000).asRatio(), "50 001 ∶ 10 000")

      XCTAssertEqual(RationalNumber.random(in: 1...1), 1)

      let simple = (−19 as RationalNumber ÷ 2)
      // #workaround(workspace version 0.30.1, GitHub Action lacks necessary permissions.)
      #if !os(Android)
        testCustomStringConvertibleConformance(
          of: simple,
          localizations: FormatLocalization.self,
          uniqueTestName: simple.asSimpleFraction(),
          overwriteSpecificationInsteadOfFailing: false
        )
      #endif
      let complex = (50_001 as RationalNumber ÷ 10_000)
      // #workaround(workspace version 0.30.1, GitHub Action lacks necessary permissions.)
      #if !os(Android)
        testCustomStringConvertibleConformance(
          of: complex,
          localizations: FormatLocalization.self,
          uniqueTestName: complex.asSimpleFraction(),
          overwriteSpecificationInsteadOfFailing: false
        )
      #endif
    #endif
  }

  #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault, entire executable)
    let undecillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000 000"
  #endif
  func testWholeNumber() {
    #if !os(Windows)  // #workaround(Swift 5.1.3, SegFault, entire executable)
      // #workaround(workspace version 0.30.1, GitHub Action lacks necessary permissions.)
      #if !os(Android)
        testWholeArithmeticConformance(of: WholeNumber.self, includingNegatives: false)
      #endif
      testDecoding(WholeNumber.self, failsFor: "12c45")  // Invalid string.

      let billion: WholeNumber = 1_000_000_000
      XCTAssertEqual(billion ↑ 4, undecillion)

      XCTAssertEqual(undecillion.dividedAccordingToEuclid(by: (billion ↑ 3)), billion)

      let value: WholeNumber = "66 296 448 936 247 622 620"
      XCTAssertEqual(value.dividedAccordingToEuclid(by: 4), "16 574 112 234 061 905 655")

      let anotherValue: WholeNumber = "18 446 744 073 709 551 616"
      XCTAssertEqual(anotherValue.dividedAccordingToEuclid(by: 1), anotherValue)

      XCTAssertNotNil(WholeNumber(exactly: SDGMathematics.UIntMax.max))
      XCTAssertNotNil(WholeNumber(exactly: SDGMathematics.IntMax.max))
      XCTAssertNil(WholeNumber(exactly: SDGMathematics.IntMax.min))

      XCTAssertEqual((1 as WholeNumber).abbreviatedEnglishOrdinal().rawTextApproximation(), "1st")

      XCTAssertEqual(WholeNumber.random(in: 1...1), 1)
      let multipleDigits = WholeNumber(UIntMax.max).successor() ↑ 2
      let range = 0...multipleDigits.successor()
      XCTAssert(range.contains(WholeNumber.random(in: range)))

      let thousand: WholeNumber = 1000
      // #workaround(workspace version 0.30.1, GitHub Action lacks necessary permissions.)
      #if !os(Android)
        testCustomStringConvertibleConformance(
          of: thousand,
          localizations: FormatLocalization.self,
          uniqueTestName: thousand.inDigits(),
          overwriteSpecificationInsteadOfFailing: false
        )
        testCustomStringConvertibleConformance(
          of: billion,
          localizations: FormatLocalization.self,
          uniqueTestName: billion.inDigits(),
          overwriteSpecificationInsteadOfFailing: false
        )
      #endif
    #endif
  }
}
