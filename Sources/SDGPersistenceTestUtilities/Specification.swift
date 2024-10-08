/*
 Specification.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

import SDGTesting

@usableFromInline internal var specificationDirectory: URL?

/// Sets the directory where test specifications should be stored.
///
/// The directory should be specified relative to a source file using some combination of `#filePath` and `deletingLastPathComponent()`.
/// - Parameters:
///   - directory: The directory.
public func setTestSpecificationDirectory(to directory: URL) {
  specificationDirectory = directory
}

private func defaultRepositoryRoot(_ callerLocation: StaticString) -> URL {
  return URL(fileURLWithPath: String(describing: callerLocation))
    .deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
}
/// Returns the directory where test specifications should be stored.
///
/// The directory can be set by `setTestSpecificationDirectory(to:)`. Otherwise the default directory is determined relative to the first calling source file based on the assumption that that it is in a Swift Package Manager test target, and not in any further subdirectories.
///
/// This method normally assumes the package source is still accessible in the same location as it was compiled from. If that is not the case, the `SWIFTPM_PACKAGE_ROOT` environment variable, can be used to direct this function to look for the package at a different location instead.
///
/// - Parameters:
///   - callerLocation: Optional. A different file to consider as the location of the call.
public func testSpecificationDirectory(_ callerLocation: StaticString = #filePath) -> URL {
  return cached(in: &specificationDirectory) {
    let repositoryRoot: URL
    if let overridden = ProcessInfo.processInfo
      .environment["SWIFTPM_PACKAGE_ROOT"]
    {
      // @exempt(from: tests)
      repositoryRoot = URL(fileURLWithPath: overridden)
    } else {
      repositoryRoot = defaultRepositoryRoot(callerLocation)
    }
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
///   - string: The string to test.
///   - specification: The location of the specification to compare against (or write to).
///   - overwriteSpecificationInsteadOfFailing: Set to `false` for normal behaviour. Set to `true` temporarily to update a specification.
///   - file: Optional. A different source file to associate with any failures.
///   - line: Optional. A different line to associate with any failures.
public func compare(
  _ string: String,
  against specification: URL,
  overwriteSpecificationInsteadOfFailing: Bool,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  purgingAutoreleased {

    if overwriteSpecificationInsteadOfFailing {
      do {
        #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
          try StrictString(string).save(to: specification)  // Enforce a normalized specification.
        #endif
      } catch {
        fail("\(error)", file: file, line: line)
      }
      return
    }

    #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
      guard let immutableSpecificationString = try? String(from: specification) else {
        do {
          try StrictString(string).save(to: specification)  // Enforce a normalized specification.
        } catch {
          fail("\(error)", file: file, line: line)
        }
        return
      }
      #if os(Windows)  // Evade warning about never being mutated on some platforms.
        var specificationString = immutableSpecificationString
      #else
        let specificationString = immutableSpecificationString
      #endif

      #if os(Windows)
        // On Windows, Git may have butchered the newlines during checkout.
        specificationString.scalars.replaceMatches(for: "\r\n".scalars, with: "\n".scalars)
      #endif

      if string == specificationString {
        return  // Passing
      }

      // These need to be random access collections.
      let stringLines: [String] = string.lines
        .map({ String($0.line) + String($0.newline) })
      let specificationLines: [String] = specificationString.lines
        .map({ String($0.line) + String($0.newline) })
      let differences = stringLines.changes(from: specificationLines)

      var removals: Set<Int> = []
      var inserts: [Int: String] = [:]
      for difference in differences {
        switch difference {
        case .remove(let offset, _, _):
          removals.insert(offset)
        case .insert(let offset, let element, _):
          inserts[offset] = element
        }
      }

      var reportArray: [String] = []
      var resultOffset = 0
      var originalOffset = 0
      var continuingKeptRange = false
      while resultOffset ≠ stringLines.count ∨ originalOffset ≠ specificationLines.count {
        defer {
          resultOffset += 1
          originalOffset += 1
        }

        if originalOffset ∈ removals {
          reportArray.append(
            "− "
              + specificationLines[
                specificationLines.index(specificationLines.startIndex, offsetBy: originalOffset)
              ]
          )
          resultOffset −= 1
          continuingKeptRange = false
        } else if let insert = inserts[resultOffset] {
          reportArray.append("+ " + insert)
          originalOffset −= 1
          continuingKeptRange = false
        } else {
          if ¬continuingKeptRange {
            reportArray.append("  [...]\n")
          }
          continuingKeptRange = true
        }
      }
      let report = reportArray.joined()

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
    #endif
  }
}
