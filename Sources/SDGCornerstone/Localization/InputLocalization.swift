/*
 InputLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An enumeration that describes the set of localizations available for a particular input usage.
///
/// Conformance Requirements:
///   - `Localization`
///   - `static var cases: [Self] { get }`
public protocol InputLocalization : Localization {

    // [_Inherit Documentation: SDGCornerstone.IterableEnumeration.cases_]
    /// An array containing every case of the enumeration.
    static var cases: [Self] { get }
}
