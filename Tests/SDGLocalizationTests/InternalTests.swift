/*
 InternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections
@testable import SDGLocalization

import SDGCornerstoneLocalizations

import XCTest

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class InternalTests: TestCase {

  func testContentLocalization() {
    for localization in ContentLocalization.allCases {

      // Make sure its group is defined.
      let components: [String] = localization.code.components(separatedBy: "\u{2D}")

      if let group = ContentLocalization.groups[components.first!] {
        XCTAssert(
          group.map({ $0.countries }).joined().contains(components.last!),
          "\(localization.code) is missing from its group."
        )
      } else {
        XCTFail("\(localization.code) has no group defined.")
      }

      let abbreviatedCode = (localization.code.components(separatedBy: "\u{2D}") as [String])
        .first!
      XCTAssertNotNil(ContentLocalization(reasonableMatchFor: abbreviatedCode))

      // Make sure it has an icon.
      if let icon = localization.icon {
        // Make sure it can be recreated from the icon.
        XCTAssertEqual(localization, ContentLocalization(definedIcon: icon))
      } else {
        XCTFail("\(localization.code) has no icon.")
      }

      testCustomStringConvertibleConformance(
        of: localization,
        localizations: InterfaceLocalization.self,
        uniqueTestName: localization.icon!,
        overwriteSpecificationInsteadOfFailing: false
      )

      XCTAssert(
        ContentLocalization.codeSet() ⊇ InterfaceLocalization.codeSet(),
        "Content should support at least every localization the interface elements do."
      )
    }

    // Make sure each group member is defined.
    for (languageCode, scripts) in ContentLocalization.groups {
      for (scriptCode, countries) in scripts {
        for country in countries {
          var orthography = languageCode
          if scripts.count ≠ 1 {
            orthography += "\u{2D}" + scriptCode
          }
          let code = orthography + "\u{2D}" + country

          if country ≠ "419" {
            XCTAssertNotNil(ContentLocalization(exactly: code), "\(code) is not defined.")
          }
        }
      }
    }
  }

  func testInterfaceLocalization() {
    for localization in InterfaceLocalization.allCases {
      XCTAssertNotNil(ContentLocalization(exactly: localization.code))

      if let icon = localization.icon {
        XCTAssertEqual(localization, InterfaceLocalization(icon: icon))
      } else {
        XCTFail("\(localization.code) has no icon.")
      }
    }
  }

  func testLocalizationSetting() {
    var expectOperatingSystemLanguage = true
    expectOperatingSystemLanguage = true  // Evade static analysis.
    #if os(macOS) || os(Linux)
      if ProcessInfo.processInfo.environment["GITHUB_ACTIONS"] == "true" {
        // GitHub’s host has no language set.
        expectOperatingSystemLanguage = false
      }
    #endif
    #if targetEnvironment(simulator) && (os(tvOS) || os(iOS) || os(watchOS))
      // Default simulator state has no language set.
      expectOperatingSystemLanguage = false
    #endif
    #if os(Android)  // #workaround(Swift 5.3.2, Not possible yet.)
      expectOperatingSystemLanguage = false
    #endif
    #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
      if expectOperatingSystemLanguage {
        XCTAssertNotNil(
          LocalizationSetting.osSystemWidePreferences.value.as([String].self),
          "Failed to detect operating system localization setting."
        )
      }

      LocalizationSetting.setSystemWidePreferences(to: nil)
      LocalizationSetting.setApplicationPreferences(to: nil)

      LocalizationSetting.setSystemWidePreferences(
        to: LocalizationSetting(orderOfPrecedence: ["en"])
      )
      XCTAssertEqual(
        LocalizationSetting.current.value.resolved() as APITests.LocalizationExample,
        .englishUnitedKingdom
      )
      LocalizationSetting.setSystemWidePreferences(
        to: LocalizationSetting(orderOfPrecedence: ["fr"])
      )
      XCTAssertEqual(
        LocalizationSetting.current.value.resolved() as APITests.LocalizationExample,
        .français
      )

      LocalizationSetting.setSystemWidePreferences(to: nil)
    #endif
  }

  func testWholeNumber() {
    var list = ""
    for number in 1...2 {
      XCTAssertEqual(
        number.abgekürzteDeutscheOrdnungszahl(),
        UInt(number).abgekürzteDeutscheOrdnungszahl()
      )
      for genre in [.masculin, .féminin] as [GenreGrammatical] {
        for nombre in [.singular, .plural] as [GrammaticalNumber] {
          XCTAssertEqual(
            number.ordinalFrançaisAbrégé(genre: genre, nombre: nombre),
            UInt(number).ordinalFrançaisAbrégé(genre: genre, nombre: nombre)
          )
          print(number.ordinalFrançaisAbrégé(genre: genre, nombre: nombre).html(), to: &list)
        }
      }
    }
    compare(
      list,
      against: testSpecificationDirectory().appendingPathComponent("Ordinals.txt"),
      overwriteSpecificationInsteadOfFailing: false
    )
    var numerals = ""
    for number in [1000, 1111, 2222, 3333, 4444, 5555, 6666, 7777, 8888, 9999, 10_000] {

      XCTAssertEqual(number.inDigits(), UInt(number).inDigits())
      print(number.inDigits(), to: &numerals)

      XCTAssertEqual(number.σεΕλληνικούςΑριθμούς(), UInt(number).σεΕλληνικούςΑριθμούς())
      print(number.σεΕλληνικούςΑριθμούς(), to: &numerals)

      XCTAssertEqual(
        number.σεΕλληνικούςΑριθμούς(μικράΓράμματα: true, κεραία: false),
        UInt(number).σεΕλληνικούςΑριθμούς(μικράΓράμματα: true, κεραία: false)
      )
      print(number.σεΕλληνικούςΑριθμούς(μικράΓράμματα: true, κεραία: false), to: &numerals)

      XCTAssertEqual(number.בספרות־עבריות(), UInt(number).בספרות־עבריות())
      print(number.בספרות־עבריות(), to: &numerals)

      XCTAssertEqual(number.ספרות־עבריות(גרשיים: false), UInt(number).ספרות־עבריות(גרשיים: false))
      print(number.ספרות־עבריות(גרשיים: false), to: &numerals)

      print("", to: &numerals)
    }
    compare(
      numerals,
      against: testSpecificationDirectory().appendingPathComponent("Numerals.txt"),
      overwriteSpecificationInsteadOfFailing: false
    )
  }
}
