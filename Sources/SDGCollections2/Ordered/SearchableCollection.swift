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

  // #workaround(Swift 5.6.1, Needed to dodge Windows compiler bug; remove all conformances too.)
  /// Returns the first match for the pattern in the sub‐sequence.
  ///
  /// The implementation of this method must be `return subSequence.firstMatch(for: pattern)`, which the Windows compiler is unable to do from a default implementation due to a compiler bug.
  ///
  /// - Warning: Never call this method directly. It will be removed from the protocol as soon as the compiler is repaired, and that will be versioned as a bug fix, not a breaking change.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  ///     - subSequence: The subSequence.
  func temporaryWorkaroundFirstMatch<P>(for pattern: P, in subSequence: SubSequence) -> P.Match?
  where P: Pattern, P.Searchable == SubSequence

  // @documentation(SDGCornerstone.Collection.firstMatch(for:))
  /// Returns the first match for `pattern` in the collection.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func firstMatch<P>(for pattern: P) -> P.Match?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.firstMatch(for:))
  /// Returns the first match for `pattern` in the collection.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func firstMatch(for pattern: Self) -> Match?

  // @documentation(SDGCornerstone.Collection.matches(for:))
  /// Returns a list of all matches for `pattern` in the collection.
  ///
  /// This does not check for overlapping matches.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func matches<P>(for pattern: P) -> [P.Match]
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.matches(for:))
  /// Returns a list of all matches for `pattern` in the collection.
  ///
  /// This does not check for overlapping matches.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func matches(for pattern: Self) -> [Match]

  // @documentation(SDGCornerstone.Collection.prefix(upTo:))
  /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func prefix<P>(upTo pattern: P) -> ExclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.prefix(upTo:))
  /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func prefix(upTo pattern: Self) -> ExclusivePrefixMatch<Match>?

  // @documentation(SDGCornerstone.Collection.prefix(through:))
  /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func prefix<P>(through pattern: P) -> InclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.prefix(through:))
  /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func prefix(through pattern: Self) -> InclusivePrefixMatch<Match>?

  // @documentation(SDGCornerstone.Collection.suffix(from:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func suffix<P>(from pattern: P) -> InclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.suffix(from:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func suffix(from pattern: Self) -> InclusiveSuffixMatch<Match>?

  // @documentation(SDGCornerstone.Collection.suffix(after:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func suffix<P>(after pattern: P) -> ExclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.suffix(after:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func suffix(after pattern: Self) -> ExclusiveSuffixMatch<Match>?

  // @documentation(SDGCornerstone.Collection.components(separatedBy:))
  /// Returns the segments of `self` separated by instances of `pattern`.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func components<P>(separatedBy pattern: P) -> [SeparatedMatch<P.Match>]
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.components(separatedBy:))
  /// Returns the segments of `self` separated by instances of `pattern`.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func components(separatedBy pattern: Self) -> [SeparatedMatch<Match>]

  // @documentation(SDGCornerstone.Collection.contains(pattern:))
  /// Returns `true` if `self` contains an match for `pattern`.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func contains<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.contains(pattern:))
  /// Returns `true` if `self` contains an match for `pattern`.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func contains(_ pattern: Self) -> Bool

  // @documentation(SDGCornerstone.Collection.hasPrefix(_:))
  /// Returns `true` if `self` begins with `pattern`.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to try.
  func hasPrefix<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.hasPrefix(_:))
  /// Returns `true` if `self` begins with `pattern`.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to try.
  func hasPrefix(_ pattern: Self) -> Bool

  // @documentation(SDGCornerstone.Collection.isMatch(for:))
  /// Returns `true` if the whole collection matches the specified pattern.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to try.
  func isMatch<P>(for pattern: P) -> Bool where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.isMatch(for:))
  /// Returns `true` if the whole collection matches the specified pattern.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to try.
  func isMatch(for pattern: Self) -> Bool

  // @documentation(SDGCornerstone.Collection.commonPrefix(with:))
  /// Returns the longest prefix subsequence shared with the other collection.
  ///
  /// - Parameters:
  ///     - other: The other collection
  func commonPrefix<C: SearchableCollection>(with other: C) -> AtomicPatternMatch<Self>
  where C.Element == Self.Element
  // #documentation(SDGCornerstone.Collection.commonPrefix(with:))
  /// Returns the longest prefix subsequence shared with the other collection.
  ///
  /// - Parameters:
  ///     - other: The other collection
  func commonPrefix(with other: Self) -> AtomicPatternMatch<Self>

  // @documentation(SDGCornerstone.Collection.advance(_: over:))
  /// Advances the index over the pattern.
  ///
  /// - Parameters:
  ///     - index: The index to advance.
  ///     - pattern: The pattern to advance over.
  ///
  /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
  @discardableResult func advance<P>(_ index: inout Index, over pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.advance(_: over:))
  /// Advances the index over the pattern.
  ///
  /// - Parameters:
  ///     - index: The index to advance.
  ///     - pattern: The pattern to advance over.
  ///
  /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
  @discardableResult func advance(_ index: inout Index, over pattern: Self) -> Bool
}

extension SearchableCollection {

  @inlinable internal func _firstMatch<P>(for pattern: P) -> P.Match?
  where P: Pattern, P.Searchable == Self {
    var i = startIndex
    while i ≠ endIndex {
      if let match = pattern.primaryMatch(in: self, at: i) {
        return match
      }
      i = index(after: i)
    }
    return nil
  }
  @inlinable public func firstMatch<P>(for pattern: P) -> P.Match?
  where P: Pattern, P.Searchable == Self {
    return _firstMatch(for: pattern)
  }
  @inlinable public func firstMatch(for pattern: Self) -> Match? {
    return _firstMatch(for: pattern)
  }

  @inlinable internal func _matches<P>(for pattern: P) -> [P.Match]
  where P: Pattern, P.Searchable == Self {
    let subsequencePattern = pattern.forSubSequence()
    var accountedFor = startIndex
    var results: [P.Match] = []
    while let match = temporaryWorkaroundFirstMatch(
      for: subsequencePattern,
      in: self[accountedFor...]
    ) {
      accountedFor = match.range.upperBound
      results.append(pattern.convertMatch(from: match, in: self))
    }
    return results
  }
  @inlinable public func matches<P>(for pattern: P) -> [P.Match]
  where P: Pattern, P.Searchable == Self {
    return _matches(for: pattern)
  }
  @inlinable public func matches(for pattern: Self) -> [Match]
  where SubSequence: SearchableCollection {
    return _matches(for: pattern)
  }

  @inlinable internal func _prefix<P>(upTo pattern: P) -> ExclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    guard let match = firstMatch(for: pattern) else {
      return nil
    }
    return ExclusivePrefixMatch(match: match, in: self)
  }
  @inlinable public func prefix<P>(upTo pattern: P) -> ExclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    return _prefix(upTo: pattern)
  }
  @inlinable public func prefix(upTo pattern: Self) -> ExclusivePrefixMatch<Match>? {
    return _prefix(upTo: pattern)
  }

  @inlinable internal func _prefix<P>(through pattern: P) -> InclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    guard let match = firstMatch(for: pattern) else {
      return nil
    }
    return InclusivePrefixMatch(match: match, in: self)
  }
  @inlinable public func prefix<P>(through pattern: P) -> InclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    return _prefix(through: pattern)
  }
  @inlinable public func prefix(through pattern: Self) -> InclusivePrefixMatch<Match>? {
    return _prefix(through: pattern)
  }

  @inlinable internal func _suffix<P>(from pattern: P) -> InclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    guard let match = firstMatch(for: pattern) else {
      return nil
    }
    return InclusiveSuffixMatch(match: match, in: self)
  }
  @inlinable public func suffix<P>(from pattern: P) -> InclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    return _suffix(from: pattern)
  }
  @inlinable public func suffix(from pattern: Self) -> InclusiveSuffixMatch<Match>? {
    return _suffix(from: pattern)
  }

  @inlinable internal func _suffix<P>(after pattern: P) -> ExclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    guard let match = firstMatch(for: pattern) else {
      return nil
    }
    return ExclusiveSuffixMatch(match: match, in: self)
  }
  @inlinable public func suffix<P>(after pattern: P) -> ExclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    return _suffix(after: pattern)
  }
  @inlinable public func suffix(after pattern: Self) -> ExclusiveSuffixMatch<Match>? {
    return _suffix(after: pattern)
  }

  @inlinable internal func _components<P>(separatedBy pattern: P) -> [SeparatedMatch<P.Match>]
  where P: Pattern, P.Searchable == Self {
    let separators = matches(for: pattern)
    var previousIndex = startIndex
    var components: [SeparatedMatch<P.Match>] = separators.map { separator in
      defer { previousIndex = separator.range.upperBound }
      return SeparatedMatch(start: previousIndex, match: separator, in: self)
    }
    components.append(SeparatedMatch(start: previousIndex, match: nil, in: self))
    return components
  }
  @inlinable public func components<P>(separatedBy pattern: P) -> [SeparatedMatch<P.Match>]
  where P: Pattern, P.Searchable == Self {
    return _components(separatedBy: pattern)
  }
  @inlinable public func components(separatedBy pattern: Self) -> [SeparatedMatch<Match>] {
    return _components(separatedBy: pattern)
  }

  @inlinable internal func _contains<P>(_ pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self {
    return firstMatch(for: pattern) ≠ nil
  }
  @inlinable public func contains<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self {
    return _contains(pattern)
  }
  @inlinable public func contains(_ pattern: Self) -> Bool {
    return _contains(pattern)
  }

  @inlinable public func _hasPrefix<P>(_ pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self {
    return pattern.primaryMatch(in: self, at: startIndex) ≠ nil
  }
  @inlinable public func hasPrefix<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self {
    return _hasPrefix(pattern)
  }
  @inlinable public func hasPrefix(_ pattern: Self) -> Bool {
    return _hasPrefix(pattern)
  }

  @inlinable public func _isMatch<P>(for pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self {
    return pattern.matches(in: self, at: startIndex)
      .contains(where: { $0.range.upperBound == endIndex })
  }
  @inlinable public func isMatch<P>(for pattern: P) -> Bool where P: Pattern, P.Searchable == Self {
    return _isMatch(for: pattern)
  }
  @inlinable public func isMatch(for pattern: Self) -> Bool {
    return elementsEqual(pattern)
  }

  @inlinable internal func _commonPrefix<C: SearchableCollection>(
    with other: C
  ) -> AtomicPatternMatch<Self> where C.Element == Self.Element {
    var end: Index = startIndex
    for (ownIndex, otherIndex) in zip(indices, other.indices) {
      if self[ownIndex] == other[otherIndex] {
        end = index(after: end)
      } else {
        break
      }
    }
    return AtomicPatternMatch(range: ..<end, in: self)
  }
  @inlinable public func commonPrefix<C: SearchableCollection>(
    with other: C
  ) -> AtomicPatternMatch<Self>
  where C.Element == Self.Element {
    return _commonPrefix(with: other)
  }
  @inlinable public func commonPrefix(with other: Self) -> AtomicPatternMatch<Self> {
    return _commonPrefix(with: other)
  }

  @inlinable internal func _advance<P>(_ index: inout Index, over pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self {
    if let match = pattern.primaryMatch(in: self, at: index) {
      index = match.range.upperBound
      return true
    } else {
      return false
    }
  }
  @inlinable @discardableResult public func advance<P>(
    _ index: inout Index,
    over pattern: P
  ) -> Bool where P: Pattern, P.Searchable == Self {
    return _advance(&index, over: pattern)
  }
  @inlinable @discardableResult public func advance(
    _ index: inout Index,
    over pattern: Self
  ) -> Bool {
    return _advance(&index, over: pattern)
  }

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
