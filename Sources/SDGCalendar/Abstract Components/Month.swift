/*
 Month.swift

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

/// A calendar compenent representing a month of the year.
public protocol Month: TextualPlaygroundDisplay {

  /// Returns the English name.
  func inEnglish() -> StrictString

  // @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
  /// Gibt den Deutschen Namen zurück.
  func aufDeutsch() -> StrictString

  // @localization(🇫🇷FR) @notLocalized(🇨🇦EN)
  /// Renvoie le nom français.
  func enFrançais(_ majuscules: Casing) -> StrictString

  // @localization(🇬🇷ΕΛ) @notLocalized(🇨🇦EN)
  /// Επιστρέφει το ελληνικό όνομα.
  func σεΕλληνικά(_ πτώση: ΓραμματικήΠτώση) -> StrictString

  // @localization(🇮🇱עב) @notLocalized(🇨🇦EN)
  /// משיבה את השם העברי.
  func בעברית() -> StrictString
}

extension Month {

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(
      UserFacing<StrictString, FormatLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return self.inEnglish()
        case .deutschDeutschland:
          return self.aufDeutsch()
        case .françaisFrance:
          return self.enFrançais(.sentenceMedial)
        case .ελληνικάΕλλάδα:
          return self.σεΕλληνικά(.ονομαστική)
        case .עברית־ישראל:
          return self.בעברית()
        }
      }).resolved()
    )
  }
}
