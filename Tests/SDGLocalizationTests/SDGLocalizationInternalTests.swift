/*
 SDGLocalizationInternalTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
@testable import SDGLocalization
import SDGCornerstoneLocalizations

import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class SDGLocalizationInternalTests : TestCase {

    func testContentLocalization() {
        for localization in ContentLocalization.cases {

            // Make sure its group is defined.
            let components: [String] = localization.code.components(separatedBy: "\u{2D}")

            if let group = ContentLocalization.groups[components.first! ] {
                XCTAssert(group.map({ $0.countries }).joined().contains(components.last!), "\(localization.code) is missing from its group.")
            } else {
                XCTFail("\(localization.code) has no group defined.")
            }

            let abbreviatedCode = (localization.code.components(separatedBy: "\u{2D}") as [String]).first!
            XCTAssertNotNil(ContentLocalization(reasonableMatchFor: abbreviatedCode))

            // Make sure it has an icon.
            if let icon = localization.icon {
                // Make sure it can be recreated from the icon.
                XCTAssertEqual(localization, ContentLocalization(definedIcon: icon))
            } else {
                XCTFail("\(localization.code) has no icon.")
            }

            testCustomStringConvertibleConformance(of: localization, localizations: InterfaceLocalization.self, uniqueTestName: localization.icon!, overwriteSpecificationInsteadOfFailing: false)
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
        for localization in InterfaceLocalization.cases {
            XCTAssertNotNil(ContentLocalization(exactly: localization.code))

            if let icon = localization.icon {
                XCTAssertEqual(localization, InterfaceLocalization(icon: icon))
            } else {
                XCTFail("\(localization.code) has no icon.")
            }
        }
    }

    func testLocalizationSetting() {
        XCTAssertNotNil(LocalizationSetting.osSystemWidePreferences.value.as([String].self), "Failed to detect operating system localization setting.")

        LocalizationSetting.setSystemWidePreferences(to: nil)
        LocalizationSetting.setApplicationPreferences(to: nil)

        LocalizationSetting.setSystemWidePreferences(to: LocalizationSetting(orderOfPrecedence: ["en"]))
        XCTAssertEqual(LocalizationSetting.current.value.resolved() as SDGLocalizationAPITests.LocalizationExample, .englishUnitedKingdom)
        LocalizationSetting.setSystemWidePreferences(to: LocalizationSetting(orderOfPrecedence: ["fr"]))
        XCTAssertEqual(LocalizationSetting.current.value.resolved() as SDGLocalizationAPITests.LocalizationExample, .français)

        LocalizationSetting.setSystemWidePreferences(to: nil)
    }

    static var allTests: [(String, (SDGLocalizationInternalTests) -> () throws -> Void)] {
        return [
            ("testContentLocalization", testContentLocalization),
            ("testInterfaceLocalization", testInterfaceLocalization),
            ("testLocalizationSetting", testLocalizationSetting)
        ]
    }
}
