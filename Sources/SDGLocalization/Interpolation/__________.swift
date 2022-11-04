/*
 __________.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.7.1, Should be “מין־דקדוקי.swift” but for Windows bug.)

import SDGCollections

// @localization(🇫🇷FR) @notLocalized(🇨🇦EN) @crossReference(מין־דקדוקי)
/// Un genre grammatical utilisé par des langues qui distingent entre masculin et féminin.
public typealias GenreGrammatical = מין־דקדוקי
// @localization(🇮🇱עב) @notLocalized(🇨🇦EN) @crossReference(מין־דקדוקי)
/// מין דקדוקי לשפה עם זכר ונקבה.
public enum מין־דקדוקי: CodableViaEnumeration, Sendable {

  /// זכר.
  case זכר
  /// Masculin.
  public static var masculin: GenreGrammatical {
    return .זכר
  }

  /// נקבה.
  case נקבה
  /// Féminin.
  public static var féminin: GenreGrammatical {
    return .נקבה
  }

  // MARK: - CodableViaEnumeration

  public static let codingRepresentations = BijectiveMapping<מין־דקדוקי, String>(
    מין־דקדוקי.allCases,
    map: { casing in
      switch casing {
      case .זכר:
        return "ז׳"
      case .נקבה:
        return "נ׳"
      }
    }
  )
}
