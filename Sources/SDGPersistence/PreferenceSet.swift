/*
 PreferenceSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGCollections

/// A set of preferences for a particular domain.
public final class PreferenceSet {

  // MARK: - Static Properties

  public static let _sdgCornerstoneDomain = "ca.solideogloria.SDGCornerstone"

  // MARK: - Initialization

  private static var domains: [String: PreferenceSet] = [:]

  #if PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
    internal init() {
      // Dead initializer, but enables compilation, in order to permit static namespace use.
      domain = ""
      possibleDebugDomain = ""
      contents = [:]
      observer = Observer()
    }
  #else
    /// The application preferences.
    public static let applicationPreferences: PreferenceSet = {
      return preferences(for: ProcessInfo.applicationDomain)
    }()

    /// Returns the preferences for a particular domain.
    ///
    /// - Parameters:
    ///     - domain: The domain.
    public static func preferences(for domain: String) -> PreferenceSet {

      var domainsCopy = domains  // Allow reading from original during closure.
      let result = cached(in: &domainsCopy[domain]) {
        return PreferenceSet(domain: domain)
      }
      domains = domainsCopy

      return result
    }

    /// Creates preferences for a specified domain.
    ///
    /// Subclasses may call this during initialization, but in all other circumstances, `preferences(for:)` should be called to prevent duplication.
    ///
    /// - Parameters:
    ///     - domain: The domain.
    public init(domain: String) {
      _assert(
        PreferenceSet.domains[domain] == nil,
        { (localization: _APILocalization) -> String in  // @exempt(from: tests)
          switch localization {  // @exempt(from: tests)
          case .englishCanada:
            return "Detected duplicate initialization of \(domain). Call preferences(for:) instead."
          }
        }
      )

      self.domain = domain
      let possibleDebugDomain: String
      if domain == UserDefaults.globalDomain {
        possibleDebugDomain = domain  // @exempt(from: tests) Absent from Linux?
      } else {
        possibleDebugDomain = FileManager.possibleDebugDomain(domain)
      }
      self.possibleDebugDomain = possibleDebugDomain

      contents = PreferenceSet.readFromDisk(for: possibleDebugDomain)

      observer = Observer()
      observer.preferences = self
    }
  #endif

  // MARK: - Properties

  /// The domain.
  public let domain: String
  private let possibleDebugDomain: String
  private var contents: [String: Preference]

  private var values: [String: Shared<Preference>] = [:]

  private var observer: Observer
  private class Observer: SharedValueObserver {
    fileprivate init() {}
    fileprivate weak var preferences: PreferenceSet?
    fileprivate func valueChanged(for identifier: String) {
      #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
        preferences?.valueChanged(for: identifier)
      #endif
    }
  }

  // MARK: - Storage

  #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
    private static func readFromDisk(for possibleDebugDomain: String) -> [String: Preference] {
      let values =
        UserDefaults.standard.persistentDomain(
          forName: possibleDebugDomain
        ) ?? [:]  // @exempt(from: tests)
      // Linux returns an empty dictionary instead of nil.

      return values.mapValues { Preference(propertyListObject: Preference.cast($0)) }
    }
    private func readFromDisk() -> [String: Preference] {
      return PreferenceSet.readFromDisk(for: possibleDebugDomain)
    }

    private func writeToDisk(_ preferences: [String: Preference]) {
      var objects: [String: NSObject] = [:]
      for (key, prefrence) in preferences {
        objects[key] = prefrence.propertyListObject
      }
      _assert(
        possibleDebugDomain ≠ UserDefaults.globalDomain,
        { (localization: _APILocalization) -> String in  // @exempt(from: tests)
          switch localization {  // @exempt(from: tests)
          case .englishCanada:
            return "Attempted to write preferences to the global domain. This domain is read‐only."
          }
        }
      )
      UserDefaults.standard.setPersistentDomain(objects, forName: possibleDebugDomain)
    }
  #endif

  // MARK: - Merging Changes

  private func update(
    fromExternalState externalState: [String: Preference],
    ignoring ignoredKey: String? = nil
  ) {

    for key in Set(externalState.keys) ∪ Set(contents.keys) where key ≠ ignoredKey {
      let externalValue = externalState[key]

      if externalValue ≠ contents[key] {
        contents[key] = externalValue
        self[key].value.propertyListObject = externalValue?.propertyListObject
      }
    }
  }

  // MARK: - Observing

  #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
    private func valueChanged(for identifier: String) {

      guard let shared = values[identifier] else {
        _unreachable()
      }

      if shared.value ≠ contents[identifier] ?? Preference(propertyListObject: nil) {

        // Prevent overwriting of external, untracked changes,
        // but ignore the current key to prevent undoing this very change.
        update(fromExternalState: readFromDisk(), ignoring: identifier)
        contents[identifier] = shared.value

        writeToDisk(contents)
      }
    }
  #endif

  // MARK: - Usage

  /// Accesses the preference for the specified key.
  ///
  /// - Parameters:
  ///     - key: The key.
  public subscript(key: String) -> Shared<Preference> {
    return cached(in: &values[key]) {
      let shared = Shared(contents[key] ?? Preference(propertyListObject: nil))
      shared.register(observer: observer, identifier: key, reportInitialState: false)
      return shared
    }
  }

  #if !PLATFORM_LACKS_FOUNDATION_USER_DEFAULTS
    /// Resets all properties to nil.
    public func reset() {
      writeToDisk([:])
      update(fromExternalState: [:])
    }
  #endif
}
