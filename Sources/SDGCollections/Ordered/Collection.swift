/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Collection {

  // MARK: - Indices

  /// Returns the range for all of `self`.
  @inlinable public var bounds: Range<Index> {
    return startIndex..<endIndex
  }
}

extension Collection where Index: Hashable {

  /// Returns the collection as a `Dictionary`, with the collection’s indices used as keys.
  @inlinable public var indexMapping: [Index: Element] {
    var mapping: [Index: Element] = [:]
    for index in indices {
      mapping[index] = self[index]
    }
    return mapping
  }
}

extension Collection where Element: Hashable, Index: Hashable {

  /// Returns the collection as a `BjectiveMapping` between the indices and values.
  ///
  /// - Requires: No values are repeated.
  @inlinable public var bijectiveIndexMapping: BijectiveMapping<Index, Element> {
    return BijectiveMapping(indexMapping)
  }
}
