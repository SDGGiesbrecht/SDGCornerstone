/*
 SDGCollationLanguageTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGCollation

import XCTest

import SDGXCTestUtilities

class SDGCollationLanguageTests: TestCase {

  override func setUp() {
    super.setUp()
    StrictString.sortAlgorithm = { CollationOrder.root.stringsAreOrderedAscending($0, $1) }
  }

  override func tearDown() {
    super.tearDown()
    StrictString.sortAlgorithm = { String($0) < String($1) }
  }

  func testBosnian() {
    XCTAssert(StrictString("AZ<̌‐hr>") < StrictString("BA"))
    XCTAssert(StrictString("BZ<̌‐hr>") < StrictString("CA"))
    XCTAssert(StrictString("CZ<̌‐hr>") < StrictString("C<̌‐hr>A"))
    XCTAssert(StrictString("C<̌‐hr>Z<̌‐hr>") < StrictString("C<́‐pl>A"))
    XCTAssert(StrictString("C<́‐pl>Z<̌‐hr>") < StrictString("DA"))
    XCTAssert(StrictString("DZ<̌‐hr>") < StrictString("D<digraph>žA"))
    XCTAssert(StrictString("D<digraph>žZ<̌‐hr>") < StrictString("ĐA"))
    XCTAssert(StrictString("ĐZ<̌‐hr>") < StrictString("EA"))
    XCTAssert(StrictString("EZ<̌‐hr>") < StrictString("FA"))
    XCTAssert(StrictString("FZ<̌‐hr>") < StrictString("GA"))
    XCTAssert(StrictString("GZ<̌‐hr>") < StrictString("HA"))
    XCTAssert(StrictString("HZ<̌‐hr>") < StrictString("IA"))
    XCTAssert(StrictString("IZ<̌‐hr>") < StrictString("JA"))
    XCTAssert(StrictString("JZ<̌‐hr>") < StrictString("KA"))
    XCTAssert(StrictString("KZ<̌‐hr>") < StrictString("LA"))
    XCTAssert(StrictString("LZ<̌‐hr>") < StrictString("L<digraph>jA"))
    XCTAssert(StrictString("L<digraph>jZ<̌‐hr>") < StrictString("MA"))
    XCTAssert(StrictString("MZ<̌‐hr>") < StrictString("NA"))
    XCTAssert(StrictString("NZ<̌‐hr>") < StrictString("N<digraph>jA"))
    XCTAssert(StrictString("N<digraph>jZ<̌‐hr>") < StrictString("OA"))
    XCTAssert(StrictString("OZ<̌‐hr>") < StrictString("PA"))
    XCTAssert(StrictString("PZ<̌‐hr>") < StrictString("RA"))
    XCTAssert(StrictString("RZ<̌‐hr>") < StrictString("SA"))
    XCTAssert(StrictString("SZ<̌‐hr>") < StrictString("S<̌‐hr>A"))
    XCTAssert(StrictString("S<̌‐hr>Z<̌‐hr>") < StrictString("TA"))
    XCTAssert(StrictString("TZ<̌‐hr>") < StrictString("UA"))
    XCTAssert(StrictString("UZ<̌‐hr>") < StrictString("VA"))
    XCTAssert(StrictString("VZ<̌‐hr>") < StrictString("ZA"))
    XCTAssert(StrictString("ZZ<̌‐hr>") < StrictString("Z<̌‐hr>A"))
  }

  func testEnglish() {
    XCTAssert(StrictString("AZ") < StrictString("BA"))
    XCTAssert(StrictString("BZ") < StrictString("CA"))
    XCTAssert(StrictString("CZ") < StrictString("DA"))
    XCTAssert(StrictString("DZ") < StrictString("EA"))
    XCTAssert(StrictString("EZ") < StrictString("FA"))
    XCTAssert(StrictString("FZ") < StrictString("GA"))
    XCTAssert(StrictString("GZ") < StrictString("HA"))
    XCTAssert(StrictString("HZ") < StrictString("IA"))
    XCTAssert(StrictString("IZ") < StrictString("JA"))
    XCTAssert(StrictString("JZ") < StrictString("KA"))
    XCTAssert(StrictString("KZ") < StrictString("LA"))
    XCTAssert(StrictString("LZ") < StrictString("MA"))
    XCTAssert(StrictString("MZ") < StrictString("NA"))
    XCTAssert(StrictString("NZ") < StrictString("OA"))
    XCTAssert(StrictString("OZ") < StrictString("PA"))
    XCTAssert(StrictString("PZ") < StrictString("QA"))
    XCTAssert(StrictString("QZ") < StrictString("RA"))
    XCTAssert(StrictString("RZ") < StrictString("SA"))
    XCTAssert(StrictString("SZ") < StrictString("TA"))
    XCTAssert(StrictString("TZ") < StrictString("UA"))
    XCTAssert(StrictString("UZ") < StrictString("VA"))
    XCTAssert(StrictString("VZ") < StrictString("WA"))
    XCTAssert(StrictString("WZ") < StrictString("XA"))
    XCTAssert(StrictString("XZ") < StrictString("YA"))
    XCTAssert(StrictString("YZ") < StrictString("ZA"))
  }

  func testFrench() {
    XCTAssert(StrictString("AZ") < StrictString("BA"))
    XCTAssert(StrictString("BZ") < StrictString("CA"))
    XCTAssert(StrictString("CZ") < StrictString("DA"))
    XCTAssert(StrictString("DZ") < StrictString("EA"))
    XCTAssert(StrictString("EZ") < StrictString("FA"))
    XCTAssert(StrictString("FZ") < StrictString("GA"))
    XCTAssert(StrictString("GZ") < StrictString("HA"))
    XCTAssert(StrictString("HZ") < StrictString("IA"))
    XCTAssert(StrictString("IZ") < StrictString("JA"))
    XCTAssert(StrictString("JZ") < StrictString("KA"))
    XCTAssert(StrictString("KZ") < StrictString("LA"))
    XCTAssert(StrictString("LZ") < StrictString("MA"))
    XCTAssert(StrictString("MZ") < StrictString("NA"))
    XCTAssert(StrictString("NZ") < StrictString("OA"))
    XCTAssert(StrictString("OZ") < StrictString("PA"))
    XCTAssert(StrictString("PZ") < StrictString("QA"))
    XCTAssert(StrictString("QZ") < StrictString("RA"))
    XCTAssert(StrictString("RZ") < StrictString("SA"))
    XCTAssert(StrictString("SZ") < StrictString("TA"))
    XCTAssert(StrictString("TZ") < StrictString("UA"))
    XCTAssert(StrictString("UZ") < StrictString("VA"))
    XCTAssert(StrictString("VZ") < StrictString("WA"))
    XCTAssert(StrictString("WZ") < StrictString("XA"))
    XCTAssert(StrictString("XZ") < StrictString("YA"))
    XCTAssert(StrictString("YZ") < StrictString("ZA"))

    XCTAssert(StrictString("AEA") < StrictString("ÆB"))
    XCTAssert(StrictString("ÆA") < StrictString("AEB"))

    XCTAssert(StrictString("OEA") < StrictString("ŒB"))
    XCTAssert(StrictString("ŒA") < StrictString("OEB"))

    XCTAssert(StrictString("E") < StrictString("E<́‐fr>"))
    XCTAssert(StrictString("É<́‐fr>") < StrictString("È<̀‐fr>"))
    XCTAssert(StrictString("È<̀‐fr>") < StrictString("Ê"))
    XCTAssert(StrictString("Ê") < StrictString("E<̈‐fr>"))

    XCTAssert(StrictString("EA") < StrictString("E<̈‐fr>B"))
    XCTAssert(StrictString("E<̈‐fr>A") < StrictString("EB"))

    XCTAssert(StrictString("cote") < StrictString("côte"))
    XCTAssert(StrictString("côte") < StrictString("cote<́‐fr>"))
    XCTAssert(StrictString("cote<́‐fr>") < StrictString("côte<́‐fr>"))
  }

  func testGerman() {
    XCTAssert(StrictString("AZ") < StrictString("BA"))
    XCTAssert(StrictString("BZ") < StrictString("CA"))
    XCTAssert(StrictString("CZ") < StrictString("DA"))
    XCTAssert(StrictString("DZ") < StrictString("EA"))
    XCTAssert(StrictString("EZ") < StrictString("FA"))
    XCTAssert(StrictString("FZ") < StrictString("GA"))
    XCTAssert(StrictString("GZ") < StrictString("HA"))
    XCTAssert(StrictString("HZ") < StrictString("IA"))
    XCTAssert(StrictString("IZ") < StrictString("JA"))
    XCTAssert(StrictString("JZ") < StrictString("KA"))
    XCTAssert(StrictString("KZ") < StrictString("LA"))
    XCTAssert(StrictString("LZ") < StrictString("MA"))
    XCTAssert(StrictString("MZ") < StrictString("NA"))
    XCTAssert(StrictString("NZ") < StrictString("OA"))
    XCTAssert(StrictString("OZ") < StrictString("PA"))
    XCTAssert(StrictString("PZ") < StrictString("QA"))
    XCTAssert(StrictString("QZ") < StrictString("RA"))
    XCTAssert(StrictString("RZ") < StrictString("SA"))
    XCTAssert(StrictString("SZ") < StrictString("TA"))
    XCTAssert(StrictString("TZ") < StrictString("UA"))
    XCTAssert(StrictString("UZ") < StrictString("VA"))
    XCTAssert(StrictString("VZ") < StrictString("WA"))
    XCTAssert(StrictString("WZ") < StrictString("XA"))
    XCTAssert(StrictString("XZ") < StrictString("YA"))
    XCTAssert(StrictString("YZ") < StrictString("ZA"))

    XCTAssert(StrictString("ssa") < StrictString("ßb"))
    XCTAssert(StrictString("ßa") < StrictString("ssb"))

    XCTAssert(StrictString("AA") < StrictString("ÄB"))
    XCTAssert(StrictString("ÄA") < StrictString("AB"))

    XCTAssert(StrictString("AEA") < StrictString("A<̈‐de‐tel>B"))
    XCTAssert(StrictString("A<̈‐de‐tel>A") < StrictString("AEB"))

    XCTAssert(StrictString("AA") < StrictString("A<̈‐hu>Z"))
    XCTAssert(StrictString("A<̈‐hu>A") < StrictString("BZ"))

    XCTAssert(StrictString("OA") < StrictString("O<̈‐hu>Z"))
    XCTAssert(StrictString("O<̈‐hu>A") < StrictString("PZ"))

    XCTAssert(StrictString("UA") < StrictString("U<̈‐hu>Z"))
    XCTAssert(StrictString("U<̈‐hu>A") < StrictString("VZ"))
  }

  func testGreek() {
    XCTAssert(StrictString("ΑΩ") < StrictString("ΒΑ"))
    XCTAssert(StrictString("ΒΩ") < StrictString("ΓΑ"))
    XCTAssert(StrictString("ΓΩ") < StrictString("ΔΑ"))
    XCTAssert(StrictString("ΔΩ") < StrictString("ΕΑ"))
    XCTAssert(StrictString("ΕΩ") < StrictString("ΖΑ"))
    XCTAssert(StrictString("ΖΩ") < StrictString("ΗΑ"))
    XCTAssert(StrictString("ΗΩ") < StrictString("ΘΑ"))
    XCTAssert(StrictString("ΘΩ") < StrictString("ΙΑ"))
    XCTAssert(StrictString("ΙΩ") < StrictString("ΚΑ"))
    XCTAssert(StrictString("ΚΩ") < StrictString("ΛΑ"))
    XCTAssert(StrictString("ΛΩ") < StrictString("ΜΑ"))
    XCTAssert(StrictString("ΜΩ") < StrictString("ΝΑ"))
    XCTAssert(StrictString("ΝΩ") < StrictString("ΞΑ"))
    XCTAssert(StrictString("ΞΩ") < StrictString("ΟΑ"))
    XCTAssert(StrictString("ΟΩ") < StrictString("ΠΑ"))
    XCTAssert(StrictString("ΠΩ") < StrictString("ΡΑ"))
    XCTAssert(StrictString("ΡΩ") < StrictString("ΣΑ"))
    XCTAssert(StrictString("ΣΩ") < StrictString("ΤΑ"))
    XCTAssert(StrictString("ΤΩ") < StrictString("ΥΑ"))
    XCTAssert(StrictString("ΥΩ") < StrictString("ΦΑ"))
    XCTAssert(StrictString("ΦΩ") < StrictString("ΧΑ"))
    XCTAssert(StrictString("ΧΩ") < StrictString("ΨΑ"))
    XCTAssert(StrictString("ΨΩ") < StrictString("ΩΑ"))

    XCTAssert(StrictString("Ι") < StrictString("Ί"))
    XCTAssert(StrictString("Ί") < StrictString("Ϊ"))

    XCTAssert(StrictString("ΙΑ") < StrictString("ΪΒ"))
    XCTAssert(StrictString("ΪΑ") < StrictString("ΙΒ"))
  }

  func testHebrew() {
    XCTAssert(StrictString("את") < StrictString("בא"))
    XCTAssert(StrictString("בת") < StrictString("גא"))
    XCTAssert(StrictString("גת") < StrictString("דא"))
    XCTAssert(StrictString("דת") < StrictString("הא"))
    XCTAssert(StrictString("הת") < StrictString("וא"))
    XCTAssert(StrictString("ות") < StrictString("זא"))
    XCTAssert(StrictString("זת") < StrictString("חא"))
    XCTAssert(StrictString("חת") < StrictString("טא"))
    XCTAssert(StrictString("טת") < StrictString("יא"))
    XCTAssert(StrictString("ית") < StrictString("כא"))
    XCTAssert(StrictString("כת") < StrictString("לא"))
    XCTAssert(StrictString("לת") < StrictString("מא"))
    XCTAssert(StrictString("מת") < StrictString("נא"))
    XCTAssert(StrictString("נת") < StrictString("סא"))
    XCTAssert(StrictString("סת") < StrictString("עא"))
    XCTAssert(StrictString("עת") < StrictString("פא"))
    XCTAssert(StrictString("פת") < StrictString("צא"))
    XCTAssert(StrictString("צת") < StrictString("קא"))
    XCTAssert(StrictString("קת") < StrictString("רא"))
    XCTAssert(StrictString("רת") < StrictString("שא"))
    XCTAssert(StrictString("שת") < StrictString("תא"))
  }

  func testItalian() {
    XCTAssert(StrictString("AZ") < StrictString("BA"))
    XCTAssert(StrictString("BZ") < StrictString("CA"))
    XCTAssert(StrictString("CZ") < StrictString("DA"))
    XCTAssert(StrictString("DZ") < StrictString("EA"))
    XCTAssert(StrictString("EZ") < StrictString("FA"))
    XCTAssert(StrictString("FZ") < StrictString("GA"))
    XCTAssert(StrictString("GZ") < StrictString("HA"))
    XCTAssert(StrictString("HZ") < StrictString("IA"))
    XCTAssert(StrictString("IZ") < StrictString("KA"))
    XCTAssert(StrictString("KZ") < StrictString("LA"))
    XCTAssert(StrictString("LZ") < StrictString("MA"))
    XCTAssert(StrictString("MZ") < StrictString("NA"))
    XCTAssert(StrictString("NZ") < StrictString("OA"))
    XCTAssert(StrictString("OZ") < StrictString("PA"))
    XCTAssert(StrictString("PZ") < StrictString("QA"))
    XCTAssert(StrictString("QZ") < StrictString("RA"))
    XCTAssert(StrictString("RZ") < StrictString("SA"))
    XCTAssert(StrictString("SZ") < StrictString("TA"))
    XCTAssert(StrictString("TZ") < StrictString("UA"))
    XCTAssert(StrictString("UZ") < StrictString("VA"))
    XCTAssert(StrictString("VZ") < StrictString("ZA"))

    XCTAssert(StrictString("I") < StrictString("Í"))
    XCTAssert(StrictString("Í") < StrictString("Ì"))
    XCTAssert(StrictString("Ì") < StrictString("I<̂‐pt>"))

    XCTAssert(StrictString("IA") < StrictString("I<̂‐pt>B"))
    XCTAssert(StrictString("I<̂‐pt>A") < StrictString("IB"))
  }

  func testSpanish() {
    XCTAssert(StrictString("AZ") < StrictString("BA"))
    XCTAssert(StrictString("BZ") < StrictString("CA"))
    XCTAssert(StrictString("CZ") < StrictString("DA"))
    XCTAssert(StrictString("DZ") < StrictString("EA"))
    XCTAssert(StrictString("EZ") < StrictString("FA"))
    XCTAssert(StrictString("FZ") < StrictString("GA"))
    XCTAssert(StrictString("GZ") < StrictString("HA"))
    XCTAssert(StrictString("HZ") < StrictString("IA"))
    XCTAssert(StrictString("IZ") < StrictString("JA"))
    XCTAssert(StrictString("JZ") < StrictString("KA"))
    XCTAssert(StrictString("KZ") < StrictString("LA"))
    XCTAssert(StrictString("LZ") < StrictString("MA"))
    XCTAssert(StrictString("MZ") < StrictString("NA"))
    XCTAssert(StrictString("NZ") < StrictString("ÑA"))
    XCTAssert(StrictString("ÑZ") < StrictString("OA"))
    XCTAssert(StrictString("OZ") < StrictString("PA"))
    XCTAssert(StrictString("PZ") < StrictString("QA"))
    XCTAssert(StrictString("QZ") < StrictString("RA"))
    XCTAssert(StrictString("RZ") < StrictString("SA"))
    XCTAssert(StrictString("SZ") < StrictString("TA"))
    XCTAssert(StrictString("TZ") < StrictString("UA"))
    XCTAssert(StrictString("UZ") < StrictString("VA"))
    XCTAssert(StrictString("VZ") < StrictString("WA"))
    XCTAssert(StrictString("WZ") < StrictString("XA"))
    XCTAssert(StrictString("XZ") < StrictString("YA"))
    XCTAssert(StrictString("YZ") < StrictString("ZA"))

    XCTAssert(StrictString("AA") < StrictString("ÁB"))
    XCTAssert(StrictString("ÁA") < StrictString("AB"))
  }
}
