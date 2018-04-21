/*
 FormatLocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public enum _FormatLocalization : String, InputLocalization {

    // MARK: - Cases

    case englishUnitedKingdom = "en\u{2D}GB"
    case englishUnitedStates = "en\u{2D}US"
    case englishCanada = "en\u{2D}CA"

    public static let cases: [_FormatLocalization] = [

        .englishUnitedKingdom,
        .englishUnitedStates,
        .englishCanada
    ]

    // MARK: - Localization

    public static let fallbackLocalization: _FormatLocalization = .englishCanada
}
