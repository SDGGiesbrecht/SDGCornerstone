/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

  // MARK: - Difference Analysis

  @inlinable internal func longestCommonSubsequenceTable<C>(
    with other: C,
    by areEquivalent: (Element, Element) -> Bool,
    indexMapping: [Index],
    otherIndexMapping: [C.Index]
  ) -> [[Int]] where C: Collection, C.Element == Self.Element {
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
            table[prefixLength][otherPrefixLength] =
              table[prefixLength − 1][otherPrefixLength − 1]
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

  #warning("Temporarily disabled.")/*
  @inlinable internal func traceDifference<C>(
    _ table: [[Int]],
    other: C,
    by areEquivalent: (Element, Element) -> Bool,
    prefixLength: Int,
    otherPrefixLength: Int,
    differenceUnderConstruction: inout [CollectionDifference<Element>.Change],
    indexMapping: [Index],
    otherIndexMapping: [C.Index]
  ) where C: Collection, C.Element == Self.Element {

    // The “? :” prevents springing bounds. Such indices will not be queried anyway.
    let lastIndexDistance = prefixLength == 0 ? 0 : prefixLength − 1
    let otherLastIndexDistance = otherPrefixLength == 0 ? 0 : otherPrefixLength − 1

    let lastIndex = indexMapping[lastIndexDistance]
    let otherLastIndex = otherIndexMapping[otherLastIndexDistance]
    if prefixLength > 0
      ∧ otherPrefixLength > 0
      ∧ areEquivalent(self[lastIndex], other[otherLastIndex])
    {
      traceDifference(
        table,
        other: other,
        by: areEquivalent,
        prefixLength: prefixLength − 1,
        otherPrefixLength: otherPrefixLength − 1,
        differenceUnderConstruction: &differenceUnderConstruction,
        indexMapping: indexMapping,
        otherIndexMapping: otherIndexMapping
      )
    } else if otherPrefixLength > 0
      ∧ (prefixLength == 0
        ∨ table[prefixLength][(otherPrefixLength − 1) as Int]
        ≥ table[(prefixLength − 1) as Int][otherPrefixLength])
    {
      traceDifference(
        table,
        other: other,
        by: areEquivalent,
        prefixLength: prefixLength,
        otherPrefixLength: otherPrefixLength − 1,
        differenceUnderConstruction: &differenceUnderConstruction,
        indexMapping: indexMapping,
        otherIndexMapping: otherIndexMapping
      )
      differenceUnderConstruction.append(
        .insert(offset: otherLastIndexDistance, element: other[otherLastIndex], associatedWith: nil)
      )
    } else if prefixLength > 0
      ∧ (otherPrefixLength == 0
        ∨ table[prefixLength][(otherPrefixLength − 1) as Int]
        < table[(prefixLength − 1) as Int][otherPrefixLength])
    {
      traceDifference(
        table,
        other: other,
        by: areEquivalent,
        prefixLength: prefixLength − 1,
        otherPrefixLength: otherPrefixLength,
        differenceUnderConstruction: &differenceUnderConstruction,
        indexMapping: indexMapping,
        otherIndexMapping: otherIndexMapping
      )
      differenceUnderConstruction.append(
        .remove(offset: lastIndexDistance, element: self[lastIndex], associatedWith: nil)
      )
    }
  }

  @inlinable internal func changes<C>(
    toMake other: C,
    by areEquivalent: (Element, Element) -> Bool
  ) -> [CollectionDifference<Element>.Change]
  where C: Collection, C.Element == Self.Element {
    let indexMapping = [Index](indices)
    let otherIndexMapping = [C.Index](other.indices)
    let table = longestCommonSubsequenceTable(
      with: other,
      by: areEquivalent,
      indexMapping: indexMapping,
      otherIndexMapping: otherIndexMapping
    )
    var differenceUnderConstruction: [CollectionDifference<Element>.Change] = []
    traceDifference(
      table,
      other: other,
      by: areEquivalent,
      prefixLength: table.count − 1,
      otherPrefixLength: table.first!.count − 1,
      differenceUnderConstruction: &differenceUnderConstruction,
      indexMapping: indexMapping,
      otherIndexMapping: otherIndexMapping
    )
    return differenceUnderConstruction
  }*/
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

#warning("Temporarily disabled.")/*
extension Collection where Element: Hashable, Index: Hashable {

  /// Returns the collection as a `BjectiveMapping` between the indices and values.
  ///
  /// - Requires: No values are repeated.
  @inlinable public var bijectiveIndexMapping: BijectiveMapping<Index, Element> {
    return BijectiveMapping(indexMapping)
  }
}*/
