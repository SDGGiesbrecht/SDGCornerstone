/*
 GrammaticalGender.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// A grammatical gender used by languages that differentiate between masculine, feminine and neuter.
public enum GrammaticalGender: CodableViaEnumeration, Sendable {

  /// Masculine.
  case masculine

  /// Feminine.
  case feminine

  /// Neuter.
  case neuter

  // MARK: - CodableViaEnumeration

  public static let codingRepresentations: BijectiveMapping<GrammaticalGender, String> = BijectiveMapping(
    GrammaticalGender.allCases,
    map: { casing in
      switch casing {
      case .masculine:
        return "m"
      case .feminine:
        return "f"
      case .neuter:
        return "n"
      }
    }
  )
}
