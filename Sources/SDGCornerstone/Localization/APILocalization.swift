/*
 APILocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal enum APILocalization : String, Localization {

    // MARK: - Cases

    case englishCanada = "en\u{2D}CA"

    internal static let cases: [APILocalization] = [
        .englishCanada
    ]

    // MARK: - Localization

    internal static let fallbackLocalization: APILocalization = .englishCanada
}
