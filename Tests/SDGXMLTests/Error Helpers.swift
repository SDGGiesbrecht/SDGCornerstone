/*
 Error Helpers.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

import SDGPersistenceTestUtilities

func testErrorDecsription(
  triggerError: () throws -> String,
  specification: StrictString,
  overwriteSpecificationInsteadOfFailing: Bool,
  file: StaticString = #filePath,
  line: UInt = #line
) rethrows {
  let specifications = testSpecificationDirectory().appendingPathComponent("Codable Errors")
  let specification = specifications.appendingPathComponent(String(specification))

  for localization in InterfaceLocalization.allCases {
    try LocalizationSetting(orderOfPrecedence: [localization.code]).do {
      let localizationFile = specification.appendingPathComponent("\(localization.icon!).txt")

      compare(
        try triggerError(),
        against: localizationFile,
        overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing,
        file: file,
        line: line
      )
    }
  }
}
