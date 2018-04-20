/*
 PresentableError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An error suitable to present to users.
///
/// Conformance Requirements
///     - `var localizedDescription: String`
public protocol PresentableError : CustomStringConvertible, Error {

    // [_Define Documentation: SDGCornerstone.PresentableError.presentableDescription()_]
    /// Returns a localized description of the error.
    func presentableDescription() -> StrictString
}

extension PresentableError {

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return String(presentableDescription())
    }

    // MARK: - Error

    // The localized description for this error.
    public var localizedDescription: String {
        return String(presentableDescription())
    }
}
