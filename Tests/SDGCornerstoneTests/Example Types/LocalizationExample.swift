/*
 LocalizationExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

enum LocalizationExample : String, Localization {
    case englishUnitedKingdom = "en\u{2D}GB"
    case français = "fr"
    
    case chineseTraditionalTaiwan = "cmn\u{2D}Hant\u{2D}TW"
    case malaysianLatin = "zsm\u{2D}Latn"
    case norwegian = "no"

    // Localization

    static let fallbackLocalization: LocalizationExample = .englishUnitedKingdom
}
