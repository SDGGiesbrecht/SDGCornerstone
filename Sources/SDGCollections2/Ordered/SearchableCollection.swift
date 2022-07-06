/*
 SearchableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// An ordered collection which can be searched for elements, subsequences and patterns.
///
/// - Requires: `SubSequence` must conform to `SearchableCollection` even though the compiler is currently incapable of enforcing it.
public protocol SearchableCollection: Collection, Pattern
where Element: Equatable, Searchable == Self /*, SubSequence: SearchableCollection */ {
  // #workaround(Swift 5.6.1, Should require SubSequence: SearchableCollection, but for Windows compiler bug. Remove “requires” documentation too when fixed.)
}

extension SearchableCollection {

  // MARK: - Pattern

  @inlinable public func matches(
    in collection: Self,
    at location: Index
  ) -> [Match] {
    if let match = primaryMatch(in: collection, at: location) {
      return [match]
    } else {
      return []
    }
  }

  @inlinable public func primaryMatch(
    in collection: Self,
    at location: Index
  ) -> AtomicPatternMatch<Self>? {

    var checkingIndex = self.startIndex
    var collectionIndex = location
    while checkingIndex ≠ self.endIndex {
      guard collectionIndex ≠ collection.endIndex else {
        // Ran out of space to check.
        return nil
      }

      if self[checkingIndex] ≠ collection[collectionIndex] {
        // Mis‐match.
        return nil
      }

      checkingIndex = self.index(after: checkingIndex)
      collectionIndex = collection.index(after: collectionIndex)
    }

    return AtomicPatternMatch(range: location..<collectionIndex, in: collection)
  }

  @inlinable public func forSubSequence() -> SubSequence {
    return self[...]
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<SubSequence>,
    in collection: Self
  ) -> AtomicPatternMatch<Self> {
    // #workaround(Swift 5.6.1, Should be commented line instead, but for compiler bug.)
    return AtomicPatternMatch(range: subSequenceMatch.range, in: collection)
    // return subSequenceMatch.in(collection)
  }
}
