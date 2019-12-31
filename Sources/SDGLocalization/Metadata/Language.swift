/*
 Language.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

internal enum Language: String {

  // MARK: - Cases

  case 普通话 = "cmn"
  case español = "es"
  case english = "en"
  case العربية = "arb"
  case हिन्दी = "hi"
  case português = "pt"
  case русский = "ru"
  case 日本語 = "ja"
  case deutsch = "de"
  case tiếngViệt = "vi"
  case 한국어 = "ko"
  case français = "fr"
  case türkçe = "tr"
  case italiano = "it"
  case polski = "pl"
  case українська = "uk"
  case nederlands = "nl"
  case malaysia = "zsm"
  case română = "ro"
  case ไทย = "th"
  case ελληνικά = "el"
  case zulu = "zu"
  case čeština = "cs"
  case magyar = "hu"
  case svenska = "sv"
  case indonesia = "id"
  case xhosa = "xh"
  case afrikaans = "af"
  case sesotho = "st"
  case dansk = "da"
  case suomi = "fi"
  case slovenčina = "sk"
  case עברית = "he"
  case norskBokmål = "nb"
  case hrvatski = "hr"
  case català = "ca"
  case ܣܘܪܝܬ = "aii"

  // MARK: - Description

  internal var textDirection: TextDirection {
    switch self {
    case .普通话, .日本語, .한국어:
      return .topToBottomRightToLeft
    case .español, .english, .हिन्दी, .português, .русский, .deutsch, .tiếngViệt, .français, .türkçe,
      .italiano, .polski, .українська, .nederlands, .malaysia, .română, .ไทย, .ελληνικά, .zulu,
      .čeština, .magyar, .svenska, .indonesia, .xhosa, .afrikaans, .sesotho, .dansk, .suomi,
      .slovenčina, .norskBokmål, .hrvatski, .català:
      return .leftToRightTopToBottom
    case .العربية, .עברית, .ܣܘܪܝܬ:
      return .rightToLeftTopToBottom
    }
  }

  internal func isolatedName() -> UserFacing<StrictString, _InterfaceLocalization> {
    return UserFacing<StrictString, _InterfaceLocalization>({ localization in
      switch self {
      case .普通话:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
          .deutschDeutschland:
          return "Mandarin"
        }
      case .español:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Spanish"
        case .deutschDeutschland:
          return "Spanisch"
        }
      case .english:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "English"
        case .deutschDeutschland:
          return "Englisch"
        }
      case .العربية:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Arabic"
        case .deutschDeutschland:
          return "Arabisch"
        }
      case .हिन्दी:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
          .deutschDeutschland:
          return "Hindi"
        }
      case .português:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Portuguese"
        case .deutschDeutschland:
          return "Portugiesisch"
        }
      case .русский:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Russian"
        case .deutschDeutschland:
          return "Russisch"
        }
      case .日本語:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Japanese"
        case .deutschDeutschland:
          return "Japanisch"
        }
      case .deutsch:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "German"
        case .deutschDeutschland:
          return "Deutsch"
        }
      case .tiếngViệt:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Vietnamese"
        case .deutschDeutschland:
          return "Vietnamesisch"
        }
      case .한국어:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Korean"
        case .deutschDeutschland:
          return "Koreanisch"
        }
      case .français:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "French"
        case .deutschDeutschland:
          return "Französisch"
        }
      case .türkçe:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Turkish"
        case .deutschDeutschland:
          return "Türkisch"
        }
      case .italiano:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Italian"
        case .deutschDeutschland:
          return "Italienisch"
        }
      case .polski:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Polish"
        case .deutschDeutschland:
          return "Polnisch"
        }
      case .українська:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Ukrainian"
        case .deutschDeutschland:
          return "Ukrainisch"
        }
      case .nederlands:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Dutch"
        case .deutschDeutschland:
          return "Niederländisch"
        }
      case .malaysia:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Malaysian"
        case .deutschDeutschland:
          return "Malaysisch"
        }
      case .română:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Romanian"
        case .deutschDeutschland:
          return "Rumänisch"
        }
      case .ไทย:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Thai"
        case .deutschDeutschland:
          return "Thailändisch"
        }
      case .ελληνικά:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Greek"
        case .deutschDeutschland:
          return "Griechisch"
        }
      case .zulu:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
             .deutschDeutschland:
          return "Zulu"
        }
      case .čeština:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Czech"
        case .deutschDeutschland:
          return "Tschechisch"
        }
      case .magyar:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Hungarian"
        case .deutschDeutschland:
          return "Ungarisch"
        }
      case .svenska:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Swedish"
        case .deutschDeutschland:
          return "Schwedisch"
        }
      case .indonesia:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Indonesian"
        case .deutschDeutschland:
          return "Indonesisch"
        }
      case .xhosa:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
             .deutschDeutschland:
          return "Xhosa"
        }
      case .afrikaans:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
             .deutschDeutschland:
          return "Afrikaans"
        }
      case .sesotho:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Southern Sotho"
        case .deutschDeutschland:
          return "Süd‐Sotho"
        }
      case .dansk:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Danish"
        case .deutschDeutschland:
          return "Dänisch"
        }
      case .suomi:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Finnish"
        case .deutschDeutschland:
          return "Finnisch"
        }
      case .slovenčina:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Slovak"
        case .deutschDeutschland:
          return "Slowakisch"
        }
      case .עברית:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Hebrew"
        case .deutschDeutschland:
          return "Hebräisch"
        }
      case .norskBokmål:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Norwegian Bokmål"
        case .deutschDeutschland:
          return "Norwegisches Bokmål"
        }
      case .hrvatski:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Croatian"
        case .deutschDeutschland:
          return "Kroatisch"
        }
      case .català:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Catalan"
        case .deutschDeutschland:
          return "Katalanisch"
        }
      case .ܣܘܪܝܬ:
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Aramaic"
        case .deutschDeutschland:
          return "Aramäisch"
        }
      }
    })
  }
}
