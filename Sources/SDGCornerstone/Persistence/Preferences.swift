/*
 Preferences.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A set of preferences for a particular domain.
open class Preferences {

    // MARK: - Static Properties

    internal static let sdgCornerstoneDomain = "ca.solideogloria.SDGCornerstone"

    // MARK: - Initialization

    private static var domains: [String: Preferences] = [:]

    internal static var subclassForApplicationPreferencesInitializer: Preferences.Type?
    /// The application preferences
    public static let applicationPreferences: Preferences = {
        guard let type = Preferences.subclassForApplicationPreferencesInitializer else {
            preconditionFailureNotInitialized()
        }
        return Preferences.applicationPreferences(as: type)
    }()

    /// Returns subclassed preferences for the application domain.
    public static func applicationPreferences<P : Preferences>(as subClass: P.Type) -> P {
        return preferences(as: P.self, for: Application.current.domain)
    }

    /// Returns the preferences for a particular domain.
    public static func preferences(for domain: String) -> Preferences {
        return preferences(as: Preferences.self, for: domain)
    }

    /// Returns subclassed preferences for a particular domain.
    public static func preferences<P : Preferences>(as subClass: P.Type, for domain: String) -> P {

        let result = cached(in: &domains[domain]) {
            return P(domain: domain)
        }

        guard let subclassedResult = result as? P else {
            preconditionFailure(UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada:
                    return StrictString("Existing preferences are the wrong class: \(type(of: result))")
                }
            }))
        }
        return subclassedResult
    }

    /// Creates preferences for a specified domain.
    ///
    /// Subclasses may call this during initialization, but in all other circumstances, `preferences(for:)` should be called to prevent duplication.
    public required init(domain: String) {
        assert(Preferences.domains[domain] == nil, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada:
                return StrictString("Detected duplicate initialization of \(domain). Call preferences(for:) instead.")
            }
        }))

        self.domain = domain
        let possibleDebugDomain: String
        if domain == UserDefaults.globalDomain {
            possibleDebugDomain = domain
        } else {
            possibleDebugDomain = FileManager.possibleDebugDomain(domain)
        }
        self.possibleDebugDomain = possibleDebugDomain

        contents = Preferences.readFromDisk(for: possibleDebugDomain)

        observer = Observer()
        observer.preferences = self
    }

    // MARK: - Properties

    /// The domain.
    public let domain: String
    private let possibleDebugDomain: String
    private var contents: [String: PropertyListValue]

    private var values: [String: Shared<PropertyListValue?>] = [:]

    private var observer: Observer
    private class Observer : SharedValueObserver {
        fileprivate init() {}
        fileprivate weak var preferences: Preferences?
        fileprivate func valueChanged(for identifier: String) {
            preferences?.valueChanged(for: identifier)
        }
    }

    // MARK: - Storage

    #if os(Linux)
    private static let directory = URL(fileURLWithPath: NSHomeDirectory()).encodingAndAppending(pathCompononts: ".config")
    #endif

    private static func readFromDisk(for possibleDebugDomain: String) -> [String: PropertyListValue] {

        #if os(Linux)
// [_Warning: Re‐write this to use file API._]
            do {
                let data = try Data(contentsOf: Preferences.directory.appendingPathComponent("\(possibleDebugDomain).plist"))
                return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: PropertyListValue] ?? [:]
            } catch {
                return [:]
            }

        #else

            return UserDefaults.standard.persistentDomain(forName: possibleDebugDomain) as? [String: PropertyListValue] ?? [:]

        #endif
    }
    private func readFromDisk() -> [String: PropertyListValue] {
        return Preferences.readFromDisk(for: possibleDebugDomain)
    }

    private func writeToDisk(_ preferences: [String: PropertyListValue]) {

        #if os(Linux)
// [_Warning: Re‐write this to use file API._]
            if let data = try? PropertyListSerialization.data(fromPropertyList: preferences, format: .xml, options: 0) {
                try? data.write(to: Preferences.directory.appendingPathComponent("\(possibleDebugDomain).plist"), options: [.atomic])
            }

        #else

            assert(possibleDebugDomain ≠ UserDefaults.globalDomain, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada:
                    return "Attempted to write preferences to the global domain. This domain is read‐only."
                }
            }))
            UserDefaults.standard.setPersistentDomain(preferences, forName: possibleDebugDomain)

        #endif
    }

    // MARK: - Merging Changes

    private func update(fromExternalState externalState: [String: PropertyListValue], ignoring ignoredKey: String? = nil) {

        for key in Set(externalState.keys) ∪ Set(contents.keys) where key ≠ ignoredKey {
            let externalValue = externalState[key]

            if externalValue?.equatableRepresentation ≠ contents[key]?.equatableRepresentation {
                contents[key] = externalValue
                self[key].value = externalValue
            }
        }
    }

    // MARK: - Observing

    private func valueChanged(for identifier: String) {
        guard let shared = values[identifier] else {
            unreachable()
        }

        if shared.value?.equatableRepresentation ≠ contents[identifier]?.equatableRepresentation {

            // Prevent overwriting of external, untracked changes,
            // but ignore the current key to prevent undoing this very change.
            update(fromExternalState: readFromDisk(), ignoring: identifier)
            contents[identifier] = shared.value

            writeToDisk(contents)
        }
    }

    // MARK: - Usage

    /// Accesses the property list value for the specified key.
    public subscript(key: String) -> Shared<PropertyListValue?> {
        return cached(in: &values[key]) {
            let shared = Shared(contents[key])
            shared.register(observer: observer, identifier: key, reportInitialState: false)
            return shared
        }
    }

    /// Resets all properties to nil.
    public func reset() {
        writeToDisk([:])
        update(fromExternalState: [:])
    }
}
