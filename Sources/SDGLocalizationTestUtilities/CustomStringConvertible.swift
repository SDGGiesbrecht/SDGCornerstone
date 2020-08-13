/*
 CustomStringConvertible.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation
#endif

import SDGText
import SDGPersistence
import SDGLocalization

import SDGPersistenceTestUtilities

/// Tests a type’s conformance to CustomStringConvertible.
///
/// This function will write the description to the test specification directory in the project repository and will compare against it on future calls. It is recommeded to check those specifications into source control to monitor changes in the description.
///
/// To update the specification instead of testing against it, change `overwriteSpecificationInsteadOfFailing` to `true` and re‐run the test suite. The specification will be rewritten to match the descriptions. *Do not forget to change it back afterward, or the test will cease to validate anything.*
///
/// - Parameters:
///     - instance: An instance to get a description from.
///     - localizations: The localization set to test.
///     - uniqueTestName: A unique name for the test. This is used in the path to the persistent test specifications.
///     - overwriteSpecificationInsteadOfFailing: Set to `false` for normal behaviour. Set to `true` temporarily to update the specification.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testCustomStringConvertibleConformance<T, L>(
  of instance: T,
  localizations: L.Type,
  uniqueTestName: StrictString,
  overwriteSpecificationInsteadOfFailing: Bool,
  file: StaticString = #file,
  line: UInt = #line
) where T: CustomStringConvertible, L: InputLocalization {

  var report = ""
  for localization in localizations.allCases {
    #warning("Succeeded here.")
    if let icon = localization.icon {
      #warning("Here?")
      return
      report.append(contentsOf: String(icon))
    } else {
      #warning("Here?")
      return
      report.append(contentsOf: localization.code)
    }
    report.append("\n")
    #warning("Failed here.")
    return
    LocalizationSetting(orderOfPrecedence: [localization.code]).do {
      print(String(describing: instance), to: &report)
    }
    print("", to: &report)
  }

  // #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
  #if !os(WASI)
    func fileName(typeName: String) -> URL {
      testSpecificationDirectory(file)
        .appendingPathComponent("CustomStringConvertible")
        .appendingPathComponent(typeName)
        .appendingPathComponent(String(uniqueTestName) + ".txt")
    }
    let deprecated = fileName(typeName: "\(T.self)")
    let specification = fileName(
      typeName: "\(T.self)"
        .replacingMatches(for: "<", with: "⟨")
        .replacingMatches(for: ">", with: "⟩")
    )
    try? FileManager.default.move(deprecated, to: specification)
    SDGPersistenceTestUtilities.compare(
      report,
      against: specification,
      overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing,
      file: file,
      line: line
    )
  #endif

  if let playground = instance as? CustomPlaygroundDisplayConvertible {
    _ = playground.playgroundDescription
  }
}
