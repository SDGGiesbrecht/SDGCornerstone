/*
 UserDefaults.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension UserDefaults {

    private static func propertyListValuesAreEqual(_ lhsValue: Any?, _ rhsValue: Any?) -> Bool {
        if let lhs = lhsValue {
            if let rhs = rhsValue {

                // All possible property list values are castable to NSObject subclasses and can thereby be checked for equality.
                guard let lhsObject = lhs as? NSObject else {
                    preconditionFailure("\(lhs) is not a property list value.")
                }
                guard let rhsObject = rhs as? NSObject else {
                    preconditionFailure("\(rhs) is not a property list value.")
                }

                if lhsObject == rhsObject {
                    return true
                } else {
                    return false
                }
            } else {
                // Only the right is nil.
                return false
            }
        } else {
            if rhsValue ≠ nil {
                // Only the left is nil.
                return false
            } else {
                // Both nil
                return true
            }
        }
    }

    private class ChangeObserver : SharedValueObserver {
        private static var observers: [UserDefaults: ChangeObserver] = [:]
        fileprivate static func observer(forDefaults defaults: UserDefaults) -> ChangeObserver {
            return cached(in: &observers[defaults]) { ChangeObserver(defaults) }
        }
        private init(_ defaults: UserDefaults) {
            self.defaults = defaults
        }
        private let defaults: UserDefaults
        fileprivate func valueChanged(for identifier: String) {
            let new = UserDefaults.sharedValues[defaults]?[identifier]?.value
            let existing = defaults.object(forKey: identifier)

            if ¬UserDefaults.propertyListValuesAreEqual(new, existing) {
                if new ≠ nil {
                    defaults.set(new, forKey: identifier)
                } else {
                    defaults.removeObject(forKey: identifier)
                }
            }
        }
    }

    #if !os(Linux)
    private class KVOObserver : NSObject {
        fileprivate static var observers: [UserDefaults: KVOObserver] = [:]
        fileprivate static func observer(forDefaults defaults: UserDefaults) -> KVOObserver {
            return cached(in: &observers[defaults]) { KVOObserver(defaults) }
        }
        private init(_ defaults: UserDefaults) {
            self.defaults = defaults
        }
        private let defaults: UserDefaults
        @objc fileprivate override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

            guard let key = keyPath else {
                preconditionFailure("KVO did not report a key path.")
            }

            let new = defaults.object(forKey: key)
            let existing = UserDefaults.sharedValues[defaults]?[key]?.value

            if ¬UserDefaults.propertyListValuesAreEqual(new, existing) {
                UserDefaults.sharedValues[defaults]?[key]?.value = defaults.object(forKey: key)
            }
        }
    }
    #endif

    private static var sharedValues: [UserDefaults: [String: Shared<Any?>]] = [:]
    // [_Workaround: The warning below should be removed once Linux has a means of observing properties. (Swift 3.1.0)_]
    /// Returns the shared value for the specified key.
    ///
    /// - Warning: Modules that may be used on Linux should take note of keys accessed as shared values and never attempt to set those keys by any means other than through the shared value. On Linux, this will cause the shared value to fall out of sync with the value stored by `UserDefaults`, because Linux lacks the Objective‐C runtime and KVO necessary to observe changes made through other APIs.
    ///
    /// - Parameters:
    ///     - key: The key.
    public func sharedValue(forKey key: String) -> Shared<Any?> {
        var keys = UserDefaults.sharedValues[self] ?? [:]
        defer { UserDefaults.sharedValues[self] = keys }

        let result = cached(in: &keys[key]) {
            let shared = Shared(object(forKey: key))
            shared.register(observer: ChangeObserver.observer(forDefaults: self), identifier: key)
            return shared
        }
        #if !os(Linux)
            addObserver(KVOObserver.observer(forDefaults: self), forKeyPath: key, options: [.new], context: nil)
        #endif

        return result
    }
}
