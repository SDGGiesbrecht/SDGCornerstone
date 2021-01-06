/*
 Day.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A calendar compenent representing a day of the month.
public protocol Day: ConsistentlyOrderedCalendarComponent, MarkupPlaygroundDisplay
where Vector: IntegerProtocol {}

extension Day {

  // MARK: - Text Representations

  /// Returns the day in English digits. (“1”, “2”, “3”, etc.)
  public func inEnglishDigits() -> StrictString {
    return ordinal.inDigits()
  }

  internal func inDeutschenZiffern() -> StrictString {
    return ordinal._verkürzteDeutscheOrdnungszahl()
  }

  internal func enChiffresFrançais() -> SemanticMarkup {
    if ordinal == 1 {
      return ordinal._ordinalFrançaisAbrégé(genre: .masculin, nombre: .singular)
    } else {
      return SemanticMarkup(ordinal.inDigits())
    }
  }

  internal func σεΕλληνικάΨηφία() -> StrictString {
    return ordinal.inDigits()
  }

  internal func בעברית־בספרות() -> StrictString {
    return ordinal.inDigits()
  }

  // MARK: - MarkupPlaygroundDisplay

  public func playgroundDescriptionMarkup() -> SemanticMarkup {
    return UserFacing<SemanticMarkup, FormatLocalization>({ localization in
      switch localization {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return SemanticMarkup(self.inEnglishDigits())
      case .deutschDeutschland:
        return SemanticMarkup(self.inDeutschenZiffern())
      case .françaisFrance:
        return self.enChiffresFrançais()
      case .ελληνικάΕλλάδα:
        return SemanticMarkup(self.σεΕλληνικάΨηφία())
      case .עברית־ישראל:
        return SemanticMarkup(self.בעברית־בספרות())
      }
    }).resolved()
  }
}
