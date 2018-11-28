/*
 Bool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Bool {

    /// Returns “✓” or “✗”.
    @inlinable public func checkOrX() -> StrictString {
        switch self {
        case true:
            return "✓"
        case false:
            return "✗"
        }
    }

    /// Returns “true” or “false”.
    @inlinable public func trueOrFalse(_ casing: EnglishCasing) -> StrictString {
        switch self {
        case true:
            return casing.apply(to: "true")
        case false:
            return casing.apply(to: "false")
        }
    }

    /// Returns “yes” or “no”.
    @inlinable public func yesOrNo(_ casing: EnglishCasing) -> StrictString {
        switch self {
        case true:
            return casing.apply(to: "yes")
        case false:
            return casing.apply(to: "no")
        }
    }
}
