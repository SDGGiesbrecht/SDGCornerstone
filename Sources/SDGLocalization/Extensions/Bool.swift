/*
 Bool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension Bool {

  /// Returns “✓” or “✗”.
  public func checkOrX() -> StrictString {
    switch self {
    case true:
      return "✓"
    case false:
      return "✗"
    }
  }

  /// Returns “true” or “false”.
  ///
  /// - Parameters:
  ///     - casing: The casing to use.
  public func trueOrFalse(_ casing: EnglishCasing) -> StrictString {
    switch self {
    case true:
      return casing.apply(to: "true")
    case false:
      return casing.apply(to: "false")
    }
  }

  /// Returns “yes” or “no”.
  ///
  /// - Parameters:
  ///     - casing: The casing to use.
  public func yesOrNo(_ casing: EnglishCasing) -> StrictString {
    switch self {
    case true:
      return casing.apply(to: "yes")
    case false:
      return casing.apply(to: "no")
    }
  }
}
