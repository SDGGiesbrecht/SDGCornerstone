/*
 StateData.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

/// Data about a sovereign state.
///
/// This structure provides access to data used internally by SDGLocalization.
public struct StateData {

    // MARK: - List

    /// Returns a list of all supported states.
    ///
    /// - Important: The list of states is not intended to be exhaustive. It contains only those necessary for other `SDGLocalization` functionality. Particular states may be added or removed at any time.
    public static var list: AnySequence<StateData> {
        return AnySequence(State.allCases.lazy.map({ StateData(state: $0) }))
    }

    // MARK: - Initialization

    private init(state: State) {
        self.state = state
    }

    /// Creates state data for a particular ISO 3166‐1 alpha‐2 code, or returns `nil` if the code is not supported.
    ///
    /// - Important: Not all valid codes are supported—only those necessary for other `SDGLocalization` functionality. Support for a particular state may be added or removed at any time.
    ///
    /// - Parameters:
    ///     - code: The ISO 3166‐1 alpha‐2 code.
    public init?(code: String) {
        if let state = State(code: code) {
            self = StateData(state: state)
        } else {
            return nil
        }
    }

    /// Creates state data for a particular flag, or returns `nil` if the flag is not supported.
    ///
    /// - Important: Not all valid flags are supported—only those necessary for other `SDGLocalization` functionality. Support for a particular state may be added or removed at any time.
    ///
    /// - Parameters:
    ///     - flag: The flag.
    public init?(flag: StrictString) {
        if let state = State(flag: flag) {
            self = StateData(state: state)
        } else {
            return nil
        }
    }

    // MARK: - Properties

    private let state: State

    /// The ISO 3166‐1 alpha‐2 code.
    public var code: String {
        return state.code
    }

    /// The flag.
    public var flag: StrictString {
        return state.flag
    }

    // MARK: - Descriptions

    /// Returns the isolated form of the state’s name in the provided localization, or `nil` if the localization is not supported.
    ///
    /// - Important: Not all localizations are supported—only those necessary for other `SDGLocalization` functionality. Support for a particular localization may be added or removed at any time.
    ///
    /// - Parameters:
    ///     - localization: The localization.
    public func isolatedName<L>(in localization: L) -> StrictString? where L : Localization {
        if let localization = _InterfaceLocalization(exactly: localization.code) {
            return state.isolatedName().resolved(for: localization)
        } else {
            return nil
        }
    }
}
