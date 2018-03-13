/*
 Month.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar compenent representing a month of the year.
public protocol Month {

    // [_Define Documentation: SDGCornerstone.Month.inEnglish()_]
    /// Returns the English name.
    func inEnglish() -> StrictString
}
