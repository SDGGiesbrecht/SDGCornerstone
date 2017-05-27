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

// [_Warning: Nothing here is thread safe. All of it could occur in a serial background queue?_]

// [_Warning: Should auto‐update shared (non‐application) domains periodically._]

/// A set of preferences for a particular domain.
open class Preferences : SharedValueObserver {

    // MARK: - Initialization

    private static var domains: [String: Preferences] = [:]

    /// Returns the preferences for a particular domain.
    public static func preferences(forDomain domain: String) -> Preferences {
        return preferences(Preferences.self, for: domain)
    }

    /// Returns subclassed preferences for a particular domain.
    public static func preferences<P : Preferences>(_ subClass: P.Type, for domain: String) -> P {

        let result = cached(in: &domains[domain]) {
            return P(domain: domain)
        }

        guard let subclassedResult = result as? P else {
            preconditionFailure("Existing preferences are the wrong class: \(type(of: result))")
        }
        return subclassedResult
    }

    /// Creates preferences for a specified domain.
    ///
    /// Subclasses may call this during initialization, but in all other circumstances, `preferences(forDomain:)` should be called to prevent duplication.
    public required init(domain: String) {
        assert(Preferences.domains[domain] == nil, "Detected duplicate initialization of \(domain). Call preferences(forDomain:) instead.")

        self.domain = domain
        let possibleDebugDomain = BuildConfiguration.current == .debug ? domain + ".debug" : domain // [_Exempt from Code Coverage_]
        self.possibleDebugDomain = possibleDebugDomain

        contents = Preferences.load(for: possibleDebugDomain)
    }

    // MARK: - Properties

    /// The domain.
    public let domain: String
    private let possibleDebugDomain: String
    private var contents: [String: PropertyListValue]

    private var values: [String: Shared<PropertyListValue?>] = [:]

    // MARK: - Usage

    /// Accesses the property list value for the specified key.
    public subscript(key: String) -> Shared<PropertyListValue?> {
        return cached(in: &values[key]) {
            let shared = Shared(contents[key])
            shared.register(observer: self, identifier: key, reportInitialState: false)
            return shared
        }
    }

    /// Resets all properties to nil.
    public func reset() {
        store([:])
        synchronize()
    }

    // MARK: - Storage

    #if os(Linux)
    private static let directory = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(".config")
    #endif

    private static func load(for possibleDebugDomain: String) -> [String: PropertyListValue] {

        #if os(Linux)

            do {
                let data = try Data(contentsOf: Preferences.directory.appendingPathComponent("\(possibleDebugDomain).plist"))
                return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: PropertyListValue] ?? [:]
            } catch {
                return [:]
            }

        #else

            let defaults = UserDefaults.standard
            defaults.synchronize()
            return defaults.persistentDomain(forName: possibleDebugDomain) as? [String: PropertyListValue] ?? [:]

        #endif
    }
    private func load() -> [String: PropertyListValue] {
        return Preferences.load(for: possibleDebugDomain)
    }

    private func store(_ preferences: [String: PropertyListValue]) {

        #if os(Linux)

            if let data = try? PropertyListSerialization.data(fromPropertyList: preferences, format: .xml, options: 0) {
                try? data.write(to: Preferences.directory.appendingPathComponent("\(possibleDebugDomain).plist"), options: [.atomic])
            }

        #else

            UserDefaults.standard.setPersistentDomain(preferences, forName: possibleDebugDomain)

        #endif
    }
    private func store() {
        store(contents)
    }

    private func synchronize(ignoring ignoredKey: String? = nil) {
        let possibleChanges = load()

        var changes: [(key: String, value: PropertyListValue?)] = []
        for key in Set(possibleChanges.keys) ∪ Set(contents.keys) where key ≠ ignoredKey {
            let possibleChange = possibleChanges[key]

            if possibleChange?.equatableRepresentation ≠ contents[key]?.equatableRepresentation {
                contents[key] = possibleChange
                changes.append((key, possibleChange))
            }
        }

        for (key, value) in changes {
            self[key].value = value
        }
    }

    // MARK: - SharedValueObserver

    // [_Inherit Documentation: SDGCornerstone.SharedValueObserver.valueChanged(for:)_]
    /// Called when a value changes.
    ///
    /// - Parameters:
    ///     - identifier: The identifier that was specified when the observer was registered. This can be used to differentiate between several values watched by the same observer.
    ///
    /// - SeeAlso: `register(observer:identifier)`
    public func valueChanged(for identifier: String) {
        guard let shared = values[identifier] else {
            preconditionFailure("Received notification of a shared value changing from an untracked identifier: \(identifier).")
        }

        // Prevent overwriting of external, untracked changes,
        // but ignore the current key to prevent undoing this very change.
        synchronize(ignoring: identifier)

        contents[identifier] = shared.value
        store()
    }
}
