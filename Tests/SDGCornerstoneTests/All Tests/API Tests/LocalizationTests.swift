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
        XCTAssertEqual(LocalizationExample(exactly: "fr")?.code, "fr")
        XCTAssertEqual(LocalizationExample(exactly: "en\u{2D}GB"), .englishUnitedKingdom)
        XCTAssertNil(LocalizationExample(exactly: "en\u{2D}"))
        XCTAssertEqual(LocalizationExample(reasonableMatchFor: "en\u{2D}US"), .englishUnitedKingdom)
        XCTAssertEqual(LocalizationExample(reasonableMatchFor: "fr\u{2D}FR"), .français)
        XCTAssertNil(LocalizationExample(reasonableMatchFor: "el"))
        XCTAssertNil(LocalizationExample(reasonableMatchFor: "zxx"))
        XCTAssertEqual(LocalizationExample(reasonableMatchFor: "cmn\u{2D}Hant\u{2D}"), .chineseTraditionalTaiwan)
        XCTAssertEqual(LocalizationExample(reasonableMatchFor: "cmn\u{2D}TW\u{2D}"), .chineseTraditionalTaiwan)
        XCTAssertEqual(LocalizationExample(reasonableMatchFor: "zsm"), .malaysianLatin)
        XCTAssertEqual(LocalizationExample(reasonableMatchFor: "zh"), .chineseTraditionalTaiwan)
        XCTAssertNil(LocalizationExample(reasonableMatchFor: "ar"))
        XCTAssertNil(LocalizationExample(reasonableMatchFor: "arb"))
        XCTAssertEqual(LocalizationExample(reasonableMatchFor: "arb\u{2D}Arab"), nil)
        XCTAssertEqual(LocalizationExample(reasonableMatchFor: "nb"), .norwegian)
    }

    func testLocalizationSetting() {
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
        XCTAssertEqual(LocalizationSetting.current.value.resolved() as LocalizationExample, .englishUnitedKingdom)
        LocalizationSetting.setApplicationPreferences(to: LocalizationSetting(orderOfPrecedence: ["fr"]))
        XCTAssertEqual(LocalizationSetting.current.value.resolved() as LocalizationExample, .français)

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
        XCTAssertEqual(text.resolved(for: .englishUnitedKingdom, using: (0, 1)), "Numbers 0 and 1")
        XCTAssertEqual(text.resolved(for: .français, using: (0, 1)), "Numéros 0 et 1")
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
        XCTAssertEqual(simple.resolved(for: .français), "Bonjour, le monde !")
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
