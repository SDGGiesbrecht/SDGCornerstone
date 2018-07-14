/*
 InterfaceLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// :nodoc:
public enum _InterfaceLocalization : String, InputLocalization {

    // MARK: - Cases

    /// :nodoc:
    case englishUnitedKingdom = "en\u{2D}GB"
    /// :nodoc:
    case englishUnitedStates = "en\u{2D}US"
    /// :nodoc:
    case englishCanada = "en\u{2D}CA"

    /// :nodoc:
    public static let cases: [_InterfaceLocalization] = [

        .englishUnitedKingdom,
        .englishUnitedStates,
        .englishCanada
    ]

    // MARK: - Localization

    /// :nodoc:
    public static let fallbackLocalization: _InterfaceLocalization = .englishUnitedKingdom
}
