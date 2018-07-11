/*
 ProcessInfo.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

extension ProcessInfo {

    private static var _applicationIdentifier: String?
    /// The application identifier.
    ///
    /// Bundled applications can define this in the main bundle’s information property list. Otherwise this property must be directy assigned a value at the very beginning of program execution. Failing to do either before the first attempt to read this property will trigger a precondition failure.
    public static var applicationIdentifier: String {
        get {
            guard let result = possibleApplicationIdentifier else {
                _preconditionFailure({ (localization: _APILocalization) -> String in
                    switch localization {
                    case .englishCanada: // @exempt(from: tests)
                        return "“ProcessInfo.applicationIdentifier” has not been set yet. (Import SDGCornerstone or SDGPersistence.)"
                    }
                })
            }
            return result
        }
        set {
            _applicationIdentifier = newValue
        }
    }

    /// The application identifier.
    ///
    /// This property has the same value as `applicationIdentifier`, but is typed as an `Optional`.
    ///
    /// Framework authors can read from this version of the propery when it should not matter if the client application has neglected to specify an identifier.
    public static var possibleApplicationIdentifier: String? {
        return _applicationIdentifier ?? Bundle.main.bundleIdentifier // @exempt(from: tests) The right side of “??” is unreachable from tests.
    }

    /// The application domain.
    @_inlineable public static var applicationDomain: String {
        return applicationIdentifier
    }
}
