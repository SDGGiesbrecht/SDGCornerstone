/*
 LocalizationTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGCornerstone

class LocalizationTests : TestCase {

    func testLocalization() {
        XCTAssert(LocalizationExample(exactly: "fr")?.code == "fr")
        XCTAssert(LocalizationExample(exactly: "en\u{2D}GB") == .englishUnitedKingdom)
        XCTAssert(LocalizationExample(exactly: "en\u{2D}") == nil)
        XCTAssert(LocalizationExample(reasonableMatchFor: "en\u{2D}US") == .englishUnitedKingdom, "en\u{2D}US → \(String(describing: LocalizationExample(reasonableMatchFor: "en\u{2D}US"))) ≠ en\u{2D}GB")
        XCTAssert(LocalizationExample(reasonableMatchFor: "fr\u{2D}FR") == .français, "fr\u{2D}FR → \(String(describing: LocalizationExample(reasonableMatchFor: "fr\u{2D}FR"))) ≠ fr")
        XCTAssert(LocalizationExample(reasonableMatchFor: "el") == nil)
        XCTAssert(LocalizationExample(reasonableMatchFor: "zxx") == nil)
        XCTAssert(LocalizationExample(reasonableMatchFor: "cmn\u{2D}Hant\u{2D}") == .chineseTraditionalTaiwan)
        XCTAssert(LocalizationExample(reasonableMatchFor: "cmn\u{2D}TW\u{2D}") == .chineseTraditionalTaiwan)
        XCTAssert(LocalizationExample(reasonableMatchFor: "zsm") == .malaysianLatin)
        XCTAssert(LocalizationExample(reasonableMatchFor: "zh") == .chineseTraditionalTaiwan)
        XCTAssert(LocalizationExample(reasonableMatchFor: "ar") == nil)
        XCTAssert(LocalizationExample(reasonableMatchFor: "arb") == nil)
        XCTAssert(LocalizationExample(reasonableMatchFor: "arb\u{2D}Arab") == nil)
        XCTAssert(LocalizationExample(reasonableMatchFor: "nb") == .norwegian)
    }

    func testLocalizationSetting() {
        let english = LocalizationSetting(orderOfPrecedence: ["en", "fr"])
        XCTAssert(english.resolved() as LocalizationExample == .englishUnitedKingdom)

        let unrecognized = LocalizationSetting(orderOfPrecedence: [["zxx"]])
        XCTAssert(unrecognized.resolved() as LocalizationExample == .englishUnitedKingdom)

        english.do {
            XCTAssert(LocalizationSetting.current.value == english)
        }
        let français = LocalizationSetting(orderOfPrecedence: ["fr"])
        français.do {
            XCTAssert(LocalizationSetting.current.value == français)
        }

        let multilingual = LocalizationSetting(orderOfPrecedence: [["en", "fr"]])
        var englishUsed = false
        var françaisUtilisé = false
        multilingual.do {
            for _ in 1 ... 100 where ¬englishUsed ∨ ¬françaisUtilisé {
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

        LocalizationSetting.setApplicationPreferences(to: nil)

        LocalizationSetting.setApplicationPreferences(to: LocalizationSetting(orderOfPrecedence: ["en"]))
        XCTAssert(LocalizationSetting.current.value.resolved() as LocalizationExample == .englishUnitedKingdom)
        LocalizationSetting.setApplicationPreferences(to: LocalizationSetting(orderOfPrecedence: ["fr"]))
        XCTAssert(LocalizationSetting.current.value.resolved() as LocalizationExample == .français)

        LocalizationSetting.setApplicationPreferences(to: nil)
    }

    func testUserFacingText() {

        let text = UserFacingText({ (localization: LocalizationExample, numbers: (Int, Int)) -> StrictString in

            switch localization {
            case .englishUnitedKingdom:
                return StrictString("Numbers \(numbers.0) and \(numbers.1)")
            case .français:
                return StrictString("Numéros \(numbers.0) et \(numbers.1)")
            default:
                return StrictString("\(numbers.0), \(numbers.1)")
            }
        })
        XCTAssert(text.resolved(for: .englishUnitedKingdom, using: (0, 1)) == "Numbers 0 and 1")
        XCTAssert(text.resolved(for: .français, using: (0, 1)) == "Numéros 0 et 1")
        XCTAssert(¬text.resolved(using: (0, 1)).isEmpty)
        
        let simple = UserFacingText({ (localization: LocalizationExample, _: Void) -> StrictString in

            switch localization {
            case .englishUnitedKingdom:
                return StrictString("Hello, world!")
            case .français:
                return StrictString("Bonjour, le monde !")
            default:
                return "..."
            }
        })
        XCTAssert(simple.resolved(for: .français) == "Bonjour, le monde !")
        XCTAssert(¬simple.resolved().isEmpty)
    }

    static var allTests: [(String, (LocalizationTests) -> () throws -> Void)] {
        return [
            ("testLocalization", testLocalization),
            ("testLocalizationSetting", testLocalizationSetting),
            ("testUserFacingText", testUserFacingText)
        ]
    }
}
