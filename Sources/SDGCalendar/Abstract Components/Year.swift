/*
 Year.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A calendar compenent representing a year.
public protocol Year: TextualPlaygroundDisplay {

  /// Returns the year in English digits.
  func inEnglishDigits() -> StrictString

  // @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
  /// Gibt das Jahr in Deutschen Ziffern zurück.
  func inDeutschenZiffern() -> StrictString

  // @localization(🇫🇷FR) @notLocalized(🇨🇦EN)
  /// Renvoie l’an en chiffres français.
  func enChiffresFrançais() -> StrictString

  // @localization(🇬🇷ΕΛ) @notLocalized(🇨🇦EN)
  /// Επιστρέφει το έτος σε ελληνικά ψηφία.
  func σεΕλληνικάΨηφία() -> StrictString

  // @localization(🇮🇱עב) @notLocalized(🇨🇦EN)
  /// משיבה את השנה בעברית בספרות.
  func בעברית־בספרות() -> StrictString
}

extension Year {

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(
      UserFacing<StrictString, FormatLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return self.inEnglishDigits()
        case .deutschDeutschland:
          return self.inDeutschenZiffern()
        case .françaisFrance:
          return self.enChiffresFrançais()
        case .ελληνικάΕλλάδα:
          return self.σεΕλληνικάΨηφία()
        case .עברית־ישראל:
          return self.בעברית־בספרות()
        }
      }).resolved()
    )
  }
}
