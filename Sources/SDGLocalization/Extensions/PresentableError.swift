/*
 PresentableError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText

/// An error suitable to present to users.
public protocol PresentableError: CustomStringConvertible, LocalizedError {

  /// Returns a localized description of the error.
  func presentableDescription() -> StrictString
}

extension PresentableError {

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(presentableDescription())
  }

  // MARK: - Error

  /// The localized description for this error.
  public var errorDescription: String? {
    return String(presentableDescription())
  }
}
