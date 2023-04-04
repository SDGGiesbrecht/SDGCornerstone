/*
 CharacterSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension CharacterSet {

  /// A pattern representing any newline variant.
  ///
  /// - Parameters:
  ///   - searchableType: The collection type the pattern should target.
  public static func newlinePattern<Searchable>(
    for searchableType: Searchable.Type
  ) -> NewlinePattern<Searchable> {
    return Newline.pattern(for: searchableType)
  }
}
