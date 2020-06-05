/*
 MinDikduki.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.4, Should be “מין־דיקדוקי.swift” but for CMake normalization issue.)

// @localization(🇫🇷FR) @crossReference(מין־דיקדוקי)
/// Un genre grammatical utilisé par des langues qui distingent entre masculin et féminin.
public typealias GenreGrammatical = מין־דיקדוקי
// @localization(🇮🇱עב) @notLocalized(🇨🇦EN) @crossReference(מין־דיקדוקי)
/// מין דיקדוקי לשפה עם זכר ונקבה.
public enum מין־דיקדוקי: Hashable {

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
}
