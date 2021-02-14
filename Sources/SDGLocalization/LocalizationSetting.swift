/*
 LocalizationSetting.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(WinSDK)
  import WinSDK
#endif

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGPersistence

/// A localization setting describing a list of preferred localizations and their order of precedence.
public struct LocalizationSetting: CustomPlaygroundDisplayConvertible, CustomStringConvertible,
  Decodable, Encodable, Equatable
{

  // MARK: - Static Properties

  private static let sdgDomainSuffix = ".Language"
  private static let applePreferenceKey = "AppleLanguages"
  private static let sdgPreferenceKey = "SDGLanguages"

  #if canImport(WinSDK)
    private static func queryWindowsLanguages(
      using method: (DWORD, PULONG?, PZZWSTR?, PULONG?) -> Bool
    ) -> [String]? {
      let isoCodesMode: DWORD = DWORD(MUI_LANGUAGE_NAME)
      var numberOfLanguages: ULONG = 0
      var bufferSize: ULONG = 0
      if method(
        isoCodesMode,
        &numberOfLanguages,
        nil,  // Nil causes size to be queried.
        &bufferSize  // Ends up containing the necessary size.
      ) {
        var arrayBuffer: [WCHAR] = Array(repeating: 0, count: Int(bufferSize))
        // Actually fill the buffer with the language list.
        if method(
          isoCodesMode,
          &numberOfLanguages,
          &arrayBuffer,
          &bufferSize
        ) {
          let slices = arrayBuffer.components(separatedBy: [0]).lazy
            .map({ $0.contents })
            .filter({ ¬$0.isEmpty })
          let strings: [String] = slices.map { slice in
            let array = Array(slice)
            return String(utf16CodeUnits: array, count: array.count)
          }
          return strings
        } else {
          return nil
        }
      } else {
        return nil
      }
    }
  #endif

  internal static let osSystemWidePreferences: Shared<Preference> = {
    let preferences: Shared<Preference>
    #if APPLE_PLATFORM

      preferences = PreferenceSet.preferences(for: UserDefaults.globalDomain)[applePreferenceKey]

    #elseif os(Windows)

      preferences = Shared(Preference.mock())
      preferences.value.set(to: queryWindowsLanguages(using: GetUserPreferredUILanguages))

    #elseif os(WASI)

      // #workaround(Swift 5.3.3, Unable to interact with JavaScript.)
      preferences = Shared(Preference.mock())
      preferences.value.set(to: nil)

    #elseif os(Linux)

      preferences = Shared(Preference.mock())

      func convert(locale: String) -> String {
        // @exempt(from: tests) Depends on host.
        return locale.replacingOccurrences(of: "_", with: "\u{2D}")
      }

      if let languages = ProcessInfo.processInfo.environment["LANGUAGE"] {
        // @exempt(from: tests) Depends on host.
        let entryMatches: [PatternMatch<String>] = languages.components(separatedBy: ":")
        let converted = entryMatches.map { convert(locale: String($0.contents)) }
        preferences.value.set(to: converted)
      } else if let language = ProcessInfo.processInfo.environment["LANG"],
        let locale: PatternMatch<String> = language.prefix(upTo: ".")
      {
        // @exempt(from: tests) Depends on host.
        let converted = convert(locale: String(locale.contents))
        preferences.value.set(to: [converted])
      } else {
        // @exempt(from: tests) Depends on host.
        preferences.value.set(to: nil)
      }

    #elseif os(Android)

      // #workaround(Swift 5.3.2, Android: Resources.getSystem().getConfiguration().locale.getLanguage()? No access to Java VM yet.)
      preferences = Shared(Preference.mock())
      preferences.value.set(to: nil)

    #endif

    preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
    return preferences
  }()

  private static let sdgSystemWidePreferences: Shared<Preference> = {
    #if PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
      let preferences = Shared(Preference.mock())
    #else
      let preferences = PreferenceSet.preferences(
        for: PreferenceSet._sdgCornerstoneDomain + sdgDomainSuffix
      )[sdgPreferenceKey]
    #endif
    preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
    return preferences
  }()

  private static let osApplicationPreferences: Shared<Preference> = {
    #if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
      guard ProcessInfo.possibleApplicationIdentifier ≠ nil else {
        return Shared(Preference.mock())  // @exempt(from: tests)
      }
    #endif

    let preferences: Shared<Preference>
    #if APPLE_PLATFORM

      preferences = PreferenceSet.applicationPreferences[applePreferenceKey]

    #elseif os(WASI)

      // #workaround(Swift 5.3.3, Unable to interact with JavaScript.)
      preferences = Shared(Preference.mock())
      preferences.value.set(to: nil)

    #elseif os(Windows)

      preferences = Shared(Preference.mock())
      preferences.value.set(to: queryWindowsLanguages(using: GetProcessPreferredUILanguages))

    #elseif os(Linux)

      // This is does not exist on Linux anyway.
      preferences = Shared(Preference.mock())

    #elseif os(Android)

      // #workaround(Swift 5.3.2, Android: Locale.getDefault().getLanguage()? No access to Java VM yet.)
      preferences = Shared(Preference.mock())

    #endif

    preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
    return preferences
  }()

  private static let sdgApplicationPreferences: Shared<Preference> = {
    #if PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
      return Shared(Preference.mock())
    #else
      guard let applicationDomain = ProcessInfo.possibleApplicationIdentifier else {
        return Shared(Preference.mock())  // @exempt(from: tests)
      }
      let preferences = PreferenceSet.preferences(for: applicationDomain + sdgDomainSuffix)[
        sdgPreferenceKey
      ]
      preferences.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
      return preferences
    #endif
  }()

  private static let overrides: Shared<[LocalizationSetting]> = {
    let overrides: Shared<[LocalizationSetting]> = Shared([])
    overrides.register(observer: ChangeObserver.defaultObserver, reportInitialState: false)
    return overrides
  }()

  private static func resolveCurrentLocalization() -> LocalizationSetting {
    var result = overrides.value.last
    #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
      result =
        result
        ?? sdgApplicationPreferences.value.as(LocalizationSetting.self)
        ?? LocalizationSetting(osPreference: osApplicationPreferences.value)
        ?? sdgSystemWidePreferences.value.as(LocalizationSetting.self)
        ?? LocalizationSetting(osPreference: osSystemWidePreferences.value)
    #endif
    return result
      ?? LocalizationSetting(orderOfPrecedence: [] as [[String]])  // @exempt(from: tests)
  }

  private class ChangeObserver: SharedValueObserver {
    fileprivate static let defaultObserver = ChangeObserver()
    fileprivate func valueChanged(for identifier: String) {

      let new = LocalizationSetting.resolveCurrentLocalization()
      if current.value ≠ new {
        current.value = new
      }
    }
  }

  /// The current localization setting.
  ///
  /// - Note: The value of the shared instance is intended to be read‐only.
  public static let current: Shared<LocalizationSetting> = {
    let result = Shared(resolveCurrentLocalization())
    result.register(observer: ChangeObserver(), reportInitialState: false)
    return result
  }()

  // MARK: - Static Methods

  #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
    // For user available menus.
    public static func _setSystemWidePreferences(to setting: LocalizationSetting?) {
      sdgSystemWidePreferences.value.set(to: setting)
    }
    internal static func setSystemWidePreferences(to setting: LocalizationSetting?) {
      _setSystemWidePreferences(to: setting)
    }

    /// Sets the application‐specific language preferences to the specified settings.
    ///
    /// This should only be used when the changes both:
    ///   - need to be remembered the next time the application is launched, and
    ///   - are at the direct request of the user.
    ///
    /// Otherwise, use `do(_:)` instead.
    ///
    /// - Parameters:
    ///     - setting: The new localization setting.
    public static func setApplicationPreferences(to setting: LocalizationSetting?) {

      // Make sure this was set and it is not just a silent mock preference.
      _ = ProcessInfo.applicationIdentifier

      sdgApplicationPreferences.value.set(to: setting)

      if let preferences = setting {
        var flattened: [String] = []
        for group in preferences.orderOfPrecedence {
          flattened.append(contentsOf: group.shuffled())
        }
        osApplicationPreferences.value.set(to: flattened)
      } else {
        osApplicationPreferences.value.set(to: nil)
      }
    }
  #endif

  // MARK: - Initialization

  /// Creates a localization setting from a list of precedence groups.
  ///
  /// - Parameters:
  ///     - orderOfPrecedence: An array of precedence groups. The outer array represents the order of precedence. Each inner array represents a group of localizations with equal precedence. Within a specific group, localizations will be mixed and matched at random. Each string must be an [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) representing a desired localization.
  public init(orderOfPrecedence: [[String]]) {
    self.orderOfPrecedence = orderOfPrecedence
  }

  /// Creates a localization setting from a precedence list.
  ///
  /// - Parameters:
  ///     - orderOfPrecedence: An array of localizations describing there order of precedence. Each string must be an [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) representing a desired localization.
  public init(orderOfPrecedence: [String]) {
    self.orderOfPrecedence = orderOfPrecedence.map { [$0] }
  }

  #if !PLATFORM_LACKS_FOUNDATION_PROPERTY_LIST_ENCODER
    private init?(osPreference preference: Preference) {
      guard let result = preference.as([String].self) else {
        return nil
      }
      self.init(orderOfPrecedence: result)
    }
  #endif

  // MARK: - Properties

  private let orderOfPrecedence: [[String]]

  // MARK: - Usage

  /// Executes the closure under the localization settings described by `self`.
  ///
  /// - Parameters:
  ///     - closure: The closure to execute.
  public func `do`(_ closure: () throws -> Void) rethrows {
    LocalizationSetting.overrides.value.append(self)
    defer { LocalizationSetting.overrides.value.removeLast() }

    try closure()
  }

  private func resolvedFresh<L: Localization>() -> L {
    for group in orderOfPrecedence {
      for localization in group.shuffled() {
        if let result = L(reasonableMatchFor: localization) {
          return result
        }
      }
    }
    return L.fallbackLocalization
  }

  #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
    private func stabilityCacheURL<L>(for: L.Type) -> URL {
      var path = "SDGCornerstone/Stable Localizations"
      path += "/"
      path += String(reflecting: L.self)
      path += "/"
      path += orderOfPrecedence.map({ $0.joined(separator: ",") }).joined(separator: ";")
      return FileManager.default.url(in: .cache, at: path)
    }
  #endif

  private subscript<L>(stabilityCacheFor type: L.Type) -> CachedLocalization<L>? {
    get {
      #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
        if let cache = try? CachedLocalization<L>(from: stabilityCacheURL(for: L.self)),
          Date() ≤ cache.date
        {
          return cache
        }
      #endif
      return nil
    }
    nonmutating set {
      #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
        try? newValue?.save(to: stabilityCacheURL(for: L.self))
      #endif
    }
  }

  /// Returns the preferred localization out of those supported by the type `L`.
  ///
  /// - Parameters:
  ///     - stabilization: The stabilization mode.
  public func resolved<L: Localization>(stabilization: StabilizationMode = .none) -> L {
    switch stabilization {
    case .none:
      return resolvedFresh()
    case .stabilized:
      let container = cached(in: &self[stabilityCacheFor: L.self]) {
        return CachedLocalization<L>(
          localization: resolvedFresh(),
          date: Date() + 24 /*h*/ × 60 /*m*/ × 60 /*s*/
        )
      }
      return container.localization
    }
  }

  private var descriptionRepresentation: [[AnyLocalization]] {
    return orderOfPrecedence.map { level in
      let levelDescription: [AnyLocalization] = level.lazy.sorted().map { identifier in
        return AnyLocalization(code: identifier)
      }
      return levelDescription
    }
  }

  // MARK: - CustomPlaygroundDisplayConvertible

  public var playgroundDescription: Any {
    return descriptionRepresentation
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return "\(descriptionRepresentation)"
  }

  // MARK: - Decodable

  public init(from decoder: Decoder) throws {
    try self.init(
      from: decoder,
      via: [[String]].self,
      convert: { LocalizationSetting(orderOfPrecedence: $0) }
    )
  }

  // MARK: - Encodable

  public func encode(to encoder: Encoder) throws {
    try encode(to: encoder, via: orderOfPrecedence)
  }

  // MARK: - Equatable

  public static func == (
    precedingValue: LocalizationSetting,
    followingValue: LocalizationSetting
  ) -> Bool {
    return precedingValue.orderOfPrecedence
      .elementsEqual(followingValue.orderOfPrecedence) { Set($0) == Set($1) }
  }
}
