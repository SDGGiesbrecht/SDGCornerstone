/*
 InputLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An enumeration that describes the set of localizations available for a particular input usage.
///
/// Conformance Requirements:
///   - `CaseIterable`
///   - `Localization`
public protocol InputLocalization : CaseIterable, Localization {}

extension InputLocalization {

    /// Returns the equivalent set of codes.
    ///
    /// Use this to compare two `Localization` types with set comparison operations such as `⊆`.
    public static func codeSet() -> Set<String> {
        return Set(allCases.map({ $0.code }))
    }
}
