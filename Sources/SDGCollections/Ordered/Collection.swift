/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

extension Collection {

  // MARK: - Indices

  /// Returns the range for all of `self`.
  @inlinable public var bounds: Range<Index> {
    return startIndex..<endIndex
  }

  @inlinable internal func longestCommonSubsequenceTable<C>(
    with other: C,
    by areEquivalent: (Element, Element) -> Bool,
    indexMapping: [Index],
    otherIndexMapping: [C.Index]
  ) -> [[Int]] where C: SearchableCollection, C.Element == Self.Element {
    let row = [Int](repeating: 0, count: otherIndexMapping.count + 1)
    var table = [[Int]](repeating: row, count: indexMapping.count + 1)
    if ¬isEmpty ∧ ¬other.isEmpty {
      for prefixLength in 1...indexMapping.count {
        for otherPrefixLength in 1...otherIndexMapping.count {
          let lastIndexDistance = prefixLength − 1
          let otherLastIndexDistance = otherPrefixLength − 1
          let lastIndex = indexMapping[lastIndexDistance]
          let otherLastIndex = otherIndexMapping[otherLastIndexDistance]
          if areEquivalent(self[lastIndex], other[otherLastIndex]) {
            table[prefixLength][otherPrefixLength] = table[prefixLength − 1][otherPrefixLength − 1]
              + 1
          } else {
            table[prefixLength][otherPrefixLength] = Swift.max(
              table[prefixLength][otherPrefixLength − 1],
              table[prefixLength − 1][otherPrefixLength]
            )
          }
        }
      }
    }
    return table
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
