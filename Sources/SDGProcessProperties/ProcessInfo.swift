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
            guard let result = _applicationIdentifier ?? Bundle.main.bundleIdentifier else {
                _preconditionFailure({ (localization: _APILocalization) -> String in
                    switch localization {
                    case .englishCanada:
                        return "“ProcessInfo.applicationIdentifier” has not been set yet. (Import SDGCornerstone or SDGProcessProperties.)"
                    }
                })
            }
            return result
        }
        set {
            _applicationIdentifier = newValue
        }
    }

    /// The process domain.
    public static var domain: String {
        return applicationIdentifier
    }
}
