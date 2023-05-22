/*
 GrammaticalNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// A grammatical number used by languages that distinguish only between singular and plural.
public enum GrammaticalNumber: CodableViaEnumeration, Sendable {

  /// Singular.
  case singular

  /// Plural.
  case plural

  // MARK: - CodableViaEnumeration

  public static let codingRepresentations = BijectiveMapping<
    GrammaticalNumber, String
  >(
    GrammaticalNumber.allCases,
    map: { casing in
      switch casing {
      case .singular:
        return "1"
      case .plural:
        return "2"
      }
    }
  )
}
