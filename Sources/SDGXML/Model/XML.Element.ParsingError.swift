/*
 XML.Element.ParsingError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

extension XML.Element {

  public enum ParsingError: PresentableError {

    // MARK: - Cases

    case missingOpeningTag
    case missingClosingGreaterThanSign(unterminatedTag: StrictString)
    case missingClosingTag(unterminatedElement: StrictString)
    case mismatchedClosingTag(element: StrictString)
    case trailingText(text: StrictString)

    // MARK: - PresentableError

    public func presentableDescription() -> StrictString {
      return UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch self {
        case .missingOpeningTag:
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "The opening tag is missing."
          case .deutschDeutschland:
            return "Die öffnende Markierung fehlt."
          }
        case .missingClosingGreaterThanSign(let unterminatedTag):
          switch localization {
          case .englishUnitedKingdom:
            return "A tag is missing its greater‐than sign: ‘\(unterminatedTag)’"
          case .englishUnitedStates, .englishCanada:
            return "A tag is missing its greater‐than sign: “\(unterminatedTag)”"
          case .deutschDeutschland:
            return "Die Größer‐als‐Zeichen einer Markierung fehlt: „\(unterminatedTag)“"
          }
        case .missingClosingTag(let unterminatedElement):
          switch localization {
          case .englishUnitedKingdom:
            return "A closing tag is missing: ‘\(unterminatedElement)’"
          case .englishUnitedStates, .englishCanada:
            return "A closing tag is missing: “\(unterminatedElement)”"
          case .deutschDeutschland:
            return "Ein schließende Markierung fehlt: „\(unterminatedElement)“"
          }
        case .mismatchedClosingTag(let element):
          switch localization {
          case .englishUnitedKingdom:
            return "A closing tag is mismatched: ‘\(element)’"
          case .englishUnitedStates, .englishCanada:
            return "A closing tag is mismatched: “\(element)”"
          case .deutschDeutschland:
            return "Eine schließende Markierung is fehlangepasst: „\(element)“"
          }
        case .trailingText(let text):
          switch localization {
          case .englishUnitedKingdom:
            return "Invalid text trails after the element: ‘\(text)’"
          case .englishUnitedStates, .englishCanada:
            return "Invalid text trails after the element: “\(text)”"
          case .deutschDeutschland:
            return "Ungültiger Text folgt nach dem Element: „\(text)“"
          }
        }
      }).resolved()
    }
  }
}
