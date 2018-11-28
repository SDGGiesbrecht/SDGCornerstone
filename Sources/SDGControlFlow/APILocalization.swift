/*
 APILocalization.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public enum _APILocalization : String, CaseIterable {

    // MARK: - Cases

    case englishCanada = "en\u{2D}CA"

    // MARK: - Localization

    public static let fallbackLocalization: _APILocalization = .englishCanada
}
