/*
 Specification.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

import SDGTesting

@usableFromInline internal var specificationDirectory: URL?

/// Sets the directory where test specifications should be stored.
///
/// The directory should be specified relative to a source file using some combination of `#file` and `deletingLastPathComponent()`.
/// - Parameters:
///     - directory: The directory.
public func setTestSpecificationDirectory(to directory: URL) {
  specificationDirectory = directory
}

/// Returns the directory where test specifications should be stored.
///
/// The directory can be set by `setTestSpecificationDirectory(to:)`. Otherwise the default directory is determined relative to the first calling source file based on the assumption that that it is in a Swift Package Manager test target, and not in any further subdirectories.
///
/// - Parameters:
///     - callerLocation: Optional. A different file to consider as the location of the call.
public func testSpecificationDirectory(_ callerLocation: StaticString = #file) -> URL {
  return cached(in: &specificationDirectory) {
    let repositoryRoot = URL(fileURLWithPath: String(describing: callerLocation))
      .deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    return repositoryRoot.appendingPathComponent("Tests/Test Specifications")
  }
}

/// Compares a string against a test specification.
///
/// If the string does not match the specification, the test will fail.
///
/// If the specification does not exist yet, it will be created according to the string. It is recommeded to check specifications into source control to monitor changes.
///
/// To update a specification instead of testing against it, change `overwriteSpecificationInsteadOfFailing` to `true` and re‐run the test suite. The specification will be rewritten to match the provided string. *Do not forget to change it back afterward, or the test will cease to validate anything.*
///
/// - Parameters:
///     - string: The string to test.
///     - specification: The location of the specification to compare against (or write to).
///     - overwriteSpecificationInsteadOfFailing: Set to `false` for normal behaviour. Set to `true` temporarily to update a specification.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func compare(
  _ string: String,
  against specification: URL,
  overwriteSpecificationInsteadOfFailing: Bool,
  file: StaticString = #file,
  line: UInt = #line
) {
  autoreleasepool {

    guard let specificationString = try? String(from: specification) else {
      do {
        try StrictString(string).save(to: specification)  // Enforce a normalized specification.
      } catch {
        fail("\(error)", file: file, line: line)
      }
      return
    }
    if string == specificationString {
      return  // Passing
    }
    // @exempt(from: tests) Not testable (would require failing a test).

    if overwriteSpecificationInsteadOfFailing {
      do {
        try StrictString(string).save(to: specification)  // Enforce a normalized specification.
      } catch {
        fail("\(error)", file: file, line: line)
      }
      return
    }

    let stringLines = string.lines.map({ String($0.line) })
    let specificationLines = specificationString.lines.map({ String($0.line) })
    let differences = stringLines.groupedDifferences(from: specificationLines)

    var report = ""
    for difference in differences {
      switch difference {
      case .keep:
        print("  [...]", to: &report)
      case .remove(let range):
        print(specificationLines[range].map({ "− " + $0 }).joined(separator: "\n"), to: &report)
      case .insert(let range):
        print(stringLines[range].map({ "+ " + $0 }).joined(separator: "\n"), to: &report)
      }
    }

    fail(
      String(
        UserFacing<StrictString, APILocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "String does not match specification.\n\(specification.path)\n\n\(report)\n"
          }
        }).resolved()
      ),
      file: file,
      line: line
    )
  }
}
