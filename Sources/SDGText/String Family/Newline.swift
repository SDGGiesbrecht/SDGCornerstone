/*
 Newline.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import struct Foundation.CharacterSet

/// A pattern representing any newline variant.
public enum Newline {

  // MARK: - Static Properties

  @usableFromInline internal static let carriageReturn: Unicode.Scalar = "\u{D}"
  @usableFromInline internal static let lineFeed: Unicode.Scalar = "\u{A}"
  @usableFromInline internal static let characters = CharacterSet.newlines

  /// Creates a newline pattern for searching in a particular type of collection.
  ///
  /// - Parameters:
  ///   - searchableType: The collection type the pattern should target.
  @inlinable public static func pattern<Searchable>(
    for searchableType: Searchable.Type
  ) -> NewlinePattern<Searchable> {
    return NewlinePattern<Searchable>(
      carriageReturnLineFeed: (carriageReturn, lineFeed)
    )
  }
}
