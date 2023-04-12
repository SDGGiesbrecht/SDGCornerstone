/*
 LocalizationData.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

/// Data about a localization.
///
/// This structure provides access to data used internally by SDGLocalization.
public struct LocalizationData: Sendable {

  // MARK: - List

  /// Returns a list of all supported localizations.
  ///
  /// - Important: The list of localizations is not intended to be exhaustive. It contains only those necessary for other `SDGLocalization` functionality. Particular localizations may be added or removed at any time.
  public static var list: AnySequence<LocalizationData> {
    return AnySequence(
      ContentLocalization.allCases.lazy.map({ LocalizationData(localization: $0) })
    )
  }

  // MARK: - Initialization

  private init(localization: ContentLocalization) {
    self.localization = localization
  }

  /// Creates localization data for a particular IETF language code, or returns `nil` if the code is not supported.
  ///
  /// - Important: Not all valid codes are supported—only those necessary for other `SDGLocalization` functionality. Support for a particular localization may be added or removed at any time.
  ///
  /// - Parameters:
  ///   - code: The IETF language code.
  public init?(code: String) {
    if let localization = ContentLocalization(exactly: code) {
      self = LocalizationData(localization: localization)
    } else {
      return nil
    }
  }

  /// Creates localization data for a particular icon, or returns `nil` if the icon is not supported.
  ///
  /// - Important: Not all valid icons are supported—only those necessary for other `SDGLocalization` functionality. Support for a particular localization may be added or removed at any time.
  ///
  /// - Parameters:
  ///   - icon: The icon.
  public init?(icon: StrictString) {
    if let localization = ContentLocalization(icon: icon) {
      self = LocalizationData(localization: localization)
    } else {
      return nil
    }
  }

  // MARK: - Properties

  private let localization: ContentLocalization

  /// The IETF language code.
  public var code: String {
    return localization.code
  }

  /// The icon.
  public var icon: StrictString {
    return localization.icon!
  }

  // MARK: - Descriptions

  /// Returns the isolated form of this localization’s name in the provided localization, or `nil` if the localization is not supported.
  ///
  /// - Important: Not all localizations are supported—only those necessary for other `SDGLocalization` functionality. Support for a particular localization may be added or removed at any time.
  ///
  /// - Parameters:
  ///   - localization: The localization in which to provide the name.
  public func isolatedName<L>(in localization: L) -> StrictString? where L: Localization {
    if let localization = _InterfaceLocalization(exactly: localization.code) {
      return self.localization.isolatedName().resolved(for: localization)
    } else {
      return nil
    }
  }
}
