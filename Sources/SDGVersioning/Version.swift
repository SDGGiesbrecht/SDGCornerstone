/*
 Version.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A semantic version.
public struct Version: Codable, Comparable, Equatable, ExpressibleByStringLiteral, Hashable,
  Sendable, TextualPlaygroundDisplay
{

  // MARK: - Initialization

  /// Creates a version.
  ///
  /// - Parameters:
  ///   - major: The major version number.
  ///   - minor: Optional. The minor version number.
  ///   - patch: Optional. The patch version number.
  public init(_ major: Int, _ minor: Int = 0, _ patch: Int = 0) {
    self.major = major
    self.minor = minor
    self.patch = patch
  }

  // MARK: - Properties

  /// The major version number.
  public var major: Int
  /// The minor version number.
  public var minor: Int
  /// The patch version number.
  public var patch: Int

  // MARK: - Usage

  /// The range of compatible versions.
  ///
  /// i.e. 1.2.3 is compatible with any version where 1.2.3 ≤ x < 2.0.0.
  ///
  /// This property assumes that versions beginning with a zero increment the second number for breaking changes and the third for compatible changes. i.e. 0.1.2 is compatible with any version where 0.1.2 ≤ x < 0.2.0.
  public var compatibleVersions: Range<Version> {
    let nextIncompatible: Version

    if major == 0 {
      nextIncompatible = Version(major, minor + 1)
    } else {
      nextIncompatible = Version(major + 1)
    }

    return self..<nextIncompatible
  }

  // MARK: - String Representations

  /// Returns the version’s string representation.
  ///
  /// - Parameters:
  ///   - droppingEmptyPatch: Optional. Set to `true` to have the patch number left off if it is zero. (i.e. “1.0” instead of “1.0.0”, but still “1.0.1” regardless.)
  public func string(droppingEmptyPatch: Bool = false) -> String {
    var result = "\(major).\(minor)"
    if ¬droppingEmptyPatch ∨ patch ≠ 0 {
      result += ".\(patch)"
    }
    return result
  }

  /// Creates a version from its string representation.
  ///
  /// - Parameters:
  ///   - string: The version string.
  public init?(_ string: String) {
    let parsed: [String] = string.components(separatedBy: ".").map { String($0.contents) }
    var sections = parsed[parsed.bounds]

    self = Version(0)  // Initialize empty to allow use of property references below.

    func parseNext(into destination: inout Int) -> Bool {
      if let next = sections.popFirst() {
        guard let number = Int(next) else {
          return false
        }
        destination = number
      } else {
        destination = 0
      }
      return true
    }

    if ¬parseNext(into: &major) {
      return nil
    }

    if ¬parseNext(into: &minor) {
      return nil
    }

    if ¬parseNext(into: &patch) {
      return nil
    }

    if ¬sections.isEmpty {
      return nil
    }
  }

  /// Creates an instance representing the first version in a string.
  ///
  /// - Parameters:
  ///   - string: The string to look for the version in.
  public init?(firstIn string: String) {
    let versionDigits: Set<Unicode.Scalar> = [
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    ]
    let versionSeparators: Set<Unicode.Scalar> = ["."]
    let versionScalars = versionDigits ∪ versionSeparators
    let versionPattern = RepetitionPattern(
      ConditionalPattern<StrictString>({ (scalar: UnicodeScalar) in
        return scalar ∈ versionScalars
      }),
      count: 1..<Int.max
    )
    let components = StrictString(string).matches(for: versionPattern)
      .lazy.map({ match -> String in
        var component = StrictString(match.contents)
        // Remove trailing dots.
        while let last = component.last,
          last ∈ versionSeparators
        {
          component.removeLast()
        }
        return String(component)
      })

    for possibleMatch in components {
      if let version = Version(possibleMatch) {
        self = version
        return
      }
    }

    return nil
  }

  // MARK: - Comparable

  public static func < (precedingValue: Version, followingValue: Version) -> Bool {
    return compare(precedingValue, followingValue, by: { $0.major }, { $0.minor }, { $0.patch })
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return string()
  }

  // MARK: - ExpressibleByStringLiteral

  public init(stringLiteral: String) {
    guard let result = Version(stringLiteral) else {
      preconditionFailure(
        UserFacing<StrictString, APILocalization>({ localization in
          switch localization {
          case .englishCanada:  // @exempt(from: tests)
            return "“\(stringLiteral)” is not a version number."
          }
        })
      )
    }
    self = result
  }
}
