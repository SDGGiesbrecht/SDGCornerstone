/*
 GrammatikiPtosi.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.4, Should be “ΓραμματικήΠτώση.swift” but for CMake normalization issue.)

import SDGCollections

public enum ΓραμματικήΠτώση: CodableViaEnumeration {

  /// Η ονομαστική.
  case ονομαστική

  /// Η αιτιατική.
  case αιτιατική

  /// Η γενική.
  case γενική

  /// Η κλητική.
  case κλητική

  // MARK: - CodableViaEnumeration

  public static let codingRepresentations = BijectiveMapping<ΓραμματικήΠτώση, String>(
    ΓραμματικήΠτώση.allCases,
    map: { casing in
      switch casing {
      case .ονομαστική:
        return "ονομαστική"
      case .αιτιατική:
        return "αιτιατική"
      case .γενική:
        return "γενική"
      case .κλητική:
        return "κλητική"
      }
    }
  )
}
