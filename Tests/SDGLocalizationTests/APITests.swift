/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGLocalization
import SDGPrecisionMathematics

import SDGCornerstoneLocalizations

import XCTest

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class APITests: TestCase {

  func testAngle() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      testCustomStringConvertibleConformance(
        of: 90°,
        localizations: FormatLocalization.self,
        uniqueTestName: "90°",
        overwriteSpecificationInsteadOfFailing: false
      )
      testCustomStringConvertibleConformance(
        of: −90°,
        localizations: FormatLocalization.self,
        uniqueTestName: "−90°",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testAnyLocalization() {
    XCTAssertNotNil(AnyLocalization(exactly: "und"))
    _ = AnyLocalization.fallbackLocalization
  }

  func testBool() {
    for boolean in [true, false] {
      XCTAssertNotEqual(boolean.checkOrX(), "")
      XCTAssertNotEqual(boolean.trueOrFalse(.sentenceMedial), "")
      XCTAssertNotEqual(boolean.yesOrNo(.sentenceMedial), "")
    }
    XCTAssertEqual(true.trueOrFalse(.titleInitial), "True")
  }

  func testCasing() {
    XCTAssertEqual(Casing.sentenceMedial.apply(to: "écrire"), "écrire")
    XCTAssertEqual(Casing.sentenceInitial.apply(to: "écrire"), "Écrire")
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      testCodableConformance(of: Casing.sentenceMedial, uniqueTestName: "Medial")
    #endif
  }

  enum IconlessLocalizationExample: String, InputLocalization {
    case none = "zxx"
    static let fallbackLocalization: IconlessLocalizationExample = .none
  }
  func testCustomStringConvertible() {
    testCustomStringConvertibleConformance(
      of: "...",
      localizations: IconlessLocalizationExample.self,
      uniqueTestName: "No Icon",
      overwriteSpecificationInsteadOfFailing: false
    )
    XCTAssert(IconlessLocalizationExample.none.description == "zxx")
  }

  func testEnglishCasing() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      testCodableConformance(of: EnglishCasing.sentenceMedial, uniqueTestName: "Medial")
    #endif
  }

  func testGrammaticalGender() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      testCodableConformance(of: GrammaticalGender.masculine, uniqueTestName: "Masculine")
    #endif
  }

  func testGrammaticalNumber() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      testCodableConformance(of: GrammaticalNumber.singular, uniqueTestName: "Singular")
    #endif
  }

  func testΓραμματικήΠτώση() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      testCodableConformance(of: ΓραμματικήΠτώση.ονομαστική, uniqueTestName: "Ονομαστική")
    #endif
  }

  enum LocalizationExample: String, Localization {
    case englishUnitedKingdom = "en\u{2D}GB"
    case français = "fr"
    case chineseTraditionalTaiwan = "cmn\u{2D}Hant\u{2D}TW"
    case malaysianLatin = "zsm\u{2D}Latn"
    case norwegian = "no"
    case עברית = "he"
    static let fallbackLocalization: LocalizationExample = .englishUnitedKingdom
  }
  func testLocalization() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      XCTAssertEqual(LocalizationExample(exactly: "fr")?.code, "fr")
      XCTAssertEqual(LocalizationExample(exactly: "en\u{2D}GB"), .englishUnitedKingdom)
      XCTAssertNil(LocalizationExample(exactly: "en\u{2D}"))
      XCTAssertEqual(LocalizationExample(reasonableMatchFor: "en\u{2D}US"), .englishUnitedKingdom)
      XCTAssertEqual(LocalizationExample(reasonableMatchFor: "fr\u{2D}FR"), .français)
      XCTAssertNil(LocalizationExample(reasonableMatchFor: "el"))
      XCTAssertNil(LocalizationExample(reasonableMatchFor: "zxx"))
      XCTAssertEqual(
        LocalizationExample(reasonableMatchFor: "cmn\u{2D}Hant\u{2D}"),
        .chineseTraditionalTaiwan
      )
      XCTAssertEqual(
        LocalizationExample(reasonableMatchFor: "cmn\u{2D}TW\u{2D}"),
        .chineseTraditionalTaiwan
      )
      XCTAssertEqual(LocalizationExample(reasonableMatchFor: "zsm"), .malaysianLatin)
      XCTAssertEqual(LocalizationExample(reasonableMatchFor: "zh"), .chineseTraditionalTaiwan)
      XCTAssertNil(LocalizationExample(reasonableMatchFor: "ar"))
      XCTAssertNil(LocalizationExample(reasonableMatchFor: "arb"))
      XCTAssertEqual(LocalizationExample(reasonableMatchFor: "arb\u{2D}Arab"), nil)
      XCTAssertEqual(LocalizationExample(reasonableMatchFor: "nb"), .norwegian)

      XCTAssertEqual(LocalizationExample.français.icon, "🇫🇷FR")

      XCTAssertNil(LocalizationExample(icon: ""))
      XCTAssertNil(LocalizationExample(icon: "xyz?"))

      XCTAssertEqual(LocalizationExample.icon(for: "ca\u{2D}AD"), "🇦🇩CA")
      XCTAssertEqual(LocalizationExample.code(for: "🇦🇩CA"), "ca\u{2D}AD")

      XCTAssertEqual(LocalizationExample.עברית.textDirection, .rightToLeftTopToBottom)
      XCTAssertEqual(
        LocalizationExample.englishUnitedKingdom.textDirection,
        .leftToRightTopToBottom
      )
      XCTAssertEqual(
        LocalizationExample.chineseTraditionalTaiwan.textDirection,
        .topToBottomRightToLeft
      )

      _ = LocalizationExample.resolved()
    #endif
  }

  func testLocalizationData() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      for localization in LocalizationData.list {
        _ = localization.code
        _ = localization.icon
        _ = localization.isolatedName(in: InterfaceLocalization.englishCanada)
      }
      XCTAssertNotNil(LocalizationData(code: "en\u{2D}CA"))
      XCTAssertNotNil(LocalizationData(icon: "🇨🇦EN"))
      XCTAssertNil(LocalizationData(code: "N/A"))
      XCTAssertNil(LocalizationData(icon: "N/A"))
      enum UnsupportedLocalization: String, Localization {
        case unknown = "und"
        static var fallbackLocalization: UnsupportedLocalization = .unknown
      }
      XCTAssertNil(
        LocalizationData(code: "en\u{2D}CA")?.isolatedName(in: UnsupportedLocalization.unknown)
      )
    #endif
  }

  func testLocalizationRelationships() {
    XCTAssert(
      FormatLocalization.codeSet() ⊇ InterfaceLocalization.codeSet(),
      "Formats should support at least every localization the user interface elements do."
    )
    XCTAssert(
      InterfaceLocalization.codeSet() ⊇ APILocalization.codeSet(),
      "The user interface elements should support at least every localization the Swift API does."
    )
  }

  func testLocalizationSetting() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      let english = LocalizationSetting(orderOfPrecedence: ["en", "fr"])
      XCTAssertEqual(english.resolved() as LocalizationExample, .englishUnitedKingdom)

      let unrecognized = LocalizationSetting(orderOfPrecedence: [["zxx"]])
      XCTAssertEqual(unrecognized.resolved() as LocalizationExample, .englishUnitedKingdom)

      english.do {
        XCTAssertEqual(LocalizationSetting.current.value, english)
      }
      let français = LocalizationSetting(orderOfPrecedence: ["fr"])
      français.do {
        XCTAssertEqual(LocalizationSetting.current.value, français)
      }

      let multilingual = LocalizationSetting(orderOfPrecedence: [["en", "fr"]])
      var englishUsed = false
      var françaisUtilisé = false
      multilingual.do {
        for _ in 1...100 where ¬englishUsed ∨ ¬françaisUtilisé {
          switch LocalizationSetting.current.value.resolved() as LocalizationExample {
          case .englishUnitedKingdom:
            englishUsed = true
          case .français:
            françaisUtilisé = true
          default:
            break
          }
        }
      }
      XCTAssert(englishUsed)
      XCTAssert(françaisUtilisé)

      #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
        LocalizationSetting.setApplicationPreferences(to: nil)

        LocalizationSetting.setApplicationPreferences(
          to: LocalizationSetting(orderOfPrecedence: ["en"])
        )
        XCTAssertEqual(
          LocalizationSetting.current.value.resolved() as LocalizationExample,
          .englishUnitedKingdom
        )
        LocalizationSetting.setApplicationPreferences(
          to: LocalizationSetting(orderOfPrecedence: ["fr"])
        )
        XCTAssertEqual(
          LocalizationSetting.current.value.resolved() as LocalizationExample,
          .français
        )

        LocalizationSetting.setApplicationPreferences(to: nil)
      #endif

      let codes = FormatLocalization.allCases.map { $0.code }
      let stabilizedSetting = LocalizationSetting(orderOfPrecedence: [codes])
      #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
        FileManager.default.delete(.cache)
      #endif
      let first: FormatLocalization = stabilizedSetting.resolved(stabilization: .stabilized)
      for _ in 1...10 {
        #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
          XCTAssertEqual(first, stabilizedSetting.resolved(stabilization: .stabilized))
        #endif
      }

      LocalizationSetting(orderOfPrecedence: [] as [String]).do {
        // Localization must be able to handle the complete absence of preferences.
        XCTAssertEqual(
          LocalizationExample.resolved(),
          LocalizationExample.fallbackLocalization
        )
      }

      testCustomStringConvertibleConformance(
        of: LocalizationSetting(orderOfPrecedence: [["en\u{2D}GB", "fr\u{2D}FR"], ["de\u{2D}DE"]]),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Setting",
        overwriteSpecificationInsteadOfFailing: false
      )
      _ = LocalizationSetting(orderOfPrecedence: ["en"]).playgroundDescription
    #endif
  }

  func testמין־דיקדקי() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      testCodableConformance(of: מין־דקדוקי.זכר, uniqueTestName: "זכר")
    #endif
  }

  func testRange() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      XCTAssertEqual(((0..<1) as Range).inInequalityNotation({ $0.inDigits() }), "0 ≤ x < 1")
      XCTAssertEqual(
        ((0..<1) as CountableRange).inInequalityNotation({ $0.inDigits() }),
        "0 ≤ x < 1"
      )

      XCTAssertEqual(((0...1) as ClosedRange).inInequalityNotation({ $0.inDigits() }), "0 ≤ x ≤ 1")
      XCTAssertEqual(
        ((0...1) as CountableClosedRange).inInequalityNotation({ $0.inDigits() }),
        "0 ≤ x ≤ 1"
      )
    #endif
  }

  func testRationalArithmetic() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      XCTAssertEqual(Double(binary: "10"), 2)
      XCTAssertEqual(Double(binary: "0.000 1"), 1 ÷ 16)

      XCTAssertEqual(
        (1 as RationalNumber).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "1"
      )
      XCTAssertEqual(
        (1 as RationalNumber ÷ 10).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.1"
      )
      XCTAssertEqual(
        (9 as RationalNumber ÷ 10).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.9"
      )
      XCTAssertEqual(
        (1 as RationalNumber ÷ 100).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.01"
      )
      XCTAssertEqual(
        (99 as RationalNumber ÷ 100).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.99"
      )
      XCTAssertEqual(
        (1 as RationalNumber ÷ 1000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.001"
      )
      XCTAssertEqual(
        (999 as RationalNumber ÷ 1000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.999"
      )
      XCTAssertEqual(
        (1 as RationalNumber ÷ 10_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.000 1"
      )
      XCTAssertEqual(
        (9999 as RationalNumber ÷ 10_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.999 9"
      )
      XCTAssertEqual(
        (1 as RationalNumber ÷ 100_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.000 01"
      )
      XCTAssertEqual(
        (99_999 as RationalNumber ÷ 100_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.999 99"
      )
      XCTAssertEqual(
        (1 as RationalNumber ÷ 1_000_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.000 001"
      )
      XCTAssertEqual(
        (999_999 as RationalNumber ÷ 1_000_000).inDigits(
          maximumDecimalPlaces: 7,
          radixCharacter: "."
        ),
        "0.999 999"
      )
      XCTAssertEqual(
        (1 as RationalNumber ÷ 10_000_000).inDigits(maximumDecimalPlaces: 7, radixCharacter: "."),
        "0.000 000 1"
      )
      XCTAssertEqual(
        (9_999_999 as RationalNumber ÷ 10_000_000).inDigits(
          maximumDecimalPlaces: 7,
          radixCharacter: "."
        ),
        "0.999 999 9"
      )

      XCTAssertEqual(
        (1 as RationalNumber ÷ 10_000_000).inDigits(maximumDecimalPlaces: 3, radixCharacter: "."),
        "0.000"
      )
      XCTAssertEqual(
        (999_999 as RationalNumber ÷ 10_000_000).inDigits(
          maximumDecimalPlaces: 3,
          radixCharacter: "."
        ),
        "0.100"
      )
      XCTAssertEqual(
        (9_999_999 as RationalNumber ÷ 10_000_000).inDigits(
          maximumDecimalPlaces: 3,
          radixCharacter: "."
        ),
        "1.000"
      )
    #endif
  }

  func testStateData() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      for state in StateData.list {
        _ = state.code
        _ = state.flag
        _ = state.isolatedName(in: InterfaceLocalization.englishCanada)
      }
      XCTAssertNotNil(StateData(code: "CA"))
      XCTAssertNotNil(StateData(flag: "🇨🇦"))
      XCTAssertNil(StateData(code: "N/A"))
      XCTAssertNil(StateData(flag: "N/A"))
      enum UnsupportedLocalization: String, Localization {
        case unknown = "und"
        static var fallbackLocalization: UnsupportedLocalization = .unknown
      }
      XCTAssertNil(StateData(code: "CA")?.isolatedName(in: UnsupportedLocalization.unknown))
    #endif
  }

  func testUserFacingDynamicText() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      let text = UserFacingDynamic<StrictString, LocalizationExample, (Int, Int)>(
        { localization, numbers in

          switch localization {
          case .englishUnitedKingdom:
            return StrictString("Numbers \(numbers.0.inDigits()) and \(numbers.1.inDigits())")
          case .français:
            return StrictString("Numéros \(numbers.0.inDigits()) et \(numbers.1.inDigits())")
          default:
            return StrictString("\(numbers.0.inDigits()), \(numbers.1.inDigits())")
          }
        })
      XCTAssertEqual(text.resolved(for: .englishUnitedKingdom, using: (0, 1)), "Numbers 0 and 1")
      XCTAssertEqual(text.resolved(for: .français, using: (0, 1)), "Numéros 0 et 1")
      XCTAssert(¬text.resolved(using: (0, 1)).isEmpty)
      let simplified = text.static(using: (1, 2))
      XCTAssertEqual(simplified.resolved(for: .englishUnitedKingdom), "Numbers 1 and 2")

      let simple = UserFacing<StrictString, LocalizationExample>({ localization in

        switch localization {
        case .englishUnitedKingdom:
          return StrictString("Hello, world!")
        case .français:
          return StrictString("Bonjour, le monde !")
        default:
          return "..."
        }
      })
      XCTAssertEqual(simple.resolved(for: .français), "Bonjour, le monde !")
      XCTAssert(¬simple.resolved().isEmpty)

      _ = simplified.wrappedInstance
    #endif
  }

  func testWholeArithmetic() {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
      XCTAssertEqual("1" as Int, 1)

      XCTAssertEqual(Int(hexadecimal: "7F"), 127)
      XCTAssertEqual(Int(octal: "10"), 8)
      XCTAssertEqual(Int(binary: "10000"), 16)

      XCTAssertEqual(WholeNumber("10 000"), 10_000)

      XCTAssertEqual((0 as UInt).inDigits(), "0")
      XCTAssertEqual((1 as UInt).inDigits(), "1")
      XCTAssertEqual((9 as UInt).inDigits(), "9")
      XCTAssertEqual((10 as UInt).inDigits(), "10")
      XCTAssertEqual((999 as UInt).inDigits(), "999")
      XCTAssertEqual((1000 as UInt).inDigits(), "1000")
      XCTAssertEqual((9999 as UInt).inDigits(), "9999")
      XCTAssertEqual((10_000 as UInt).inDigits(), "10 000")
      XCTAssertEqual((999_999 as UInt).inDigits(), "999 999")
      XCTAssertEqual((1_000_000 as UInt).inDigits(), "1 000 000")
      XCTAssertEqual((999_999_999 as UInt).inDigits(), "999 999 999")
      XCTAssertEqual((1_000_000_000 as UInt).inDigits(), "1 000 000 000")

      XCTAssertEqual(1111.inRomanNumerals(), "MCXI")
      XCTAssertEqual(2222.inRomanNumerals(), "MMCCXXII")
      XCTAssertEqual(3333.inRomanNumerals(), "MMMCCCXXXIII")
      XCTAssertEqual(444.inRomanNumerals(), "CDXLIV")
      XCTAssertEqual(555.inRomanNumerals(), "DLV")
      XCTAssertEqual(666.inRomanNumerals(), "DCLXVI")
      XCTAssertEqual(777.inRomanNumerals(), "DCCLXXVII")
      XCTAssertEqual(888.inRomanNumerals(), "DCCCLXXXVIII")
      XCTAssertEqual(999.inRomanNumerals(), "CMXCIX")
      XCTAssertEqual(1000.inRomanNumerals(lowercase: true), "m")
      XCTAssertEqual((1 as Int8).inRomanNumerals(), "I")
      XCTAssertEqual((1 as UInt8).inRomanNumerals(), "I")
      _ = 1_000_000.inRomanNumerals()

      XCTAssertEqual(1.abbreviatedEnglishOrdinal().rawTextApproximation(), "1st")
      XCTAssertEqual(2.abbreviatedEnglishOrdinal().rawTextApproximation(), "2nd")
      XCTAssertEqual(3.abbreviatedEnglishOrdinal().rawTextApproximation(), "3rd")
      XCTAssertEqual(4.abbreviatedEnglishOrdinal().rawTextApproximation(), "4th")
      XCTAssertEqual(11.abbreviatedEnglishOrdinal().rawTextApproximation(), "11th")
      XCTAssertEqual(12.abbreviatedEnglishOrdinal().rawTextApproximation(), "12th")
      XCTAssertEqual(13.abbreviatedEnglishOrdinal().rawTextApproximation(), "13th")
      XCTAssertEqual(14.abbreviatedEnglishOrdinal().rawTextApproximation(), "14th")
      XCTAssertEqual(21.abbreviatedEnglishOrdinal().rawTextApproximation(), "21st")
      XCTAssertEqual(22.abbreviatedEnglishOrdinal().rawTextApproximation(), "22nd")
      XCTAssertEqual(23.abbreviatedEnglishOrdinal().rawTextApproximation(), "23rd")
      XCTAssertEqual(24.abbreviatedEnglishOrdinal().rawTextApproximation(), "24th")

      testCustomStringConvertibleConformance(
        of: TextConvertibleNumberParseError.invalidDigit("a", entireString: "abc"),
        localizations: _InterfaceLocalization.self,
        uniqueTestName: "Invalid Digit",
        overwriteSpecificationInsteadOfFailing: false
      )
      _ = TextConvertibleNumberParseError.invalidDigit("a", entireString: "abc").errorDescription

      XCTAssertEqual((10_000 as UInt).inZahlzeichen(), "10 000")
      XCTAssertEqual(777.inRömischerZahlschrift(), "DCCLXXVII")
      XCTAssertEqual((777 as UInt).inRömischerZahlschrift(), "DCCLXXVII")
    #endif
  }
}
