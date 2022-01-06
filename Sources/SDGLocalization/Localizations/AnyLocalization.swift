/*
 AnyLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type‐erased wrapper for around any `Localization`.
public struct AnyLocalization: Localization {

  // MARK: - Initialization

  /// Wraps a localization.
  ///
  /// - Parameters:
  ///   - localization: The localization.
  public init<L>(_ localization: L) where L: Localization {
    self.code = localization.code
  }

  /// Creates a localization with a code.
  ///
  /// - Parameters:
  ///   - code: The code.
  public init(code: String) {
    self.code = code
  }

  // MARK: - Localization

  public init?(exactly code: String) {
    self.init(code: code)
  }

  public let code: String

  public static var fallbackLocalization: AnyLocalization = AnyLocalization(
    ContentLocalization.fallbackLocalization
  )
}
